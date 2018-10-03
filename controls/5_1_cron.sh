function set_permissions {
  chmod 600 /etc/crontab
  chmod 600 /etc/cron.hourly
  chmod 600 /etc/cron.daily
  chmod 600 /etc/cron.weekly
  chmod 600 /etc/cron.monthly
  chmod 600 /etc/cron.d 
}

function allow_deny {
  touch /etc/cron.allow
  touch /etc/at.allow

  chmod og-rwx /etc/cron.allow
  chmod og-rwx /etc/at.allow

  chown root.root /etc/cron.allow
  chown root.root /etc/at.allow
}

function c_5_1 {
  log_info "Started hardening section 5.1: Configure cron"
  set_permissions
  allow_deny
 
  initctl reload-configuration
}

