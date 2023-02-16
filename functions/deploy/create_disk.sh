create_disk() {
  echo " => Creating disk..."
  mkdir -p "${dir_releases}"
  path_disk="${dir_releases}/${name_disk}"
  echo "  -> Disk path is ${path_disk}"
  rm -f "${path_disk}"
  echo "  -> Allocating disk space..."
  truncate -s "${disk_size}" "${path_disk}"
  echo "  -> Creating partition table..."
  case "${disk_label}" in
    'msdos')
      parted -s "${path_disk}" \
        mklabel msdos \
        mkpart primary fat32 "${disk_start}iB" "${disk_split}iB" \
        mkpart primary ext4 "${disk_split}iB" 100%
      ;;
    'gpt')
      parted -s "${path_disk}" \
        mklabel gpt \
        mkpart ArchBoot fat32 "${disk_start}iB" "${disk_split}iB" \
        mkpart ArchRoot ext4 "${disk_split}iB" 100%
      ;;
    *)
      echo "  -> Illegal disk label: ${disk_label}"
      return 1
      ;;
  esac
  echo ' => Disk created'
}