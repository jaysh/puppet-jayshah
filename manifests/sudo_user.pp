class jayshah::sudo_user( $username, $ssh_key = undef, $password = '!' ) {
  user { $username:
    ensure     => present,
    managehome => true,
    password   => $password,
  }

  ssh_authorized_key { "ssh-key-$username":
    ensure => $ssh_key ? { undef => absent, default => present },
    name   => 'Puppet jayshah::sudo_user',
    key    => $ssh_key,
    type   => 'rsa',
    user   => $username,
  }
    
  # Ensure that user can sudo.
  sudo::directive { $username:
    content => "$username     ALL=(ALL)       ALL\n",
  }
}
