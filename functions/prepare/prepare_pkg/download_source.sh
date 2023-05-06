relative_source should_build.sh
download_source() {
  echo " => Downloading source before build"
  pushd "${dir_build}"
  local build_pkg
  for build_pkg in "${dir_build}"; do
    if [[ -d "${build_pkg}" ]]; then
      pushd "${build_pkg}"
      if should_build "${build_pkg}"; then
        echo " => Downloading source for ${build_pkg} before cross build.."
        makepkg --ignorearch --nodeps --nobuild
      fi
      popd
    fi
  done
  popd
  echo " => Downloaded all sources before cross build"
}