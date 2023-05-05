pacman -Rcns linux-aarch64 vi --noconfirm
pacman-key --init
pacman-key --populate
pacman -Syu --noconfirm \
  arch-install-scripts \
  base-devel \
  dosfstools \
  git \
  go \
  parted \
  uboot-tools \
  xz \
  wget \
  sudo
echo 'alarm ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/alarm_allow_sudo_no_passwd
echo 'MAKEFLAGS="-j3"' >> cross/aarch64/etc/makepkg.conf