. common/functions/cross/bootstrap.sh

cross() {
  mkdir -p ${dir_cross}
  cross_root="${dir_cross}/aarch64"
  bootstrap
  local in_project='/home/alarm/alarm-builder'
  local cross_project="${cross_root}${in_project}"
  sudo mkdir -p "${cross_project}"
  sudo mount -o bind . "${cross_project}"
  sudo mount -o bind "${cross_root}" "${cross_root}"
  sudo arch-chroot "${cross_root}" "${in_project}/common/scripts/cross_entrypoint.sh"
  sudo umount -R "${cross_root}"
  sudo umount -R "${cross_project}"
}