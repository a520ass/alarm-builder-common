populate_blob() {
  echo " => Populating project/device-specific blobs"
  local blob_entry blob_path blob_path_real blob_path_target blob_mode blob_url blob_sha256sum sha256sum_log sha256sum_actual
  for blob_entry in "${blob_list[@]}"; do
    blob_path=$(awk -F '::' '{print $1}' <<< "${blob_entry}")
    blob_mode=$(awk -F '::' '{print $2}' <<< "${blob_entry}")
    blob_url=$(awk -F '::' '{print $3}' <<< "${blob_entry}")
    blob_sha256sum=$(awk -F '::' '{print $4}' <<< "${blob_entry}")

    blob_path_real="${dir_blob}${blob_path}"
    blob_path_target="${dir_root}${blob_path}"

    install -DTvm "${blob_mode}" "${blob_path_real}" "${blob_path_target}"
  done
  echo " => Populated project/device-specific blobs"
}
