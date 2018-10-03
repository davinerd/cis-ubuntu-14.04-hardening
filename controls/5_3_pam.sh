function configure_common_password {
  echo "password required pam_cracklib.so retry=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1" >> "$COMMONPASSWD"
  sed -i '/pam_unix.so/ s/$/ remember=5/' "${COMMONPASSWD}"
}

function c_5_3 {
  log_info "Started hardening section 5.3: PAM configuration"
  configure_common_password
  
  initctl reload-configuration
}

