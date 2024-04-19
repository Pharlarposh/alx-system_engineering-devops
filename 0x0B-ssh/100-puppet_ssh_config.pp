# 100-puppet_ssh_config.pp

file { '/etc/ssh/ssh_config':
  ensure  => file,
  content => "PasswordAuthentication no\nIdentityFile ~/.ssh/school\n",
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
