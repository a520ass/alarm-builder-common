populate_blob() {
  echo " => Populating project/device-specific blobs"
  local blob_path blob_path_real blob_path_target blob_mode
  local i=0
  for blob_path in "${blob_paths[@]}"; do
    blob_mode="${blob_modes[${i}]}"
    let ++i

    blob_path_real="${dir_blob}${blob_path}"
    blob_path_target="${dir_root}${blob_path}"

    sudo install -DTvm "${blob_mode}" "${blob_path_real}" "${blob_path_target}"
  done
  echo " => Populated project/device-specific blobs"
}
