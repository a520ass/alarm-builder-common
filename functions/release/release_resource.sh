release_resource() {
  echo "=> Releasing resources..."
  echo " => Umouting partitions..."
  sudo umount -R "${dir_root}" 
  echo " => Removing temp folders..."
  sudo rm -rf "${dir_root}" 
  echo " => Detaching loopback device ${loop_disk}"
  sudo losetup -d "${loop_disk}"
  echo "=> Released resources"
}