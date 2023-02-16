setup_loop() {
  echo " => Setting up loop device..."
  loop_disk=$(sudo losetup -fP --show "${path_disk}")
  echo "  -> Using loop device ${loop_disk}"
  loop_boot="${loop_disk}p1"
  loop_root="${loop_disk}p2"
  echo " => Set up loop device"
}