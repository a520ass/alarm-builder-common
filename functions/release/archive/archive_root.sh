archive_root() {
  echo "=> Creating rootfs archive..."
  local path_archive="${dir_releases}/${name_archive_root}"
  echo " -> Creating archive ${path_archive} without compression..."
  (
    cd "${dir_root}"
    sudo bsdtar --acls --xattrs -cvpf - *
  ) > "${path_archive}"
  if [[ "${compressor}" == 'no' ]]; then
    echo " -> Compressing skipped since compressor=no"
  else
    echo " -> Compressing rootfs archive..."
    ${compressor} "${path_archive}"
  fi
  echo "=> Rootfs archive created"
}