build_host() {
  if [[ -d "${dir_build_cross}" ]]; then
    echo " => Building host part for cross build packages"
    pushd "${dir_build_cross}"
    local build_pkg
    for build_pkg in *; do
      if [[ -d "${build_pkg}" ]]; then
        if [[ -d  ${dir_build}/${build_pkg} ]]; then
          pushd "${build_pkg}"
          ./build.sh
          popd
        else
          echo "  -> Ignored cross package ${build_pkg} since we did no find its generic counterpart under ${dir_build}"
          return 1
        fi
      fi
    done
    popd
  fi
}