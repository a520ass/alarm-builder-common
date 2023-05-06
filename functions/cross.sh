relative_source cross/bootstrap.sh
relative_source prepare/prepare_pkg/download_source.sh
relative_source cross/start_distccd_and_trap.sh

cross() {
  mkdir -p "${dir_cross}"
  bootstrap
  download_source
  local in_project='/home/alarm/alarm-builder'
  local cross_root="${dir_cross}/aarch64"
  local cross_project="${cross_root}${in_project}"
  sudo mkdir -p "${cross_project}"
  # !(${dir_cross}) does not work even with shopt -s extglob, have to do it this way
  local copy_list=()
  local copy_target=''
  for copy_target in *; do
    case "${copy_target}" in 
      "${dir_cross}") : ;;
      *)
        copy_list+=("${copy_target}")
      ;;
    esac
  done
  sudo cp -rva "${copy_list[@]}" "${cross_project}/"
  start_distccd_and_trap
  sudo mount -o bind "${cross_root}" "${cross_root}"
  sudo arch-chroot "${cross_root}" "${in_project}/common/scripts/cross_entrypoint.sh"
  sudo umount -R "${cross_root}"
  rm -rf "${dir_blob}" "${dir_build}" "${dir_pkg}" "${dir_releases}"
  sudo mv "${cross_project}/"{"${dir_blob}","${dir_build}","${dir_pkg}","${dir_releases}"} "${dir_releases}/"
  sudo chown -R $(id --user):$(id --group) "${dir_blob}" "${dir_build}" "${dir_pkg}" "${dir_releases}"
  sudo rm -rf "${cross_project}"
}