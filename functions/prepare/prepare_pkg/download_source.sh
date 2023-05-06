relative_source should_build.sh
download_source() {
  echo " => Downloading source before build"
  pushd "${dir_build}" > /dev/null
  local build_pkg
  for build_pkg in "${dir_build}"; do
    if [[ -d "${build_pkg}" ]]; then
      pushd "${build_pkg}" > /dev/null
      echo " => Downloading source for ${build_pkg} before cross build.."
      makepkg --ignorearch --nodeps --nobuild
      popd > /dev/null
    fi
  done
  popd > /dev/null
  echo " => Downloaded all sources before cross build"
}