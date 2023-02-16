pacstrap_from_repo() {
  if [[ "${#pacstrap_from_repo_pkgs[@]}" == 0 ]]; then
    return
  fi
  echo " => Pacstrapping following packages from repo into ${dir_root}..."
  local pkg_line pkg_names=()
  for pkg_line in "${pacstrap_from_repo_pkgs[@]}"; do 
    echo "  -> ${pkg_line}"
    pkg_names+=("${pkg_line%%:*}")
  done
  sudo pacstrap "${dir_root}" "${pkg_names[@]}"
  echo " => Pacstrap base done"
}