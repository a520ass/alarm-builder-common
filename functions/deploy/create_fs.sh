create_fs() {
  echo " => Creating FS..."
  echo "  -> Creating FAT32 FS with UUID ${uuid_boot_mkfs} on ${loop_boot}"
  sudo mkfs.vfat -n 'ALARMBOOT' -F 32 -i "${uuid_boot_mkfs}" "${loop_boot}"
  echo "  -> Creating ext4 FS with UUID ${uuid_root} on ${loop_root}"
  sudo mkfs.ext4 -L 'ALARMROOT' -m 0 -U "${uuid_root}" "${loop_root}"
  echo " => Created FS"
}