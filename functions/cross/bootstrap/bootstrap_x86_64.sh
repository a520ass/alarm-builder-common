relative_source bootstrap_ondemand.sh

bootstrap_x86_64() {
  local first_bootstrap=''
  bootstrap_ondemand x86_64 1
  if [[ "${first_bootstrap}" ]]; then
    echo "  -> Additional setups for first x86_64 bootstrap"
    # sudo arch-chroot cross/x86_64 pacman -Syu


  fi
}