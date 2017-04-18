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

    {
      clipboard: :bidirectional,
      chipset: :ich9,
      mouse: :ps2,
      vram: 128,
      accelerate3d: :on,
      vrde: :off,
      audiocontroller: :hda,
    }.each do |option, value|
      vb.customize ['modifyvm', :id, "--#{option}", value]
    end
  end

  config.vm.provision 'shell', inline: 'exec /vagrant/provision/bin/bootstrap.sh', privileged: false
end
