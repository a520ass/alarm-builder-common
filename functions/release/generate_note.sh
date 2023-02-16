generate_note() {
  echo " => Generating release note..."
  local note="${dir_releases}/${name_release_note}"
  printf "### %s\nBuild ID: %s\n|name|version|source|\n|-|-|-|\n" "$(date +%Y%m%d)" "${name_date}" > "${note}"
  local release_note_package pkg_name pkg_source pkg_version
  for release_note_package in "${release_note_packages[@]}"; do
    pkg_name="$(cut -d : -f 1 <<< $release_note_package)"
    pkg_source="${release_note_package: $((${#pkg_name} + 1))}"
    pkg_version="$(grep $'^'"${pkg_name}"' .*' "${file_versions}" | cut -d ' ' -f 2)"
    echo "${pkg_name}|${pkg_version}|${pkg_source}" >> "${note}"
  done
  rm -f "${file_versions}"
  echo " => Release note generated"
}