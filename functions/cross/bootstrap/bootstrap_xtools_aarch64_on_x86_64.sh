relative_source extract_ondemand.sh

bootstrap_xtools_aarch64_on_x86_64() {
  echo "  -> Bootstrapping x86-64 ArchLinux hosted aarch64 ArchLinuxARM targeted cross-build toolchain"
  extract_ondemand xtools_aarch64_on_x86_64 'yes' 1
  echo "  -> Bootstrapped toolchain"
}