pacstrap_built() {
  echo " => Pacstrapping built packages into ${dir_root}..."
  if compgen "${dir_pkg}/*" > /dev/null; then
    sudo pacstrap -U "${dir_root}" "${dir_pkg}/"*
  else
    echo "  -> No built packages found"
  fi
  echo " => Pacstrap built packages done"
}