# Base includes the CentOS base files from the initial release
class repo_centos::base {

  include ::repo_centos

  if $repo_centos::enable_base {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
  #baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'centos-base' |> { ensure => $repo_centos::ensure_base }
  }

  yumrepo { 'centos-base':
    baseurl  => "${repo_centos::repourl}/${repo_centos::urlbit}/os/${::architecture}",
    descr    => "${::operatingsystem} ${::repo_centos::releasever} OS Base - ${::architecture}",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::repo_centos::releasever}",
    #priority => '1',
  }

}
