# Explictly set to avoid warning message
Package {
  allow_virtual => false,
}

file { 'bash_profile':
  path    => '/home/vagrant/.bash_profile',
  ensure  => file,
  source  => '/vagrant/manifests/bash_profile'
}

class { 'boundary':
    token => $boundary_api_token,
}

node /^centos-7.0/ {

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

  package { 'stress':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

  package { 'sysstat':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

}


#node /^centos/ {
node default {

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

  package { 'stress':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

  package { 'sysstat':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

}

node /^ubuntu/ {

  exec { 'update-apt-packages':
    command => '/usr/bin/apt-get update -y',
  }

  package { 'stress':
    require => Exec['update-rpm-packages']
  }

  package { 'sysstat':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

}
