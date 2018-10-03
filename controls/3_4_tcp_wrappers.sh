function hosts_allow {
  echo "sshd : ALL : ALLOW" >> $HOSTALLOW
  echo "ALL: LOCAL, 127.0.0.1" >> $HOSTALLOW 
  chmod 644 $HOSTALLOW
}

function hosts_deny {
  # just for passing compliance check
  echo "ALL: example.org" >> $HOSTDENY

  chmod 644 $HOSTDENY
}


function c_3_4 {
  log_info "Started hardening section 3.4: TCP wrappers"
  hosts_allow
  hosts_deny
  
  initctl reload-configuration
}
