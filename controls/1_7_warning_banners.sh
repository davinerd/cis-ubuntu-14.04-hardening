function banners {
 local TEXT

  for f in /etc/issue /etc/issue.net /etc/motd; do
    TEXT="\\nAuthorized users only. All activity may be monitored and reported.\\n"
    echo -e "$TEXT" > $f
  done

}




function c_1_7 {
  log_info "Started hardening section 1.7"
  banners
 
  initctl reload-configuration

}

