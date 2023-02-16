get_versions() {
  echo " => Getting package versions to be used in later release note"
  file_versions=$(mktemp)
  pacman -Q --root "${dir_root}" > "${file_versions}"
  echo " => Got version"
}