pkg_name=php-redis
pkg_distname=redis
pkg_origin=nc-np
pkg_version=4.3.0
pkg_maintainer="Niamh Cahill"
pkg_license=('PHP-3.01')
pkg_upstream_url=http://pecl.php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source=https://pecl.php.net/get/${pkg_distname}-${pkg_version}.tgz
pkg_filename=${pkg_distname}-${pkg_version}.tgz
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=c0f04cec349960a842b60920fb8a433656e2e494eaed6e663397d67102a51ba2
pkg_deps=(
  nc-np/php5
  core/coreutils
  core/curl
  core/glibc
  core/libxml2
  core/openssl
  core/readline
  core/zlib
  core/autoconf
)
pkg_build_deps=(
  core/bison2
  core/gcc
  core/make
  core/re2c
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)
pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

do_prepare () {
  if [[ ! -r /usr/bin/xml2-config ]]; then
    ln -sv "$(pkg_path_for libxml2)/bin/xml2-config" /usr/bin/xml2-config
  fi
}

do_build() {
  $(pkg_path_for nc-np/php5)/bin/phpize

  ./configure --with-php-config="$(pkg_path_for nc-np/php5)/bin/php-config" \
    --enable-redis-igbinary=no \
    --enable-redis-lzf=yes
  make
}

do_install() {
  make install
}

do_check() {
  make test
}
