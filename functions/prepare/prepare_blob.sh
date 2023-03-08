prepare_blob() {
  echo " => Preparing project/device-specific blobs"
  local blob_path blob_path_real blob_url blob_sha256sum sha256sum_log sha256sum_actual
  local i=0
  for blob_path in "${blob_paths[@]}"; do
    blob_url="${blob_urls[${i}]}"
    blob_sha256sum="${blob_sha256sums[${i}]}"
    let ++i
    
    blob_path_real="${dir_blob}${blob_path}"
    mkdir -p $(dirname "${blob_path_real}")
    if [[ -f "${blob_path_real}" ]]; then
      sha256sum_log=$(sha256sum "${blob_path_real}")
      sha256sum_actual="${sha256sum_log::64}"
      if [[ "${sha256sum_actual}" ==  "${blob_sha256sum}" ]]; then
        echo "  -> blob for ${blob_path} already exists and sha256sum is correct"
        continue
      else
        echo "  -> existing blob for ${blob_path} has different sha256sum than expected, will re-downloadd"
        echo "   -> actual: ${sha256sum_actual}"
        echo "   -> expected: ${blob_sha256sum}"
        rm -f "${blob_path_real}"
      fi
    fi
    wget "${blob_url}" -O "${blob_path_real}"
    sha256sum_log=$(sha256sum "${blob_path_real}") # This is written as a single command without piping to cut because I want it to fail it sha256sum fails
    sha256sum_actual="${sha256sum_log::64}"
    if [[ "${sha256sum_actual}" !=  "${blob_sha256sum}" ]]; then
      echo "  -> Error: blob for ${blob_path} has different sha256sum"
      echo "   -> actual: ${sha256sum_actual}"
      echo "   -> expected: ${blob_sha256sum}"
      exit 1
    fi
  done
  echo " => Preparing project/device-specific blobs"
}