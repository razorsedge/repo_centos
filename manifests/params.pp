# Optional parameters in setting up CentOS Yum repository
class repo_centos::params {

  if $::operatingsystemmajrelease {
    $releasever = $::operatingsystemmajrelease
  } elsif $::os_maj_version {
    $releasever = $::os_maj_version
  } else {
    $releasever = inline_template('<%= @operatingsystemrelease.split(".").first %>')
  }

  $repourl                     = 'http://mirror.centos.org/centos'
  $debug_repourl               = 'http://debuginfo.centos.org'
  $source_repourl              = 'http://vault.centos.org'
  $mirrorlisturl               = 'http://mirrorlist.centos.org'
  $enable_base                 = true
  $enable_contrib              = false
  $enable_cr                   = false
  $enable_extras               = true
  $enable_plus                 = false
  $enable_scl                  = false
  $enable_updates              = true
  $enable_source               = false
  $enable_debug                = false
  $ostype                      = 'CentOS'
  $urlbit                      = $releasever
  $ensure_base                 = 'present'
  $ensure_contrib              = 'present'
  $ensure_cr                   = 'present'
  $ensure_extras               = 'present'
  $ensure_plus                 = 'present'
  $ensure_scl                  = 'present'
  $ensure_updates              = 'present'
  $ensure_source               = 'present'
  $ensure_debug                = 'present'

  if $releasever >= '6' {
    $mirrorlist_tail           = '&infra=$infra'
  }
}
