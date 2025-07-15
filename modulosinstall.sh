#!/bin/bash
export PATH=$PATH:/usr/sbin

# Caminho fixo onde o módulo principal será instalado
SSHPRO_PATH="/root/sshpro.sh"

# Desativa IPv6 temporariamente
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Detecta arquitetura e baixa o binário jq correspondente
cake=$(uname -m)
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/${cake}" -O jq
chmod +x jq

# Remove módulos antigos, se existirem
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py \
      add.sh rem.sh addteste.sh addsinc.sh remsinc.sh dragonmodule

# Baixa o módulo principal (sshplus.sh) e salva como /root/sshpro.sh
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sshplus.sh" -O "$SSHPRO_PATH"
chmod +x "$SSHPRO_PATH"

# Baixa também o módulo dragon.sh separadamente (caso necessário por outro sistema)
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/dragon.sh" -O dragonmodule
chmod +x dragonmodule

# Baixa os scripts auxiliares
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/delete.py" -O delete.py
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sincronizar.py" -O sincronizar.py
chmod +x delete.py sincronizar.py

# Baixa e executa o verificador
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/verificador.py" -O verificador.py
python3 verificador.py

# Reativa IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
