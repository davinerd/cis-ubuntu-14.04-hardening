function fs_disable {
  local FS
  FS="cramfs freevxfs jffs2 hfs hfsplus squashfs udf vfat"

  log_info "Disabling filesystems ${FS[@]}"
  for disable in $FS; do
      echo "install $disable /bin/true" >> "/etc/modprobe.d/${disable}.conf"
  done
}

function fs_tmp {
  cp ./confs/tmp.mount /etc/systemd/system/tmp.mount
  ln -s /etc/systemd/system/tmp.mount /etc/systemd/system/default.target.wants/tmp.mount
  chmod 0644 /etc/systemd/system/tmp.mount
}

function fs_var {
  cp /etc/systemd/system/tmp.mount /etc/systemd/system/var.mount
  sed -i 's/\/tmp/\/var/g' /etc/systemd/system/var.mount
  ln -s /etc/systemd/system/var.mount /etc/systemd/system/default.target.wants/var.mount  
  chmod 0644 /etc/systemd/system/var.mount
}

function fs_var_tmp {
  cp /etc/systemd/system/tmp.mount /etc/systemd/system/var-tmp.mount
  sed -i 's/\/tmp/\/var\/tmp/g' /etc/systemd/system/var-tmp.mount
  ln -s /etc/systemd/system/var-tmp.mount /etc/systemd/system/default.target.wants/var-tmp.mount  
  chmod 0644 /etc/systemd/system/var-tmp.mount
}

function fs_var_log {
  cp /etc/systemd/system/tmp.mount /etc/systemd/system/var-log.mount
  sed -i 's/\/tmp/\/var\/log/g' /etc/systemd/system/var-log.mount
  ln -s /etc/systemd/system/var-log.mount /etc/systemd/system/default.target.wants/var-log.mount  
  chmod 0644 /etc/systemd/system/var-log.mount
}

function fs_var_log_audit {
  cp /etc/systemd/system/tmp.mount /etc/systemd/system/var-log-audit.mount
  sed -i 's/\/tmp/\/var\/log\/audit/g' /etc/systemd/system/var-log-audit.mount
  ln -s /etc/systemd/system/var-log-audit.mount /etc/systemd/system/default.target.wants/var-log-audit.mount  
  chmod 0644 /etc/systemd/system/var-log-audit.mount
}

function c_1_1 {
  log_info "Started hardening section 1.1: File Systems"
  fs_disable
  #fs_tmp
  #fs_var
  #fs_var_tmp
  #fs_var_log
  #fs_var_log_audit
  
  initctl reload-configuration

}
