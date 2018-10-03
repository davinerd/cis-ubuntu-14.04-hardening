function set_permission {
  chmod 600 $SSHDFILE
}

function set_confs {
  sed -i 's/.*X11Forwarding.*/X11Forwarding no/' "$SSHDFILE"
  echo "MaxAuthTries 2" >> "$SSHDFILE"
  sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' "$SSHDFILE"
  
  if ! grep -q "^PermitUserEnvironment" "$SSHDFILE" 2> /dev/null; then
    echo "PermitUserEnvironment no" >> "$SSHDFILE"
  fi
  
  if ! grep -q "^Macs" "$SSHDFILE" 2> /dev/null; then
    echo 'MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256' >> "$SSHDFILE"
  fi

  if ! grep -q "^ClientAliveInterval" "$SSHDFILE" 2> /dev/null; then
    echo "ClientAliveInterval 300" >> "$SSHDFILE"
  fi

  if ! grep -q "^ClientAliveCountMax" "$SSHDFILE" 2> /dev/null; then
    echo "ClientAliveCountMax 0" >> "$SSHDFILE"
  fi


  sed -i 's/.*LoginGraceTime.*/LoginGraceTime 60/' "$SSHDFILE"
  echo "AllowUsers ubuntu" >> "$SSHDFILE"
  sed -i 's/.*Banner.*/Banner \/etc\/issue.net/' "$SSHDFILE"

  if ! grep -q "^Ciphers" "$SSHDFILE" 2> /dev/null; then
    echo 'Ciphers aes128-ctr,aes192-ctr,aes256-gcm@openssh.com,aes256-ctr' >> "$SSHDFILE"
  fi
}
 
function c_5_2 {
  log_info "Started hardening section 5.2: SSH server configuration"
  set_permission
  set_confs
  
  initctl reload-configuration
}

