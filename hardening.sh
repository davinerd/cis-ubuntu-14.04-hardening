#!/usr/bin/env bash

readonly SCRIPT_NAME="$(basename "$0")"

# Configuration files
#readonly ADDUSER='/etc/adduser.conf'
readonly AUDITDCONF='/etc/audit/auditd.conf'
readonly AUDITHARDENRULES='/etc/audit/rules.d/hardening.rules'
readonly AUDITRULES='/etc/audit/audit.rules'
readonly COMMONPASSWD='/etc/pam.d/common-password'
#readonly COMMONACCOUNT='/etc/pam.d/common-account'
#readonly COMMONAUTH='/etc/pam.d/common-auth'
#readonly COREDUMPCONF='/etc/systemd/coredump.conf'
#readonly JOURNALDCONF='/etc/systemd/journald.conf'
readonly LIMITSCONF='/etc/security/limits.conf'
#readonly LOGINDCONF='/etc/systemd/logind.conf'
#readonly LOGINDEFS='/etc/login.defs'
#readonly LOGROTATE='/etc/logrotate.conf'
#readonly PAMLOGIN='/etc/pam.d/login'
#readonly RESOLVEDCONF='/etc/systemd/resolved.conf'
#readonly SECURITYACCESS='/etc/security/access.conf'
readonly SSHDFILE='/etc/ssh/sshd_config'
readonly HOSTALLOW='/etc/hosts.allow'
readonly HOSTDENY='/etc/hosts.deny'
readonly SYSCTL='/etc/sysctl.conf'
readonly POSTFIX='/etc/postfix/main.cf'
#readonly SYSTEMCONF='/etc/systemd/system.conf'
#readonly USERADD='/etc/default/useradd'
#readonly USERCONF='/etc/systemd/user.conf'

function log {
  local readonly level="$1"
  local readonly message="$2"
  local readonly timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  >&2 echo -e "${timestamp} [${level}] [$SCRIPT_NAME] ${message}"
}

function log_info {
  local readonly message="$1"
  log "INFO" "$message"
}

function log_warn {
  local readonly message="$1"
  log "WARN" "$message"
}

function log_error {
  local readonly message="$1"
  log "ERROR" "$message"
}


function f_apt {
  export TERM=linux
  export DEBIAN_FRONTEND=noninteractive

  if [[ $VERBOSE == "Y" ]]; then
    APTFLAGS='--assume-yes'
  else
    APTFLAGS='-qq --assume-yes'
  fi

  APT="apt-get $APTFLAGS"

  readonly APTFLAGS
  readonly APT

}



function main() {
  if [ $EUID -ne 0 ]; then
    log_error "Not root or not enough privileges. Exiting."
    exit 1
  fi

  if ! lsb_release -i | grep 'Ubuntu'; then
    log_error "Ubuntu only. Exiting."
    exit 1
  fi



  for s in ./controls/*; do
    [[ -e $s ]] || break

    source "$s"
  done

  f_apt

  c_1_1
  c_1_3
  c_1_5
  c_1_6
  c_1_7
  c_2_1
  c_2_2
  c_3_1
  c_3_2
  c_3_3
  c_3_4
  c_3_5
  c_4_1
  c_5_1
  c_5_2
  c_5_3
  c_5_4
  c_6_1
}







LOGFILE="hardening-$(hostname --short)-$(date +%y%m%d).log"
echo "[HARDENING LOG - $(hostname --fqdn) - $(LANG=C date)]" >> "$LOGFILE"

main "$@" | tee -a "$LOGFILE"
