no_root() {
  echo " => Checking if running with root permission..."
  if [[ "${UID}" == 0 ]]; then
    echo "  -> Error: running with root permission, refuse to build for safety concerns"
    return 1
  fi
  echo " => No root permission, check pass"
}