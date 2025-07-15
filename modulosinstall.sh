#!/bin/bash

# Limpa arquivos antigos
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh jq verificador.py


apt update -y
apt install dos2unix wget python3-pip -y


# Baixa os scripts necessários
wget -O sshplus.sh "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sshplus.sh"

wget -O dragonmodule "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/dragon.sh"
wget -O delete.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/delete.py"
wget -O sincronizar.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sincronizar.py"
wget -O verificador.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/verificador.py"

# Aplica permissões
chmod +x sshplus.sh dragonmodule jq verificador.py modulo.py delete.py sincronizar.py


# Executa o verificador
python3 verificador.py