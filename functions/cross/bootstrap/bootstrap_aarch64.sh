. common/functions/cross/bootstrap/extract_ondemand.sh

bootstrap_aarch64() {
  local bootstrapped_mark="${cross_root}/.finished_bootstrap"
  extract_ondemand aarch64
  if [[ ! -f "${bootstrapped_mark}" ]]; then
    local script_out_path=$(mktemp)
    echo '#!/bin/bash' > "${script_out_path}"
    cat 'common/scripts/cross_bootstrap.sh' >> "${script_out_path}"
    echo "usermod -u ${UID} alarm" >> "${script_out_path}"
    echo "chown -R ${UID}:${UID} /home/alarm" >> "${script_out_path}"
    local script_in_path='/root/bootstrap.sh'
    local script_actual_path="${cross_root}${script_in_path}"
    sudo install -Dm755 "${script_out_path}" "${script_actual_path}"
    sudo mount -o bind "${cross_root}" "${cross_root}"
    sudo arch-chroot "${cross_root}" "${script_in_path}"
    sudo umount "${cross_root}"
    sudo rm -f "${script_actual_path}" "${script_out_path}"
    sudo touch "${bootstrapped_mark}"
  fi
}