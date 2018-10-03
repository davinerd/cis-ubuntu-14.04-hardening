function ip_forward {
  echo "net.ipv4.ip_forward = 0" >> $SYSCTL
}

function send_redirects {
  echo "net.ipv4.conf.all.send_redirects = 0" >> $SYSCTL
  echo "net.ipv4.conf.default.send_redirects = 0" >> $SYSCTL
}


function c_3_1 {
  log_info "Started hardening section 3.1: Network host only"
  ip_forward
  send_redirects

  sysctl -p &>/dev/null  
}

