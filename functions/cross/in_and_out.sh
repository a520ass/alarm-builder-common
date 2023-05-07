relative_source start_distccd_and_trap.sh

in_and_out() {
  echo " => Prepare to get into the ArchLinuxARM AArch64 rootfs to do build work"
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
      "${dir_releases}") : ;;
      *)
        copy_list+=("${copy_target}")
      ;;
    esac
  done
  echo "  -> Setting up AArch64 cross build project folder..."
  echo "  -> Copying project files into it..."
  sudo cp -ra "${copy_list[@]}" "${cross_project}/"
  start_distccd_and_trap
  echo "  -> Binding AArch64 rootfs to itself for sanity"
  sudo mount -o bind "${cross_root}" "${cross_root}"
  echo "  -> Getting inside the QEMU ArchLinuxARM AArch64 rootfs..."
  sudo --preserve-env=compressor,GOPROXY,http_proxy,https_proxy arch-chroot "${cross_root}" "${in_project}/common/scripts/cross_entrypoint.sh"
  echo "  -> Got out from the QEMU alarm aarch64 rootfs"
  sudo umount -R "${cross_root}"
  echo "  -> Moving things back from ArchLinuxARM AArch64 rootfs..."
  local copy_back_folder=
  for copy_back_folder in "${dir_blob}" "${dir_build}" "${dir_build_cross}" "${dir_pkg}" "${dir_releases}"; do
    if sudo tar -C "${cross_project}" -c "${copy_back_folder}" | tar -x; then
      sudo chown -R $(id --user):$(id --group) "${copy_back_folder}"
    fi
  done
  echo "  -> Cleaning up AArch64 cross build project"
  sudo rm -rf "${cross_project}"
  echo " => Finished in-and-out"
}