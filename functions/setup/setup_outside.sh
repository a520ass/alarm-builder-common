setup_outside() {
  echo " => Basic setup outside the target root"
  echo "  -> Setting timezone to ${timezone}"
  sudo ln -sf "/usr/share/zoneinfo/${timezone}" "${dir_root}/etc/localtime"
  local locale_enable=()
  local locale_subst=''
  local locale_report=''
  local started=''
  for locale_enable in "${locales_enable[@]}"; do
    locale_subst+="s|^#${locale_enable}  $|${locale_enable}  |g
    "
    if [[ "${started}" ]]; then
      locale_report+=", '${locale_enable}'"
    else
      locale_report+="'${locale_enable}'"
    fi
    started='yes'
  done
  echo "  -> Enabling locales: ${locale_report}"
  sudo sed -i "${locale_subst}" "${dir_root}/etc/locale.gen"
  echo "  -> Setting '${locale_use}' as locale"
  echo "LANG=${locale_use}" | sudo tee "${dir_root}/etc/locale.conf"
  echo "  -> Setting hostname to alarm"
  echo 'alarm' | sudo tee "${dir_root}/etc/hostname"
  echo "  -> Setting basic localhost"
  printf '127.0.0.1\tlocalhost\n::1\t\tlocalhost\n' | sudo tee -a "${dir_root}/etc/hosts"
  echo "  -> Setting DHCP on eth* and en* with systemd-networkd"
  printf '[Match]\nName=eth* en*\n\n[Network]\nDHCP=yes\nDNSSEC=no\n' | sudo tee "${dir_root}/etc/systemd/network/20-wired.network"
  echo "  -> Creating symbol link /etc/resolve.conf => /run/systemd/resolve/resolv.conf in case systemd-resolved fails to set it up"
  sudo ln -sf /run/systemd/resolve/resolv.conf "${dir_root}/etc/resolv.conf"
  if [[ "${link_vi_to_vim}" == 'yes' ]]; then
    echo "  -> Setting VIM as VI..."
    sudo ln -sf 'vim' "${dir_root}/usr/bin/vi"
  fi
  if [[ "${sudo_allow_wheel}" == 'yes' ]]; then
    echo "  -> Setting up sudo, to allow users in group wheel to use sudo with password"
    local sudoers="${dir_root}/etc/sudoers"
    sudo chmod o+w "${sudoers}"
    sudo sed -i 's|^# %wheel ALL=(ALL:ALL) ALL$|%wheel ALL=(ALL:ALL) ALL|g' "${sudoers}"
    sudo chmod o-w "${sudoers}"
  fi
  if [[ "${ssh_root_with_password}" == 'yes' ]]; then
    echo '  -> Setting up SSH, to allow to login as root with password'
    sudo sed -i 's|^#PermitRootLogin prohibit-password$|PermitRootLogin yes|g' "${dir_root}/etc/ssh/sshd_config"
  fi
  local pacman_mirrorlist_pkg=$(ls "${dir_root}/var/cache/pacman/pkg/pacman-mirrorlist-"*'.pkg.tar'* | grep -v '.sig$' | tail -n 1)
  if [[ "${pacman_mirrorlist_pkg}" ]]; then
    echo "  -> Setting pacman mirror to geo-IP based global mirror"
    tar -xOf "${pacman_mirrorlist_pkg}" 'etc/pacman.d/mirrorlist' | 
      sed 's_#\(Server = .*geo.*$\)_\1_' | 
      sudo tee "${dir_root}/etc/pacman.d/mirrorlist" > /dev/null
  fi
  echo " => Completed basic setup outside the target root"
}
