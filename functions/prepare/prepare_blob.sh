prepare_blob() {
  echo " => Preparing project/device-specific blobs"
  local blob_entry blob_path blob_path_real blob_mode blob_url blob_sha256sum sha256sum_log sha256sum_actual
  for blob_entry in "${blob_list[@]}"; do
    blob_path=$(awk -F '::' '{print $1}' <<< "${blob_entry}")
    blob_mode=$(awk -F '::' '{print $2}' <<< "${blob_entry}")
    blob_url=$(awk -F '::' '{print $3}' <<< "${blob_entry}")
    blob_sha256sum=$(awk -F '::' '{print $4}' <<< "${blob_entry}")
    
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