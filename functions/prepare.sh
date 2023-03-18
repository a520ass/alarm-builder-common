. common/functions/prepare/prepare_blob.sh
. common/functions/prepare/prepare_pkg.sh
. common/functions/prepare/prepare_name.sh
. common/functions/prepare/prepare_uuid.sh

prepare() {
  echo "=> Preparing..."
  prepare_blob
  prepare_pkg
  prepare_name
  prepare_uuid
  echo "=> Preparation end"
}