function remove_packages {
  local pkgs="telnet"


  for p in $pkgs; do
    $APT purge $p
  done

}



function c_2_1 {
  log_info "Started hardening section 2.1"
  remove_packages 
 
  initctl reload-configuration

}

