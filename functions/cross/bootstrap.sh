relative_source bootstrap/bootstrap_aarch64.sh
relative_source bootstrap/bootstrap_xtools_aarch64_on_x86_64.sh
relative_source bootstrap/bootstrap_x86_64.sh

bootstrap() {
  echo " => Bootstrapping cross build environment..."
  bootstrap_aarch64
  bootstrap_xtools_aarch64_on_x86_64
  bootstrap_x86_64
}