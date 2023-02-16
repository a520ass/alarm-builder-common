create_mountpoint() {
  echo " => Creating mountpoint..."
  dir_root=$(sudo mktemp -d)
  echo "  -> Using ${dir_root} as mountpoint"
  dir_boot="${dir_root}/boot"
  echo " => Created mountpoint"
}