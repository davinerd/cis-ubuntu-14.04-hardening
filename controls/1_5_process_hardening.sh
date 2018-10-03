function core_dump {
  echo "fs.suid_dumpable = 0" >> $SYSCTL 
}

function limits {
  sed -i 's/^# End of file*//' "$LIMITSCONF"
  { echo '* hard maxlogins 10'
    echo '* hard core 0'
    echo '* soft nproc 512'
    echo '* hard nproc 1024'
    echo '# End of file'
  } >> "$LIMITSCONF"
}

function c_1_5 {
  log_info "Started hardening section 1.5: Additional process harderning"
  core_dump
  limits
  
  initctl reload-configuration

}

