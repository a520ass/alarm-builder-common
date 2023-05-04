extract_ondemand() { # $1: arch name, $2: strip level
  if [[ -d "${cross_root}" ]]; then
    local random_mark="${cross_root}/.${RANDOM}"
    if touch "${random_mark}"; then
      rm -f "${random_mark}"
      echo "  -> Cross rootfs for $1 exists (${cross_root}) and we as normal user has write permission, this is not good, refuse to continue"
      return 1
    fi
    echo "  -> Cross rootfs for $1 exists, skipping it"
  else
    echo "  -> Bootstrapping ArchLinux $1 rootfs..."
    local cross_root_archive="${cross_root}.tar.gz"
    if [[ ! -f "${cross_root_archive}" ]]; then
      local bootstrap_name="bootstrap_$1"
      local url="${!bootstrap_name}"
      echo "  -> Downloading $1 rootfs from $url..."
      wget "${url}" -O "${cross_root_archive}"
    fi
    echo "  -> Extracting $1 rootfs from ${cross_root_archive}..."
    sudo mkdir -p "${cross_root}" # This is not atomic, if the script fails here we're screwed since the next time this is run the bootstrap will be considered finished
    if [[ ${2} ]]; then
      local stripping="--strip-components ${2}"
    else
      local stripping=''
    fi
    sudo bsdtar -C "${cross_root}" -xvpzf ${cross_root_archive} --acls --xattrs ${stripping}
    echo "  -> Extracted ArchLinux $1 rootfs"
  fi
}