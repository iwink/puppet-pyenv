# @summary Install OS-specific build dependencies for pyenv.
class pyenv::dependencies {
  case $facts['os']['family'] {
    'Debian'       : { require pyenv::dependencies::debian    }
    'RedHat'       : { require pyenv::dependencies::redhat    }
    default        : { notice("Could not load dependencies for ${facts['os']['family']}") }
  }
}
