function apparmor {

 $APT install apparmor

}



function c_1_6 {
  log_info "Started hardening section 1.6"
  core_dump
  
  initctl reload-configuration

}

