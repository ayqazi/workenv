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

    [
      %w{--clipboard bidirectional},
      %w{--chipset ich9},
      %w{--mouse ps2},
      %w{--vram 128},
      %w{--accelerate3d on},
      %w{--vrde off},
      %w{--audiocontroller hda},
    ].each do |option, value|
      vb.customize ['modifyvm', :id, option, value]
    end
  end

  config.vm.provision 'shell', inline: 'exec /vagrant/provision/bin/bootstrap.sh', privileged: false
end
