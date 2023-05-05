extract_ondemand() { # $1: extract subdir, $2 read-only, $3: strip level
  local extract_name="${1}"
  local extract_dir="${dir_cross}/${extract_name}"
  local read_only="$2"
  local strip_level="$3"
  echo "  -> Extracting ${extract_dir} on demand..."
  local bootstrap_url_varname="bootstrap_url_${extract_name}"
  local bootstrap_url="${!bootstrap_url_varname}"
  local bootstrap_url_name="$(basename "${bootstrap_url}")"
  local bootstrap_url_suffix="${bootstrap_url_name%%.*}"
  local bootstrap_url_old="$(<${extract_url_mark})"
  local bootstrap_url_outdated=''
  local extract_file="${extract_dir}.${bootstrap_url_suffix}"
  local extract_url_mark="${extract_dir}.url"
  local bootstrap_reason=''
  if [[ "${bootstrap_url_old}" != "${bootstrap_url}" ]]; then
    bootstrap_url_outdated='yes'
    echo "  -> URL for ${extract_dir} updated, old: ${bootstrap_url_old}, new: ${bootstrap_url}"
  fi
  if [[ ! -d "${extract_dir}" || "${bootstrap_url_outdated}" ]]; then
    echo "  -> Extracting to ${extract_dir} as it does not exist or url outdated"
    sudo rm -rf "${extract_dir}"
    if [[ ! -f "${extract_file}" || "${bootstrap_url_outdated}" ]] ; then
      echo "  -> Downloading ${extract_file} rootfs from ${bootstrap_url}..."
      wget "${bootstrap_url}" -O "${cross_root_archive}" --quiet
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
  fi
  if [[ "${read_only}" ]]; then
    local random_mark="${extract_dir}/.${RANDOM}"
    if touch "${random_mark}"; then
      rm -f "${random_mark}"
      echo "  -> Extraction target folder ${extract_dir} exists but we as normal user has write permission, when it is not allowed"
      return 1
    fi
  fi
}