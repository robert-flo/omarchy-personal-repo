# omarchy-personal-repo

Rama `main`: fuentes (PKGBUILDs, scripts, workflow). Rama `gh-pages`: salida publicada (repo pacman `[omarchy-personal]`).

## Cómo publicar
- Cambia un PKGBUILD en `pkgbuilds/` por PR. CI hace dry-run; al hacer merge se firma y se publica.
- omarchy/omarchy-settings: `bin/pin-omarchy 4.0.7` → PR.
- Fallback local: `GPG_KEY_ID=<id> PAGES_DIR=<checkout gh-pages> bin/release --publish` (docker o podman).
- Decisión: [ADR-0001](docs/adr/0001-build-firma-publicacion-en-repo-no-fork.md).
