# Bugfix and enhancement updates are issued from time to time between update
# sets that may be rolled into the next update set by the upstream provider.
# This repository is shipped with CentOS and is disabled by default
class repo_centos::fasttrack {

  include ::repo_centos

  if $repo_centos::enable_fasttrack {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=fasttrack${repo_centos::mirrorlist_tail}"
    $baseurl = 'absent'
  } else {
    $mirrorlist = 'absent'
    $baseurl = "${repo_centos::repourl}/\$releasever/fasttrack/\$basearch/"
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack
  #baseurl=http://mirror.centos.org/centos/$releasever/fasttrack/$basearch/

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'fasttrack' |> { ensure => $repo_centos::ensure_fasttrack }
  }

  yumrepo { 'fasttrack':
    baseurl    => $baseurl,
    mirrorlist => $mirrorlist,
    descr      => 'CentOS-$releasever - fasttrack',
    enabled    => $enabled,
    gpgcheck   => '1',
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::repo_centos::releasever}",
    #priority   => '1',
  }

}
