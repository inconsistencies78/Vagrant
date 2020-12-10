#!/bin/bash

apt-get update
apt-get -y upgrade # kein full-upgrade, da wenn jetzt kernel-Änderungen wären, müssten wir neu starten. also upgrade ohne mögliche Kernel-Updates.
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common # vorbereiten, um aktuelle Docker Variante u.a. zu installieren
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - # docker gpg Schlüssel hinzufügen
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" # das Docker repository hinzufügen. $(lsb_release -cs) gibt den Kurznamen der aktuelen Ubuntu-Variante aus. damit sind wir für ubuntu-updates gerüstet
apt-get update 
apt-get -y install docker-ce docker-ce-cli containerd.io 
usermod -aG docker vagrant 
systemctl enable docker #docker wird bei jedem boot automatisch gestartet
# nötige Verzeichnisse erstellen
mkdir -p /srv/gitlab/{data,logs,config}
# Gitlab-CE Container erstellen
docker run --detach \
--hostname gitlab \
--publish 80:80 \ 
--name gitlab \
--restart always \
--volume /srv/gitlab/config:/etc/gitlab \ 
--volume /srv/gitlab/logs:/var/log/gitlab \
--volume /srv/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest
