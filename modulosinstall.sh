#!/bin/bash
set -e
export PATH=$PATH:/usr/sbin

# 1) Desativa IPv6 temporariamente
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# 2) Detecta arquitetura e baixa o jq do repositório modulosTeste na raiz (/root)
cake=$(uname -m)
wget -qO /root/jq "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/${cake}"
chmod +x /root/jq

# 3) Remove módulos antigos na raiz
rm -f /root/atlasdata.sh /root/atlascreate.sh /root/atlasteste.sh /root/atlasremove.sh \
      /root/delete.py /root/sincronizar.py /root/add.sh /root/rem.sh /root/addteste.sh /root/addsinc.sh /root/remsinc.sh /root/jq /root/verificador.py

# 4) Baixa os scripts do modulosTeste (mesmos links do Script 1) na raiz
wget -qO /root/sshplus.sh     "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sshplus.sh"
wget -qO /root/dragonmodule   "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/dragon.sh"
wget -qO /root/delete.py      "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/delete.py"
wget -qO /root/sincronizar.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sincronizar.py"
wget -qO /root/verificador.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/verificador.py"

# 5) Torna executáveis
chmod +x /root/sshplus.sh /root/dragonmodule /root/jq /root/verificador.py /root/delete.py /root/sincronizar.py

# 6) Instala dos2unix (caso não exista)
if ! command -v dos2unix &>/dev/null; then
  apt-get update -y
  apt-get install dos2unix -y
fi

# 7) Executa o verificador (rodando em /root)
python3 /root/verificador.py

# 8) Restaura IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
