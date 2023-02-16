remove_non_fallback() {
  echo " => Removing non-fallback initramfs..."
  local fallback_img=$(compgen -G "${dir_boot}/initramfs-linux-aarch64-*-fallback.img") || true
  if [[ -z "${fallback_img}" ]]; then
    echo "  -> Error: Failed to find fallback initramfs"
    return 1
  fi
  local fallback_temp=$(mktemp)
  sudo mv "${fallback_img}" "${fallback_temp}"
  sudo rm -f "${dir_boot}/initramfs-linux-aarch64-"*'.img'
  sudo mv "${fallback_temp}" "${fallback_img}"
  echo " => Removed non-fallback initramfs"
}