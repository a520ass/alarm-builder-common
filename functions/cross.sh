. common/functions/cross/bootstrap.sh

cross() {
  mkdir -p "${dir_cross}"
  cross_root="${dir_cross}/aarch64"
  bootstrap
  local in_project='/home/alarm/alarm-builder'
  local cross_project="${cross_root}${in_project}"
  sudo mkdir -p "${cross_project}"
  {
    shopt -s extglob
    sudo cp -rva !(${dir_cross}) "${cross_project}/"
  }
  sudo mount -o bind "${cross_root}" "${cross_root}"
  sudo arch-chroot "${cross_root}" "${in_project}/common/scripts/cross_entrypoint.sh"
  sudo umount -R "${cross_root}"
  mkdir -p "${dir_releases}"
  sudo mv "${cross_project}/${dir_releases}/"* "${dir_releases}/"
  sudo rm -rf "${cross_project}"
  sudo chown -R $(id --user):$(id --group) "${dir_releases}"
}