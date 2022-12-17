FROM ubuntu

RUN cd /tmp; \
> log; \
apt-get update >> log; \
apt-get install -y curl  >> log; \
curl -sL https://deb.nodesource.com/setup_16.x | bash - >> log; \
apt-get install -y nodejs >> log; \
apt-get install -y npm >> log; \
apt-get install -y nginx  >> log; \
apt-get install -y git >> log; \
curl -sL https://github.com/mikefarah/yq/releases/download/v4.27.5/yq_linux_amd64 > /usr/local/bin/yq; \
chmod +x /usr/local/bin/yq >> log; \
cd >> log; \
node -e "fs.writeFileSync('package.json', '{}')" >> log; \
npm i -g -D -E @antora/cli@3.1 @antora/site-generator@3.1 >> log; \
npm i -g asciidoctor-kroki >> log; \
npm i -g @antora/lunr-extension >> log; \
#
#   These are convenience packages for the purposes of debugging
#
apt-get install -y net-tools >> log; \
apt-get install -y iptables >> log; \
apt-get install -y less >> log; \
apt-get install -y vim >> log; \
echo "Complete"

COPY bashrc /root/.bashrc