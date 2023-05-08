relative_source bootstrap/bootstrap_aarch64.sh
relative_source bootstrap/bootstrap_xtools_aarch64_on_x86_64.sh
# relative_source bootstrap/bootstrap_x86_64.sh

bootstrap_mt() {
  echo " => Bootstrapping cross build environment..."
  bootstrap_aarch64 &
  local pid_bootstrap_aarch64=$!
  bootstrap_xtools_aarch64_on_x86_64 &
  local pid_bootstrap_xtools_aarch64_on_x86_64=$!
  # bootstrap_x86_64 &
  local pid_bootstrap_x86_64=$!
  echo " => Waiting for all cross build environment bootstrapping to finish"
  wait $pid_bootstrap_aarch64 $pid_bootstrap_x86_64 $pid_bootstrap_xtools_aarch64_on_x86_64
}

bootstrap() {
  echo " => Bootstrapping cross build environment..."
  bootstrap_aarch64
  bootstrap_xtools_aarch64_on_x86_64
  # bootstrap_x86_64
  echo " => Bootstrapped cross build environment"
}