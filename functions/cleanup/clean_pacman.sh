clean_pacman() {
  echo " => Cleaning Pacman package cache..."
  sudo rm -rf "${dir_root}/var/cache/pacman/pkg/"*
  echo " => Pacman cache cleaned"
}