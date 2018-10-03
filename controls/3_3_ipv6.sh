
function ipv6_accept_ra {
  echo "net.ipv6.conf.all.accept_ra = 0" >> $SYSCTL
  echo "net.ipv6.conf.default.accept_ra = 0" >> $SYSCTL
}

function ipv6_accept_redirects {
  echo "net.ipv6.conf.all.accept_redirects = 0" >> $SYSCTL
  echo "net.ipv6.conf.default.accept_redirects = 0" >> $SYSCTL
}

function ipv6_disable {
  echo "net.ipv6.conf.all.disable_ipv6 = 1" >> $SYSCTL
}

function c_3_3 {
  log_info "Started hardening section 3.3: IPv6"
  ipv6_accept_ra
  ipv6_accept_redirects
  ipv6_disable
  
  sysctl -p &>/dev/null
}

