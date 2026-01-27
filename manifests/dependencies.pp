# Setup dependencies depends on os family
#
class pyenv::dependencies {
  case $facts['os']['family'] {
    'debian'         : { require pyenv::dependencies::debian }
    'redhat'         : { require pyenv::dependencies::redhat }
    default        : { notice("Could not load dependencies for ${facts['os']['family']}") }
  }
}
