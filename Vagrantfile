require 'yaml'

settings = {
  'cpus' => 1,
  'mem' => 2,
}

if File.file?("#{__dir__}/settings.yaml")
  settings.merge!(YAML.load_file("#{__dir__}/settings.yaml")['default'])
end

settings['mem_bytes'] = settings['mem'].to_i*1024

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.hostname = "#{`hostname`.chomp}vm"

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = settings['cpus']
    vb.memory = settings['mem_bytes']
    vb.gui = true
  end

  ansible_cmd =
    'cd /vagrant/provision && ' +
    'ansible-playbook -c local -i localhost, -l localhost vm.yaml'

  config.vm.provision 'file', source: 'provision/bootstrap.sh', destination: '/var/tmp/bootstrap.sh'
  config.vm.provision 'shell', inline: '/bin/bash /var/tmp/bootstrap.sh', privileged: true
  config.vm.provision 'shell', inline: ansible_cmd, privileged: true
end
