strat_distccd_and_trap() {
  local pid_file="$(mktemp)"
  PATH="$(readlink -f ${dir_cross}/xtools_aarch64_on_x86_64)/aarch64-unknown-linux-gnu/bin:${PATH}" \
    distccd --daemon --allow-private --pid-file "${pid_file}"
  local distccd_pid="$(<"${pid_file}")"
  echo " => Staretd distccd daemon at pid ${distccd_pid}"
  trap "kill -s INT ${distccd_pid}" INT TERM EXIT
}