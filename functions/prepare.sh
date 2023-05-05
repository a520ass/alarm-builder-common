relative_source prepare/prepare_blob.sh
relative_source prepare/prepare_pkg.sh
relative_source prepare/prepare_name.sh
relative_source prepare/prepare_uuid.sh

prepare() {
  echo "=> Preparing..."
  prepare_blob
  prepare_pkg
  prepare_name
  prepare_uuid
  echo "=> Preparation end"
}