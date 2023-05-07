relative_source cross/bootstrap.sh
relative_source cross/cross_download_source.sh
relative_source cross/build_host.sh
relative_source cross/start_distccd_and_trap.sh

cross() {
  echo "=> Cross build starts at $(date) <="
  mkdir -p "${dir_cross}"
  bootstrap
  cross_download_source
  build_host
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
  echo "  -> Setting up cross build project folder..."
  sudo cp -ra "${copy_list[@]}" "${cross_project}/"
  start_distccd_and_trap
  sudo mount -o bind "${cross_root}" "${cross_root}"
  sudo --preserve-env=compressor,GOPROXY,http_proxy,https_proxy arch-chroot "${cross_root}" "${in_project}/common/scripts/cross_entrypoint.sh"
  sudo umount -R "${cross_root}"
  local copy_back_list=(
    "${dir_blob}"
    "${dir_build}"
    "${dir_build_cross}"
    "${dir_pkg}"
    "${dir_releases}"
  )
  sudo tar -C "${cross_project}" -c "${copy_back_list[@]}" | tar -x # One command to be atomic
  sudo chown -R $(id --user):$(id --group)  "${copy_back_list[@]}"
  sudo rm -rf "${cross_project}"
  echo "=> Cross build ends at $(date) <="
}