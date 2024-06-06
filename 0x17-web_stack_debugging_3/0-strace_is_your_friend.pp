# Puppet manifest to ensure Apache is properly configured

# Ensure Apache package is installed
package { 'apache2':
  ensure => installed,
}

# Configure Apache virtual host
file { '/etc/apache2/sites-available/your_website.conf':
  content => "<VirtualHost *:80>
                  ServerAdmin webmaster@localhost
                  DocumentRoot /var/www/html
                  ErrorLog \${APACHE_LOG_DIR}/error.log
                  CustomLog \${APACHE_LOG_DIR}/access.log combined
              </VirtualHost>",
  require => Package['apache2'],
  notify  => Service['apache2'],
}

# Ensure Apache virtual host is enabled
file { '/etc/apache2/sites-enabled/your_website.conf':
  ensure  => 'link',
  target  => '/etc/apache2/sites-available/your_website.conf',
  require => File['/etc/apache2/sites-available/your_website.conf'],
  notify  => Service['apache2'],
}

# Ensure index.html file exists
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => '<!DOCTYPE html>
              <html>
              <head>
                <title>Apache 200 Status</title>
              </head>
              <body>
                <h1>Apache is returning a 200 status code</h1>
              </body>
              </html>',
  require => File['/etc/apache2/sites-enabled/your_website.conf'],
  notify  => Service['apache2'],
}

# Ensure Apache service is running
service { 'apache2':
  ensure => 'running',
  enable => true,
}
