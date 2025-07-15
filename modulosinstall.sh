#!/bin/bash
export PATH=$PATH:/usr/sbin
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
cake=$(uname -m)
wget  "https://module.dragoncoressh.com/modulos/${cake}" -O jq
chmod +x jq
if [ -d "/opt/DragonCore/" ]; then
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh
wget  "https://module.dragoncoressh.com/modulod2/dragon.sh" -O dragonmodule
wget  "https://module.dragoncoressh.com/modulod2/delete.py" -O delete.py
wget  "https://module.dragoncoressh.com/modulod2/sincronizar.py" -O sincronizar.py
chmod 777 dragonmodule delete.py sincronizar.py
else
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh
wget  "https://module.dragoncoressh.com/modulod2/sshplus.sh" -O dragonmodule
wget  "https://module.dragoncoressh.com/modulod2/delete.py" -O delete.py
wget  "https://module.dragoncoressh.com/modulod2/sincronizar.py" -O sincronizar.py
chmod 777 dragonmodule delete.py sincronizar.py
fi
wget "https://module.dragoncoressh.com/modulos/verificador.py" -O verificador.py 
python3 verificador.py
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
