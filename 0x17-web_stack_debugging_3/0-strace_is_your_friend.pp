# 0-strace_is_your_friend.pp

# Installing Apache package
package { 'apache2':
  ensure => installed,
}

# Fixing file permissions issue
file { '/var/log/apache2/error.log': # Assuming this is the error log path
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  require => Package['apache2'], # Ensure Apache is installed before managing the file
  notify  => Service['apache2'], # Restart Apache when file permissions change
}

# Restart Apache service
service { 'apache2':
  ensure => 'running',
  enable => true,
}

