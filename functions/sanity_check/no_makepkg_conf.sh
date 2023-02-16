no_makepkg_conf() {
  local makepkg_conf='/etc/makepkg.conf'
  echo " => Checking ${makepkg_conf}..."
  local conf=$(
    . ${makepkg_conf}
    echo "${PKGDEST}${SRCDEST}${SRCPKGDEST}"
  )
  if [[ "${conf}" ]]; then
    echo "  -> Error: either PKGDEST, SRCDEST or SRCPKGDEST is set in ${makepkg_conf}"
    return 1
  fi
  echo " => ${makepkg_conf} check pass"
}