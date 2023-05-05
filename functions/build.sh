relative_source sanity_check.sh
relative_source prepare.sh
relative_source deploy.sh
relative_source setup.sh
relative_source cleanup.sh
relative_source release.sh

build() {
  echo "=> Build starts at $(date) <="
  sanity_check
  prepare
  deploy
  setup
  cleanup
  release
  echo "=> Build ends at $(date) <="
}