relative_source ../prepare/prepare_pkg/download_source.sh
relative_source ../prepare/prepare_blob.sh

cross_download_source() {
  local arch_root="$(readlink -f ${dir_cross}/x86_64)"
  PATH="${arch_root}/usr/bin:${PATH}" \
  LIBRARY="${arch_root}/usr/share/makepkg" \
  MAKEPKG_CONF="${arch_root}/etc/makepkg.conf" \
  LD_LIBRARY_PATH="${arch_root}/usr/lib" \
    download_source
  prepare_blob
  # local cross_root="${dir_cross}/x86_64"
  # local cross_home="${dir_root}/home/arch"
  # local cross_build="${cross_home}/${dir_build}"
  # # Generate the script to be used
  # local script_out_path=$(mktemp)
  # printf '#!/bin/bash -e\n# Script to be run in the target root to setup some basic stuffs\n' > "${script_out_path}"
  # mv "${dir_build}" "${cross_build}"
  # arch-chroot "${cross_root}" chown -R arch:arch "${cross_build}"
  # PATH="$(readlink -f ${dir_cross}/x86_64)/usr/bin:${PATH}" \
  #   download_source
  # prepare_blob
}