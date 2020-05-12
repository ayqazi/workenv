require 'yaml'

# possible: virtualbox, hyperv
PROVIDER = :hyperv

settings = {
  'cpus' => 1,
  'mem' => 2,
  'monitors' => 1,
  'hostname' => "#{`hostname`.chomp}vm"
}

if PROVIDER == :virtualbox and ! Vagrant.has_plugin?('vagrant-vbguest')
  $stderr.puts('Please install vagrant-vbguest plugin: vagrant plugin install vagrant-vbguest')
  exit 1
end

if File.file?("#{__dir__}/settings.yaml")
  settings.merge!(YAML.load_file("#{__dir__}/settings.yaml")['default'])
end

settings['mem_bytes'] = settings['mem'].to_i*1024

Vagrant.configure('2') do |config|
  config.vm.box = 'generic/ubuntu2004'
  config.vm.hostname = settings['hostname']

  if PROVIDER == :virtualbox
    config.vm.provider 'virtualbox' do |provider|
      provider.cpus = settings['cpus']
      provider.memory = settings['mem_bytes']
      provider.gui = true

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
        provider.customize ['modifyvm', :id, "--#{option}", value]
      end

      provider.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 10000]
    end
  elsif PROVIDER == :hyperv
    config.vm.provider 'hyperv' do |provider|
      provider.cpus = settings['cpus']
      provider.memory = settings['mem_bytes']
    end
    # config.vm.synced_folder '.', '/vagrant', type: 'smb', smb_username: 'USERNAME', 'smb_password': 'PASSWORD' # Fill in to avoid prompts
  end

 config.vm.provision 'shell', inline: 'exec /vagrant/provision/bin/provision-vm', privileged: false
end
