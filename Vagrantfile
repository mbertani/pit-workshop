Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 9200, host: 9200, host_ip: "127.0.0.1", id: 'elasticsearch-port'
  config.vm.network "forwarded_port", guest: 5601, host: 5601, host_ip: "127.0.0.1", id: 'kibana-port'
  config.vm.network "forwarded_port", guest: 9600, host: 9600, host_ip: "127.0.0.1", id: 'logstash-stats-port'
  
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  config.vm.provider "virtualbox" do |vb|
   vb.memory = "4096"
   vb.cpus = 2
  end

  config.vm.hostname = "elastic-workshop"
  config.vm.provision "shell", inline: <<-SHELL
    # Update the system
	apt-get update
	apt-get -y upgrade
	# Install java
    apt-get install --yes python-software-properties
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update -qq
    echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections
    sudo apt-get install --yes oracle-java8-installer
    yes "" | apt-get -f install
	# Download & Install ES
	wget -O elasticsearch.deb -nv https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.2.deb
	dpkg -i elasticsearch.deb
	rm elasticsearch.deb
	#configure ES. To access ES from the host we have to bind the server to an IP
	hostname -I | xargs printf 'network.host: %s\n' >> /etc/elasticsearch/elasticsearch.yml
	printf 'http.port: 9200\n' >> /etc/elasticsearch/elasticsearch.yml	
	# Download & Install Logstash   
	wget -O logstash.deb -nv https://artifacts.elastic.co/downloads/logstash/logstash-6.1.2.deb
	dpkg -i logstash.deb
	rm logstash.deb	
	#Bind logstash server for external use
	hostname -I | xargs printf 'http.host: %s\n' >> /etc/logstash/logstash.yml
	hostname -I | xargs printf 'http.port: 9600\n' >> /etc/logstash/logstash.yml
	# Download & Install Kibana
	wget -O kibana.deb -nv https://artifacts.elastic.co/downloads/kibana/kibana-6.1.2-amd64.deb
	dpkg -i kibana.deb
	rm kibana.deb		
	# To access kibana externally we have to bind to an IP
	hostname -I | xargs printf 'server.host: %s\n' >> /etc/kibana/kibana.yml
	hostname -I | xargs printf 'elasticsearch.url: "http://%s:9200"\n' >> /etc/kibana/kibana.yml
	printf 'server.port: 5601\n' >> /etc/kibana/kibana.yml	
	# Download & Install Filebeat
	wget -O filebeat.deb -nv https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.2-amd64.deb
	dpkg -i filebeat.deb
	rm filebeat.deb		
	# Make the user vagrant owner of the configuration file. We'll make changes here.
	chown -R vagrant:vagrant /etc/filebeat
	# Install git and checkout the repo
	cd /home/vagrant
	sudo apt-get install -y git
	git clone https://github.com/mbertani/pit-workshop.git
	chown -R vagrant:vagrant /home/vagrant/pit-workshop	
	# Fix permissions, env variables
	hostname -I | xargs printf 'export LOCALIP=%s\n' >> /home/vagrant/.profile	
	chmod +x /home/vagrant/pit-workshop/filebeat/run_filebeat.sh
	chmod +x /home/vagrant/pit-workshop/logstash/run_logstash.sh
	chmod go-w /home/vagrant/pit-workshop/filebeat/filebeat.yml
   SHELL
  
end