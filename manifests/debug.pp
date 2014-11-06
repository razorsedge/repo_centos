# CentOS debug - Debuginfo packages
# This repository is shipped with CentOS and is disabled by default
class repo_centos::debug {

  include repo_centos

  if $repo_centos::enable_debug {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'debug' |> { ensure => $repo_centos::ensure_debug }
  }

  yumrepo { 'debug':
    baseurl  => "${repo_centos::debug_repourl}/${repo_centos::releasever}/\$basearch/",
    descr    => "CentOS-${repo_centos::releasever} - Debuginfo",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${repo_centos::releasever}",
  }

}
