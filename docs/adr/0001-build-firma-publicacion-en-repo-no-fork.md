# ADR-0001 — Build, firma y publicación del repo personal en `omarchy-personal-repo` (opción D)

- **Estado:** Aceptada (Roberto, 2026-10-27)
- **Reemplaza:** el flujo `release-personal.yml` del fork `robert-flo/omarchy-pkgs`.

## Contexto
- El ring personal (`[omarchy-personal]`, antes de `[omarchy]` en pacman.conf) se construía en el
  fork `robert-flo/omarchy-pkgs` con `release-personal.yml` y se publicaba aquí (gh-pages +
  release `pkg-stable`).
- GitHub desactivó Actions en el fork ("to reduce compute wasted"). Medido del 13 al 26-oct-2026:
  - 15 runs de `build-pr.yml` heredado: el job x86_64 esperaba horas a un runner
    `self-hosted, omarchy-builder` que el fork no tiene (≈1863 min de reloj, 5 cancelados) y
    corría aarch64 sin necesidad.
  - 16 runs de `release-personal`, 12 fallidos (a diario del 18 al 25-oct).
  - 2 crons diarios (sync-check, sync-branches).
- El fork hereda 17 workflows de upstream; cada merge de upstream puede reintroducir crons
  o workflows nuevos activos.
- `release-personal.yml` hacía rebase de `robert-flo/omarchy personal` + `push --force-with-lease`,
  con 4 secrets (GPG, 2 deploy keys, PAT) para escribir en tres repos.

## Decisión
1. Las fuentes del ring personal viven en la rama `main` de este repo (`pkgbuilds/`), y
   `gh-pages` queda solo como salida. `main` es la rama por defecto (`workflow_dispatch` lo exige);
   Pages sigue sirviendo `gh-pages`.
2. Un único workflow, `release.yml`: dry-run en PR; firma y publica en push a `main`
   (paths `pkgbuilds/**`, `bin/**`) o por dispatch. Sin cron, sin rebase y sin pushes a otros repos.
   Usa `GITHUB_TOKEN`. El único secret es `GPG_PRIVATE_KEY`.
3. `bin/release` es el mismo camino en CI y en local (fallback opción B: docker/podman +
   `GPG_KEY_ID` de una clave descifrada con age a un `GNUPGHOME` efímero, sin passphrase en disco).
   Reutiliza el binario y la firma publicados si la versión no cambió; solo construye lo que
   cambió de pkgver/pkgrel.
4. omarchy/omarchy-settings: `bin/pin-omarchy <pkgver> [commit]` lee en solo lectura los PKGBUILD
   de `omacom/omarchy-pkgs` master, reapunta la fuente a `robert-flo/omarchy` y aplica pkgrel §5.3
   (pkgver nuevo → 99; mismo pkgver → +1). El resultado entra por PR. Hay un guard contra el
   estable oficial.
5. `robert-flo/omarchy personal` se sincroniza con upstream **por merge**, nunca con
   rebase/force-push.
6. En el fork `omarchy-pkgs` se desactivó Actions; ahora solo sirve para seguir a upstream.
   Sus secrets se borran cuando este flujo publique bien.

## Consecuencias
- Sin herencia de workflows ni riesgo de re-desactivación como fork. Repo privado: consume
  minutos del plan (~10–20 min por release; Pages en repo privado requiere plan de pago).
- pacman.conf no cambia (misma URL de Pages y mismo release `pkg-stable`).
- Sincronizar PKGBUILDs de upstream (omarchy) pasa a ser un paso explícito (`bin/pin-omarchy` + PR).
- La clave GPG (`76AFFCC217DB9FC4`, ADR-006 del scratchpad) se carga como secret aquí; si
  no hay copia fuera del secret del fork, hay que rotarla (ADR-006, pasos 1–6).
