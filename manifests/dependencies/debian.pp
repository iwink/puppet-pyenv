# Install debian dependencies
#
class pyenv::dependencies::debian {
  ensure_packages(['build-essential', 'libreadline-dev', 'zlib1g', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libxml2-dev', 'libbz2-dev', 'libxslt1-dev', 'git', 'curl', 'libmariadb-dev-compat', 'libcurl4-openssl-dev', 'libsqlite3-dev'])
}
