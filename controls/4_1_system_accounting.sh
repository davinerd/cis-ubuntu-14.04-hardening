function install_auditd {
  $APT install auditd
}

function set_conf {
  sed -i 's/^action_mail_acct =.*/action_mail_acct = root/' "$AUDITDCONF"
  sed -i 's/^admin_space_left_action = .*/admin_space_left_action = halt/' "$AUDITDCONF"
  sed -i 's/^max_log_file_action =.*/max_log_file_action = keep_logs/' "$AUDITDCONF"
  sed -i 's/^space_left_action =.*/space_left_action = email/' "$AUDITDCONF"
}


function add_rules {
  cp ./confs/audit.header $AUDITRULES
  for l in `ls ./confs/*.rules`; do
    cat "$l" >> $AUDITRULES
  done
  cat ./confs/audit.footer >> $AUDITRULES

  cp $AUDITRULES $AUDITHARDENRULES
}

function c_4_1 {
  log_info "Started hardening section 4.1: Configure system accounting"
  install_auditd
  set_conf
  add_rules
 
  initctl reload-configuration
}

