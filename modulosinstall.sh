#!/bin/bash
set -euo pipefail
export PATH=$PATH:/usr/sbin

# 1) Desativa IPv6 temporariamente
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# 2) Atualiza repositórios e instala dos2unix
echo "⏳ Atualizando repositórios e instalando dos2unix..."
apt-get update -qq
apt-get install -y dos2unix

# 3) Detecta arquitetura e baixa o binário jq correspondente
cake=$(uname -m)
wget -qO jq "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/${cake}"
chmod +x jq

# 4) Caminho fixo onde o módulo principal será instalado
SSHPRO_PATH="/root/sshpro.sh"

# 5) Remove instalações anteriores desses módulos
echo "🗑  Limpando versões antigas"
rm -f jq dragonmodule sshpro.sh delete.py sincronizar.py verificador.py

# 6) Baixa e prepara os módulos novos
echo "⏬ Baixando sshplus.sh para ${SSHPRO_PATH}"
wget -qO "${SSHPRO_PATH}" "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sshplus.sh"
chmod +x "${SSHPRO_PATH}"

echo "🔄 Convertendo fim de linha de sshplus.sh"
dos2unix "${SSHPRO_PATH}" || true

echo "⏬ Baixando dragon.sh"
wget -qO dragonmodule "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/dragon.sh"
chmod +x dragonmodule

echo "🔄 Convertendo fim de linha de dragonmodule"
dos2unix dragonmodule || true

echo "⏬ Baixando delete.py e sincronizar.py"
wget -qO delete.py       "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/delete.py"
wget -qO sincronizar.py  "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sincronizar.py"
chmod +x delete.py sincronizar.py

echo "⏬ Baixando e rodando verificador.py"
wget -qO verificador.py  "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/verificador.py"
chmod +x verificador.py
python3 verificador.py

# 7) Restaura IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0

echo "✅ Módulos atualizados com sucesso!"
