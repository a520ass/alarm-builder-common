zero_fill() {
  echo "=> Filling zeroes to target root and boot fs for maximum compression"
  echo " => Filling boot partition..."
  sudo dd if=/dev/zero of="${dir_boot}/.zerofill" || true
  echo " => Filling root partition..."
  sudo dd if=/dev/zero of="${dir_root}/.zerofill" || true
  sudo rm -f "${dir_boot}/.zerofill" "${dir_root}/.zerofill"
  echo "=> Zero fill successful"
}