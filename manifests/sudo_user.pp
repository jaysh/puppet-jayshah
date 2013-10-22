class jayshah::sudo_user( $username ) {
  # Account that will manage the server. The password
  # for this is set in the bootstrap deploy.sh script.
  user { $username:
    ensure     => present,
    managehome => true,
  }

  # Ensure that user can sudo.
  sudo::directive { $username:
    content => "$username     ALL=(ALL)       ALL\n",
  }
}
