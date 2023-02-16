mount_tree() {
  echo " => Mounting root tree"
  echo "  -> Mounting ${loop_root} to ${dir_root}"
  sudo mount -o noatime "${loop_root}" "${dir_root}"
  sudo mkdir -p "${dir_boot}"
  echo "  -> Mounting ${loop_boot} to ${dir_boot}"
  sudo mount -o noatime "${loop_boot}" "${dir_boot}"
  echo " => Root tree mounted"
}