require 'spec_helper'

shared_examples 'centos7' do
  let(:pre_condition) { "package { 'httpd': ensure => present }" }

  it { should contain_package('httpd').with_ensure('present') }

  it { should have_class_count(13) }
  it { should have_file_resource_count(10) }
  it { should have_gpg_key_resource_count(2) }

  it { should create_class('repo_centos') }
  it { should contain_class('repo_centos::params') }

  it { should contain_stage('repo_centos_clean').with_before('Stage[main]') }
  it { should contain_class('repo_centos::clean').with_stage('repo_centos_clean') }

  it { should contain_anchor('repo_centos::start').that_comes_before('Class[repo_centos::base]') }
  it { should contain_class('repo_centos::base').that_comes_before('Class[repo_centos::contrib]') }
  it { should contain_class('repo_centos::contrib').that_comes_before('Class[repo_centos::cr]') }
  it { should contain_class('repo_centos::cr').that_comes_before('Class[repo_centos::extras]') }
  it { should contain_class('repo_centos::extras').that_comes_before('Class[repo_centos::plus]') }
  it { should contain_class('repo_centos::plus').that_comes_before('Class[repo_centos::scl]') }
  it { should contain_class('repo_centos::scl').that_comes_before('Class[repo_centos::updates]') }
  it { should contain_class('repo_centos::updates').that_comes_before('Class[repo_centos::source]') }
  it { should contain_class('repo_centos::source').that_comes_before('Class[repo_centos::debug]') }
  it { should contain_class('repo_centos::debug').that_comes_before('repo_centos::fasttrack') }
  it { should contain_class('repo_centos::fasttrack').that_comes_before('Anchor[repo_centos::end]') }
  it { should contain_anchor('repo_centos::end').that_comes_before('Package[httpd]') }

  it do
    should contain_gpg_key('RPM-GPG-KEY-CentOS-7').with({
      :path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
      :before => 'Anchor[repo_centos::start]',
    })
  end

  it do
    should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7').with({
      :ensure => 'present',
      :owner  => '0',
      :group  => '0',
      :mode   => '0644',
      :source => 'puppet:///modules/repo_centos/RPM-GPG-KEY-CentOS-7',
    })
  end

  it do
    should contain_gpg_key('RPM-GPG-KEY-CentOS-Debug-7').with({
      :path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-7',
      :before => 'Anchor[repo_centos::start]',
    })
  end

  it do
    should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-7').with({
      :ensure => 'present',
      :owner  => '0',
      :group  => '0',
      :mode   => '0644',
      :source => 'puppet:///modules/repo_centos/RPM-GPG-KEY-CentOS-Debug-7',
    })
  end

  it_behaves_like 'repo_centos::clean', '7'
  it_behaves_like 'repo_centos::base', '7'
  it_behaves_like 'repo_centos::contrib', '7'
  it_behaves_like 'repo_centos::cr', '7'
  it_behaves_like 'repo_centos::extras', '7'
  it_behaves_like 'repo_centos::plus', '7'
  it_behaves_like 'repo_centos::scl', '7'
  it_behaves_like 'repo_centos::updates', '7'
  it_behaves_like 'repo_centos::source', '7'
  it_behaves_like 'repo_centos::debug', '7'
  it_behaves_like 'repo_centos::fasttrack', '7'
end
