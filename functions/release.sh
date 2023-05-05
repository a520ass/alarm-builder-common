relative_source release/archive.sh
relative_source release/zero_fill.sh
relative_source release/release_resource.sh
relative_source release/compress_image.sh
relative_source release/generate_note.sh

release() {
  archive
  zero_fill
  release_resource
  compress_image
  generate_note
}