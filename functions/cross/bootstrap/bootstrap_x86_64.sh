relative_source extract_ondemand.sh

bootstrap_x86_64() {
  echo "  -> Bootstrapping ArchLinux x86-64 rootfs and toolkit"
  local cross_root="${dir_cross}/x86_64"
  local bootstrapped_mark="${cross_root}/.finished_bootstrap"
  extract_ondemand x86_64 yes 1
  if [[ ! -f "${bootstrapped_mark}" ]]; then
    local script_out_path=$(mktemp)
    echo '#!/bin/bash' > "${script_out_path}"
    cat 'common/scripts/cross_bootstrap_x86_64.sh' >> "${script_out_path}"
    local script_in_path='/root/bootstrap.sh'
    local script_actual_path="${cross_root}${script_in_path}"
    sudo install -Dm755 "${script_out_path}" "${script_actual_path}"
    sudo mount -o bind "${cross_root}" "${cross_root}"
    sudo arch-chroot "${cross_root}" "${script_in_path}"
    sudo umount "${cross_root}"
    sudo rm -f "${script_actual_path}" "${script_out_path}"
    sudo touch "${bootstrapped_mark}"
  fi
  echo "  -> Boostrapped ArchLinux x86-64 rootfs"
}