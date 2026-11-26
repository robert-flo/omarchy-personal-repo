# Maintainer: Roberto Flores <robert-flo>
pkgname=ravn-webapps
pkgver=1.1.6
pkgrel=1
pkgdesc='Universal web application launchers, icons and runtime launcher for the RaVN workstation'
arch=('any')
url='https://github.com/robert-flo/ravn-webapps'
license=('MIT')
options=('!debug')
depends=('bash' 'hicolor-icon-theme')
optdepends=(
  'google-chrome: Google Chrome browser'
  'brave-bin: Brave browser'
  'chromium: Open source Chromium browser'
  'microsoft-edge-stable-bin: Microsoft Edge browser'
  'uwsm: Wayland Systemd Session Manager for app cgroup isolation'
)
source=(
  "${pkgname}-${pkgver}.tar.gz::${url}/archive/refs/tags/v${pkgver}.tar.gz"
)
sha256sums=(
  'b29df8e80620c471ddb14752e3218d9fc45b798f0d1208515795b2ccfff32cc0'
)

package() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  make DESTDIR="${pkgdir}" install
}
