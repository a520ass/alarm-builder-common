archive_pkgs() {
  echo "=> Creating packages archive..."
  local path_archive="${dir_releases}/${name_archive_pkgs}"
  echo " -> Creating archive ${path_archive} without compression..."
  (
    cd "${dir_pkg}"
    tar -cvf - *
  ) > "${path_archive}"
  if [[ "${compressor}" == 'no' ]]; then
    echo " -> Compressing skipped since compressor=no"
  else
    echo " -> Compressing archive..."
    ${compressor} "${path_archive}"
  fi
  echo "=> Packages archive created"
}