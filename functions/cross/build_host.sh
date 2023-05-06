relative_source ../prepare/prepare_pkg/should_build.sh

build_host() {
  if [[ -d "${dir_build_cross}" ]]; then
    echo " => Building host part for cross build packages"
    pushd "${dir_build_cross}" > /dev/null
    local build_pkg
    for build_pkg in *; do
      if [[ -d "${build_pkg}" ]]; then
        dir_build_pkg="${dir_build}/${build_pkg}"
        if [[ -d "${dir_build_pkg}" ]]; then
          pushd "${dir_build_pkg}" > /dev/null
          if should_build "${build_pkg}"; then
            pushd "${build_pkg}" > /dev/null
            ./build.sh
            popd > /dev/null
          fi
          popd > /dev/null
        else
          echo "  -> Ignored cross package ${build_pkg} since we did no find its generic counterpart under ${dir_build}"
        fi
      fi
    done
    popd > /dev/null
  fi
  echo " => Built all host parts for cross build packages"
}