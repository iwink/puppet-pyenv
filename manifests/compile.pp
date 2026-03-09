# @summary Compiles and installs a Python version using pyenv.
#
# @param user
#   The user to compile Python for.
# @param python
#   The Python version to compile (e.g. '3.7.3').
# @param group
#   The group for the pyenv installation.
# @param home
#   Home directory of the user. Defaults to /home/$user.
# @param root
#   Root directory for pyenv. Defaults to $home/.pyenv.
# @param global
#   Whether to set this version as the pyenv global default.
# @param environment
#   Optional environment variables for the compile exec, e.g.
#   ['CONFIGURE_OPTS=--with-openssl=/usr/local/openssl-1.1'].
#
define pyenv::compile(
  String $user,
  String $python,
  String $group                = $user,
  String $home                 = '',
  String $root                 = '',
  Boolean $global              = false,
  Array[String] $environment   = [],
) {
  $home_path = $home ? { '' => "/home/${user}", default => $home }
  $root_path = $root ? { '' => "${home_path}/.pyenv", default => $root }

  $bin         = "${root_path}/bin"
  $shims       = "${root_path}/shims"
  $versions    = "${root_path}/versions"
  $global_path = "${root_path}/version"
  $path        = [$shims, $bin, '/bin', '/usr/bin']

  $compile_env = ["HOME=${home_path}"] + $environment

  exec { "pyenv::compile ${user} ${python}":
    command     => "pyenv install ${python}",
    timeout     => 0,
    user        => $user,
    group       => $group,
    cwd         => $home_path,
    creates     => "${versions}/${python}",
    path        => $path,
    environment => $compile_env,
    logoutput   => 'on_failure',
    notify      => Exec["pyenv::rehash ${user} ${python}"],
    provider    => 'bash',
  }

  exec { "pyenv::rehash ${user} ${python}":
    command     => 'pyenv rehash',
    user        => $user,
    group       => $group,
    cwd         => $home_path,
    environment => ["HOME=${home_path}"],
    path        => $path,
    logoutput   => 'on_failure',
    provider    => 'bash',
    refreshonly => true,
  }

  if $global {
    file { "pyenv::global ${user}":
      path    => $global_path,
      content => "${python}\n",
      owner   => $user,
      group   => $group,
      require => Exec["pyenv::compile ${user} ${python}"],
    }
  }
}
