class jayshah::sudo_user( $username, $password ) {
  # Account that will manage the server. The password
  # for this is set in the bootstrap deploy.sh script.
  user { $username:
    ensure     => present,
    managehome => true,
    password   => $password,
  }

  # Ensure that user can sudo.
  sudo::directive { $username:
    content => "$username     ALL=(ALL)       ALL\n",
  }
}
