. common/functions/cross/bootstrap/extract_ondemand.sh

bootstrap_aarch64() {
  local bootstrapped_mark="${cross_root}/.finished_bootstrap"
  extract_ondemand aarch64
  if [[ ! -f "${bootstrapped_mark}" ]]; then
    local script_out_path='common/scripts/cross_bootstrap.sh'
    local script_in_path='/root/bootstrap.sh'
    local script_actual_path="${cross_root}${script_in_path}"
    sudo install -Dm755 "${script_out_path}" "${script_actual_path}"
    sudo arch-chroot "${cross_root}" "${script_in_path}"
    sudo rm -f "${script_actual_path}"
    sudo touch "${bootstrapped_mark}"
  fi
}