relative_source cleanup/clean_pacman.sh
relative_source cleanup/remove_non_fallback.sh

cleanup() {
  echo "=> Cleaning up..."  
  clean_pacman
  remove_non_fallback
  echo "=> Cleaned up"
}