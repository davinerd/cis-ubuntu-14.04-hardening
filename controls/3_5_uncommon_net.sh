function disable_net {
  local NET
  
  NET="dccp sctp rds tipc"
  for disable in $NET; do
    echo "install $disable /bin/true" >> "/etc/modprobe.d/${disable}.conf"
  done
}

function c_3_5 {
  log_info "Started hardening section 3.5: Uncommon network protocols"
  disable_net
  
  initctl reload-configuration
}

