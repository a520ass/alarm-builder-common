build_host() {
  if [[ -d "${dir_build_cross}" ]]; then
    echo " => Building host part for cross build packages"
    pushd "${dir_build_cross}"
    local build_pkg
    for build_pkg in *; do
      if [[ -d "${build_pkg}" ]]; then
        if [[ -d "${build_pkg}/host" && -d "${build_pkg}/guest" ]]; then
          pushd "${build_pkg}/host"
            local pkgname
            export
          popd
        else
          echo "  -> Not both host and guest for ${build_pkg} exist"
          return 1
        fi
      fi
    done
    popd
  fi
}