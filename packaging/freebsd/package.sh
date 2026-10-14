#!/usr/bin/env bash
# Build and package FreeANDIY Slides for FreeBSD:
#
#   $DIST/freeandiy-slides-<version>-freebsd-<arch>.tar.gz   bin/, share/ (desktop entry, icons, AppStream)
#
# Usage: packaging/freebsd/package.sh [--skip-build]
#
# Run on FreeBSD (CI: a FreeBSD 14 VM via vmactions/freebsd-vm). Runtime needs: libxkbcommon,
# wayland or libX11, mesa (Vulkan or EGL) and alsa-lib:
# `pkg install libxkbcommon libX11 mesa-libs vulkan-loader alsa-lib`.
set -euo pipefail
# shellcheck source=../common.sh
. "$(dirname "${BASH_SOURCE[0]}")/../common.sh"
LINUX="$ROOT/packaging/linux"
APP_ID=agency.freeandy.slides

if [ "${1:-}" != "--skip-build" ]; then
  (cd "$ROOT" && cargo build --release --locked -p deckcraft -p deckcraft-cli)
fi

ARCH="$(uname -m)"
case "$ARCH" in
  amd64) ARCH=x86_64 ;;
  arm64) ARCH=aarch64 ;;
esac
BIN="$CARGO_TARGET_DIR/release"
NAME="freeandiy-slides-$VERSION-freebsd-$ARCH"
WORK="$CARGO_TARGET_DIR/freebsd-package"
STAGE="$WORK/$NAME"
rm -rf "$WORK"
mkdir -p "$STAGE/bin" "$STAGE/share/applications" "$STAGE/share/metainfo" "$STAGE/share/mime/packages" "$STAGE/share/icons" "$STAGE/share/doc/freeandiy-slides"

install -m 755 "$BIN/freeandiy-slides" "$BIN/freeandiy-slides-cli" "$STAGE/bin/"
strip "$STAGE/bin/freeandiy-slides" "$STAGE/bin/freeandiy-slides-cli" 2>/dev/null || true
install -m 644 "$LINUX/$APP_ID.desktop" "$STAGE/share/applications/"
install -m 644 "$LINUX/$APP_ID.mime.xml" "$STAGE/share/mime/packages/$APP_ID.xml"
sed -e "s/@VERSION@/$VERSION/g" -e "s/@DATE@/$DECKCRAFT_BUILD_DATE/g" \
  "$LINUX/$APP_ID.metainfo.xml.in" >"$STAGE/share/metainfo/$APP_ID.metainfo.xml"
cp -R "$ROOT/assets/app-icon/hicolor" "$STAGE/share/icons/"
copy_docs "$STAGE/share/doc/freeandiy-slides"

tar -C "$WORK" -czf "$DIST/$NAME.tar.gz" "$NAME"
"$STAGE/bin/freeandiy-slides-cli" --version
echo "wrote $DIST/$NAME.tar.gz"
ls -lh "$DIST/$NAME.tar.gz"
