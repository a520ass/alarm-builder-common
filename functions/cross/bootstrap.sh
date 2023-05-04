. common/functions/cross/bootstrap/bootstrap_aarch64.sh

bootstrap() {
  echo " => Bootstrapping cross build environment..."
  mkdir -p "${cross_root}"
  bootstrap_aarch64
}