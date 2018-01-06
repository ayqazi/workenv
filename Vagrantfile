require 'yaml'

settings = {
  'cpus' => 1,
  'mem' => 2,
  'monitors' => 1,
  'hostname' => "#{`hostname`.chomp}vm"
}

unless Vagrant.has_plugin?('vagrant-vbguest')
  $stderr.puts('Please install vagrant-vbguest plugin: vagrant plugin install vagrant-vbguest')
  exit 1
end

if File.file?("#{__dir__}/settings.yaml")
  settings.merge!(YAML.load_file("#{__dir__}/settings.yaml")['default'])
end

settings['mem_bytes'] = settings['mem'].to_i*1024

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.hostname = settings['hostname']

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = settings['cpus']
    vb.memory = settings['mem_bytes']
    vb.gui = true

    {
      clipboard: :bidirectional,
      chipset: :ich9,
      mouse: :ps2,
      vram: 128,
      accelerate3d: :on,
      vrde: :off,
      audiocontroller: :hda,
      monitorcount: settings['monitors']
    }.each do |option, value|
      vb.customize ['modifyvm', :id, "--#{option}", value]
    end

    vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 10000]
  end

  config.vm.provision 'shell', inline: 'exec /vagrant/provision/bin/provision-vm', privileged: false
end
