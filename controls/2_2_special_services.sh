function chrony {
  $APT install chrony
}


function bind {
  $APT purge bind9-host
}

function postfix {
  sed -i  "/inet_interfaces/c\inet_interfaces = localhost"   $POSTFIX 
}

function c_2_2 {
  log_info "Started hardening section 2.2: Special purpose services"
  chrony
  bind
  postfix
  
  initctl reload-configuration
}

