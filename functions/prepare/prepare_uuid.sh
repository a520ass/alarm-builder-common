prepare_uuid() {
  echo " => Preparing UUID..."
  uuid_root=$(uuidgen)
  uuid_boot_mkfs=$(uuidgen)
  uuid_boot_mkfs=${uuid_boot_mkfs::8}
  uuid_boot_mkfs=${uuid_boot_mkfs^^}
  uuid_boot_specifier="${uuid_boot_mkfs::4}-${uuid_boot_mkfs:4}"
  echo "  -> UUID for root partition is ${uuid_root}"
  echo "  -> UUID for boot partition is ${uuid_boot_mkfs} / ${uuid_boot_specifier}"
  echo " => UUID prepared"
}