function set_umask {
  if [ -f /etc/init.d/rc ]; then
    sed -i 's/umask 022/umask 027/g' /etc/init.d/rc
  fi

  if ! grep -q -i "umask" "/etc/profile" 2> /dev/null; then
    echo "umask 027" >> /etc/profile
  fi

  if ! grep -q -i "umask" "/etc/bash.bashrc" 2> /dev/null; then
    echo "umask 027" >> /etc/bash.bashrc
  fi
}

function users_no_shell {
  local USRS
  USRS=`egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="vagrant" && \
        $1!="halt" && $3<1000 && $7!="/usr/sbin/nologin" && $7!="/bin/false") {print $1}'`

  for u in $USRS; do
    sed -i "/${u}/ s/$/\/usr\/sbin\/nologin/" /etc/passwd
  done
}

function c_5_4 {
  log_info "Started hardening section 5.4: User accounts"
  set_umask
  users_no_shell
 
  initctl reload-configuration
}
