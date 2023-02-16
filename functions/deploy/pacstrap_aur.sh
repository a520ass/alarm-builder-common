pacstrap_aur() {
  echo " => Pacstrapping the AUR packages into ${dir_root}..."
  if compgen "${dir_pkg}/*" > /dev/null; then
    sudo pacstrap -U "${dir_root}" "${dir_pkg}/"*
  else
    echo "  -> No built AUR packages found"
  fi
  echo " => Pacstrap AUR done"
}