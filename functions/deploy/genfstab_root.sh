genfstab_root() {
  echo " => Generating fstab..."
  printf '# root partition with ext4 on SDcard / USB drive\nUUID=%s\t/\text4\trw,noatime,data=writeback\t0 1\n# boot partition with vfat on SDcard / USB drive\nUUID=%s\t/boot\tvfat\trw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro\t0 2\n' "${uuid_root}" "${uuid_boot_specifier}" | sudo install -DTm 644 '/dev/stdin' "${dir_root}/etc/fstab"
  echo " => Generated fstab"
}