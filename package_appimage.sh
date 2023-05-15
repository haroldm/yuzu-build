
APPIMAGE_NAME="yuzu.AppImage"

# Build an AppImage
cd build

wget -nc https://github.com/yuzu-emu/ext-linux-bin/raw/main/appimage/appimagetool-x86_64.AppImage
chmod 755 appimagetool-x86_64.AppImage

# if FUSE is not available, then fallback to extract and run
if ! ./appimagetool-x86_64.AppImage --version; then
    export APPIMAGE_EXTRACT_AND_RUN=1
fi

# Don't let AppImageLauncher ask to integrate EA
echo "X-AppImage-Integrate=false" >> AppDir/org.yuzu_emu.yuzu.desktop

./appimagetool-x86_64.AppImage AppDir "${APPIMAGE_NAME}"

cd ..

# Copy the AppImage and update info to the artifacts directory and avoid compressing it
cp "build/${APPIMAGE_NAME}" "${ARTIFACTS_DIR}/"
