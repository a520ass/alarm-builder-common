. common/functions/cleanup/clean_pacman.sh
. common/functions/cleanup/remove_non_fallback.sh

cleanup() {
  echo "=> Cleaning up..."  
  clean_pacman
  remove_non_fallback
  echo "=> Cleaned up"
}