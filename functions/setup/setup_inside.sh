setup_inside() {
  echo "=> Getting into the target root"
  local script_out_path=$(mktemp)
  printf '#!/bin/bash -e\n# Script to be run in the target root to setup some basic stuffs\n' > "${script_out_path}"
  local run_inside_config
  for run_inside_config in "${run_inside_configs[@]}"; do
    declare -p "${run_inside_config}" >> "${script_out_path}"
  done
  local run_inside_script
  for run_inside_script in "${run_inside_scripts[@]}"; do
    echo "# -> Beginning of run-inside script ${run_inside_script}" >> "${script_out_path}"
    cat "${run_inside_script}" >> "${script_out_path}"
    echo "# -> End of run-inside script ${run_inside_script}" >> "${script_out_path}"
  done
  local script_in_path="/root/inroot.sh"
  local script_actual_path="${dir_root}${script_in_path}"
  sudo install -Dm755 "${script_out_path}" "${script_actual_path}"
  sudo -E arch-chroot "${dir_root}" "${script_in_path}"
  sudo rm -f "${script_actual_path}" "${script_out_path}"
  echo "=> Getting out from the target root"
}