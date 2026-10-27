# ADR-0002: Rotación de la clave de firma (2026-10-27)

## Contexto
La clave anterior (`76AFFCC217DB9FC4`, fpr `CD92AB07B1D24DC9A74EB60E76AFFCC217DB9FC4`; también se vio `D5E75EAC51A44715`)
solo existía como secret ilegible en `robert-flo/omarchy-pkgs`. Tras ADR-0001 hacía falta en este repo y no se pudo recuperar.

## Decisión
- Clave nueva RSA 4096, sin expiración, sin passphrase (CI), según ADR-006 de fork-docs:
  `Omarchy Personal Repo <25asab015@ujmd.edu.sv>`, fpr **`14EDEAC8B295BB30CA6249A9E954119B629B58F6`**.
- Privada: secret `GPG_PRIVATE_KEY` de este repo + respaldo fuera de git (ver fork-docs ADR-006).
- Pública: `keys/omarchy-personal-repo.pub.asc` en `main`; `bin/release --publish` la copia a `gh-pages`
  (https://robert-flo.github.io/omarchy-personal-repo/keys/omarchy-personal-repo.pub.asc).
- `bin/release` refirma los paquetes reusados cuya firma publicada no es de la clave actual
  (mismo binario, firma nueva) y sube con `--clobber` las `.sig` de assets grandes.
- La clave vieja queda retirada.

## Consecuencias
Cada PC debe importar y firmar localmente la clave nueva con `pacman-key` (ver fork-docs).
