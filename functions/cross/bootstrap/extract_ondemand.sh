extract_ondemand() { # $1: extract subdir, $2 read-only, $3: strip level
  local extract_name="${1}"
  local extract_dir="${dir_cross}/${extract_name}"
  local read_only="$2"
  local strip_level="$3"
  echo "  -> Extracting ${extract_dir} on demand..."
  local bootstrap_url_varname="bootstrap_url_${extract_name}"
  local bootstrap_url="${!bootstrap_url_varname}"
  local bootstrap_url_name="${bootstrap_url##*/}"
  local bootstrap_url_suffix="${bootstrap_url_name#*.}"
  local extract_url_mark_archive="${extract_dir}.url"
  local extract_url_mark_folder="${extract_dir}/.alarm-builder.url"
  local bootstrap_url_old_archive="$(cat "${extract_url_mark_archive}" 2>/dev/null)"
  local bootstrap_url_old_folder="$(cat "${extract_url_mark_folder}" 2>/dev/null)"
  local extract_file="${extract_dir}.${bootstrap_url_suffix}"
  if [[ "${bootstrap_url_old_archive}" != "${bootstrap_url}" || ! "${bootstrap_url_old_folder}" != "${bootstrap_url}" ]]; then
    # The second check implicitly checks if the folder exists
    echo "  -> Extracting to ${extract_dir} as it does not exist or url outdated, old: ${bootstrap_url_old}, new: ${bootstrap_url}"
    sudo rm -rf "${extract_dir}"
    if [[ ! -f "${extract_file}" || "${bootstrap_url_old_archive}" != "${bootstrap_url}" ]] ; then
      echo "  -> Downloading ${extract_file} rom ${bootstrap_url}..."
      wget "${bootstrap_url}" -O "${extract_file}"
      echo "${bootstrap_url}" > "${extract_url_mark}"
    fi
    if [[ "${strip_level}" ]]; then
      local stripping="--strip-components ${strip_level}"
    else
      local stripping=''
    fi
    if [[ "${read_only}" ]]; then
      sudo mkdir -p "${extract_dir}"
      sudo bsdtar -C "${extract_dir}" --acls --xattrs ${stripping} -xpf "${extract_file}" 
    else
      mkdir -p "${extract_dir}"
      tar -C "${extract_dir}" ${stripping} -xf "${extract_file}"
    fi
    echo "  -> Extracted ${extract_file} into ${extract_dir}"
  else
    echo "  -> No need to extract to ${extract_dir}"
  fi
  if [[ "${read_only}" ]]; then
    echo "  -> Sanity check for extraction target: should be read-only for us, a normal user"
    local random_mark="${extract_dir}/.${RANDOM}"
    if touch "${random_mark}" 2>/dev/null; then
      rm -f "${random_mark}"
      echo "  -> Extraction target folder ${extract_dir} exists but we as normal user has write permission, when it is not allowed"
      return 1
    fi
  fi
}