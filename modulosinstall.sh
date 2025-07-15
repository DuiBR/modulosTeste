#!/bin/bash

# Limpa arquivos antigos
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh jq verificador.py

# Detecta arquitetura e baixa o binário correto do jq
cake=$(uname -m)
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/${cake}" -O jq

# Baixa os scripts necessários
wget -O sshplus.sh "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sshplus.sh"
wget -O dragonmodule "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/dragon.sh"
wget -O delete.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/delete.py"
wget -O sincronizar.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sincronizar.py"
wget -O verificador.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/verificador.py"

# Aplica permissões
chmod 777 sshplus.sh dragonmodule delete.py sincronizar.py verificador.py jq

# Instala dos2unix automaticamente (sem travar)
apt install dos2unix -y

# Se rem.sh for necessário, baixe antes de usar dos2unix
#wget -O rem.sh "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/rem.sh"
#dos2unix rem.sh

# Executa o verificador
python3 verificador.py