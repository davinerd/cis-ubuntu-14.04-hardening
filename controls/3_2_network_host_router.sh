function source_route {
  echo "net.ipv4.conf.all.accept_source_route = 0" >> $SYSCTL
  echo "net.ipv4.conf.default.accept_source_route = 0" >> $SYSCTL
}

function accept_redirects {
  echo "net.ipv4.conf.all.accept_redirects = 0" >> $SYSCTL
  echo "net.ipv4.conf.default.accept_redirects = 0" >> $SYSCTL
}


function secure_redirects {
  echo "net.ipv4.conf.all.secure_redirects = 0" >> $SYSCTL
  echo "net.ipv4.conf.default.secure_redirects = 0" >> $SYSCTL
}

function log_martians {
  echo "net.ipv4.conf.all.log_martians = 1" >> $SYSCTL
  echo "net.ipv4.conf.default.log_martians = 1" >> $SYSCTL
}

function ignore_broadcast {
  echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> $SYSCTL
}

function ignore_bogus_responses {
  echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> $SYSCTL
}

function rp_filter {
  echo "net.ipv4.conf.all.rp_filter = 1" >> $SYSCTL
  echo "net.ipv4.conf.default.rp_filter = 1" >> $SYSCTL
}

function syn_cookies {
  echo "net.ipv4.tcp_syncookies = 1" >> $SYSCTL
}

function c_3_2 {
  log_info "Started hardening section 3.2"
  source_route
  accept_redirects
  secure_redirects
  log_martians
  ignore_broadcast
  ignore_bogus_responses
  rp_filter
  syn_cookies

  sysctl -p &>/dev/null   
}

