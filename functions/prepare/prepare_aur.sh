. common/functions/prepare/prepare_aur/should_build_aur.sh
. common/functions/prepare/prepare_aur/move_built_to_pkg.sh

prepare_aur() {
  echo " => Preparing AUR packages..."
  echo "  -> Cleaning AUR build dir..."
  find "${dir_aur}" -maxdepth 2 -name '*-aarch64.pkg.tar' -exec rm -rf {} \;
  echo "  -> Preparing package storage dir..."
  mkdir -p "${dir_pkg}"
  if compgen -G "${dir_pkg}/"* &>/dev/null && ! chmod u+x "${dir_pkg}/"*; then
    # We use executable permission to do two things:
    #  1. The user must be the owner of the file to run chmod u+x, so this bails out if it is not owned by the user
    #  2. We use it as a pseudo un-check flag, after checking the x permission will be removed from a file, so we
    #     can just remove all of the files that's still executable
    echo "  -> Failed to mark all existing package files are executable to use as check flag"
    exit 1
  fi
  local dir_pkg_absolute=$(readlink -f "${dir_pkg}")
  local PKGEXT=.pkg.tar
  export PKGEXT
  pushd "${dir_aur}"
  for aur_pkg in *; do
    if [[ ! -d "${aur_pkg}" ]]; then
      continue
    fi
    pushd "${aur_pkg}"
    if should_build_aur "${aur_pkg}"; then
      echo "  -> Building AUR package ${aur_pkg}..."
      local retry=3
      local success=''
      while [[ ${retry} -ge 0 ]]; do
        makepkg -cfsAC
        if [[ $? == 0 ]]; then
          success='yes'
          break
        fi
        echo "  -> Retrying to build AUR package ${aur_pkg}, retries left: ${retry}"
      done
      if [[ -z "${success}" ]]; then
        echo "  -> Failed to build AUR package ${aur_pkg} after 3 retries"
        exit 1
      fi
      move_built_to_pkg "${aur_pkg}" "${dir_pkg_absolute}"
    fi
    popd
  done
  popd
  local i
  for i in "${dir_pkg}/"*; do
    if [[ -x "${i}" ]]; then
      rm -f "${i}"
    fi
  done
  echo " => AUR packages prepared"
}