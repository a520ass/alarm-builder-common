. common/functions/release/archive.sh
. common/functions/release/zero_fill.sh
. common/functions/release/release_resource.sh
. common/functions/release/compress_image.sh
. common/functions/release/generate_note.sh

release() {
  archive
  zero_fill
  release_resource
  compress_image
  generate_note
}