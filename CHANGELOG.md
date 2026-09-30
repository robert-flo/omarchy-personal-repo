# Personal Pacman Repository Changelog

This document tracks all releases, configuration changes, and maintenance updates applied to the **`omarchy-personal-repo`** pacman repository hosted via GitHub Pages.

## [2026-09-30]

### `68bbb38` — publish: v4.0.4-99 (GPG Key Rotation & v4.0.4 Publication)

- **Commit Hash:** [`68bbb3833d0c9b470c8ddf02865e812e3e8e4602`](https://github.com/robert-flo/omarchy-personal-repo/commit/68bbb3833d0c9b470c8ddf02865e812e3e8e4602)
- **Branch:** `gh-pages`

#### What was changed:
1. **Binary Package Upgrades:**
   - Promoted `omarchy` to `4.0.4-99-any.pkg.tar.zst` (66.2 MB) with version shading over official `4.0.4-1`.
   - Promoted `omarchy-settings` to `4.0.4-99-any.pkg.tar.zst` (747 KB) in lockstep.
2. **Cryptographic Signatures & Database Generation:**
   - Regenerated and resigned database indices: `omarchy.db`, `omarchy.files`, `omarchy-personal.db`, `omarchy-personal.files`.
   - Signed all packages and databases using rotated dedicated GPG key `CD92AB07B1D24DC9A74EB60E76AFFCC217DB9FC4`.
3. **Live CDN Verification:**
   - Confirmed HTTP 200 delivery of binaries and detached PGP armor signatures via GitHub Pages CDN.

---

## [2026-09-29]

### `1e04085` — feat: add .nojekyll and index.html for GitHub Pages

- **Commit Hash:** [`1e04085e7a67b918d813c3bbacb81900bcc251c2`](https://github.com/robert-flo/omarchy-personal-repo/commit/1e04085e7a67b918d813c3bbacb81900bcc251c2)
- **Branch:** `gh-pages`
- **Parent Commit:** `475cee8b60389ba6e8c75d69eb07077a296b0c2e`

#### What was changed:
1. **`.nojekyll`**:
   - Added empty `.nojekyll` file at the root of the `gh-pages` branch.
2. **`index.html`**:
   - Added clean landing page explaining the repository and providing the standard pacman configuration block:
     ```ini
     [omarchy-personal]
     Server = https://robert-flo.github.io/omarchy-personal-repo/stable/$arch
     ```
3. **Repository Infrastructure & Deployment:**
   - Provisioned public GitHub repository `robert-flo/omarchy-personal-repo`.
   - Pushed `gh-pages` branch and enabled GitHub Pages deployment serving directly from root `/`.

#### Why it was done (Rationale):
- **Bypass Jekyll Processing:** GitHub Pages processes repositories through Jekyll by default. Jekyll ignores dotfiles (e.g. `.release.lock`) and can alter MIME types or return 404s for pacman binary databases (`.db`, `.files`), package tarballs (`.pkg.tar.zst`), and PGP signatures (`.sig`). Adding `.nojekyll` forces GitHub Pages / Fastly CDN to serve all static artifacts unaltered.
- **Pacman Package Delivery:** Enables Arch Linux `pacman` and `omarchy update` across all machines to reliably fetch signed packages from `https://robert-flo.github.io/omarchy-personal-repo/stable/x86_64/`.
- **Verified GPG Integrity:** Validated live database download and cryptographic signature against the official personal public key (`D5E75EAC51A44715`).
