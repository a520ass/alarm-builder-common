. common/functions/sanity_check.sh
. common/functions/prepare.sh
. common/functions/deploy.sh
. common/functions/setup.sh
. common/functions/cleanup.sh
. common/functions/release.sh

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