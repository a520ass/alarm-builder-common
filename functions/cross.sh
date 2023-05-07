relative_source cross/bootstrap.sh
relative_source cross/cross_download_source.sh
relative_source cross/build_host.sh
relative_source cross/in_and_out.sh

cross() {
  echo "=> Cross build starts at $(date) <="
  mkdir -p "${dir_cross}"
  bootstrap
  cross_download_source
  build_host
  in_and_out
  echo "=> Cross build ends at $(date) <="
}