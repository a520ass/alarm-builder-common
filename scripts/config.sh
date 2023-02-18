# This should be executed by the outer project to setup stuffs before applying the project-specific configs

# - Why in scripts and suffix .sh?
#    - Because it IS written in Bash syntax and should be included as part of the outer Bash script.
#      Stuffs here are all named with the suffix with their exact syntax. Good for people, good for parser.
#      Never hide stuffs, abstraction layers added to hide them only make things more complicated.
# - There's no sanity check?
#    - Not the purpose of this script, it just sets things up. Those functions using them should do sanity check.

name_distro='ArchLinuxARM-aarch64'
dir_aur='aur'
dir_pkg='pkg'
dir_releases='releases'
disk_label='msdos'
disk_size='2G' # iB omitted, but remember they stand for MiB or GiB (1024 units), not the 1000 units
disk_start='1M'
disk_split='256M'
pacstrap_from_repo_pkgs=(
  'base: base group to compose the ArchLinuxARM system'
  'openssh: for remote management'
  'sudo: for privilege elevation'
  'vim: for text editting'
)
timezone='Asia/Shanghai'
locales_enable=(
  'zh_CN.UTF-8 UTF-8'
  'en_GB.UTF-8 UTF-8'
  'en_US.UTF-8 UTF-8'
)
locale_use='en_GB.UTF-8'
link_vi_to_vim='yes'
sudo_allow_wheel='yes'
ssh_root_with_password='yes'
root_password='alarm_please_change_me'
enable_systemd_units=(
  'systemd-networkd.service'
  'systemd-resolved.service'
  'sshd.service'
)
create_users=( # [Username]@[group]:[password]
  "alarm@wheel:${root_password}"
)
run_inside_configs=( # Config variables that will be declared inside the target root just like they were defined here
  'root_password'
  'enable_systemd_units'
  'create_users'
)
run_inside_scripts=( # Files listed here will be combined to generate the target inroot.sh
  'common/scripts/inroot.sh'
)
compressor=${compressor:-xz -9e} # Compressor, set to no to skip compress, the syntax ${var:-default} is used so user could overwrite it with environment variable
release_note_packages=(
  'systemd:official'
  'openssh:official'
  'sudo:official'
  'vim:official'
)