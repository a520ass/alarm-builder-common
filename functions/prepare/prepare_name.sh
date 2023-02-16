prepare_name() {
  echo " => Preparing name"
  name_date=$(date +%Y%m%d_%H%M%S)
  name_base="${name_distro}-${name_date}"
  echo "  -> Basename ${name_base}"
  name_disk="${name_base}.img"
  name_archive_root="${name_base}-root.tar"
  name_archive_pkgs="${name_base}-pkgs.tar"
  name_release_note="${name_base}.md"
  echo " => Name prepared"
}