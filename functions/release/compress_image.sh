compress_image() {
  echo "=> Compressing disk image..."
  if [[ "${compressor}" == 'no' ]]; then
    echo " -> Compressing skipped since compressor=no"
  else
    local path_disk="${dir_releases}/${name_disk}"
    echo " => Compressing disk image ${path_disk}..."
    ${compressor} "${path_disk}"
  fi
  echo "=> Compressing success"
}