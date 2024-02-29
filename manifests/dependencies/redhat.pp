# Install redhat dependencies
#
class pyenv::dependencies::redhat {
  ensure_packages(['readline-devel', 'zlib-devel', 'bzip2', 'bzip2-devel', 'openssl-devel', 'libyaml-devel', 'libxml2-devel', 'libxslt-devel', 'git', 'curl', 'mysql-libs', 'sqlite', 'sqlite-devel'])
}