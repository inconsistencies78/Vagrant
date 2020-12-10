Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.define "gitlab" do |gitlab|
    gitlab.vm.hostname = "gitlab"
#    gitlab.vm.network "private_network", ip: "192.168.100.100" #host-only-Netzwerk. brauchen wir im späteren Schritt nicht mehr. läuft über Netzwerkbrücke. wenn ich es richtig verstanden habe.
#    gitlab.vm.network "forwarded_port", guest: 22, host: 2522, auto_correct: true #Port freigeschaltet. brauchen wir auch nicht, weil sowieso frei geschaltet. sonst doppelt.
    gitlab.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true  #Port freigeschaltet
#    gitlab.vm.network "forwarded_port", guest: 443, host: 443, auto_correct: true  #Port freigeschaltet. da wir doch kein https benutzen wieder auskommentiert
    gitlab.vm.provider "virtualbox" do |vbox| 
      vbox.name = "Gitlab"
      vbox.cpus = "2"
      vbox.memory = "4096"
    end
    gitlab.vm.provision "shell", path: "scripts/gitlab-provision.sh" #Docker-Installation, in dem Verzeichnis liegen dann die Shell-Befehle
  end
end



