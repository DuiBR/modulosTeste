#!/bin/bash
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh

cake=$(uname -m)
wget "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/${cake}" -O jq
wget -O sshplus.sh "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sshplus.sh"
wget -O dragonmodule "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/dragon.sh"
wget -O delete.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/delete.py"
wget -O sincronizar.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/sincronizar.py"
wget -O verificador.py "https://raw.githubusercontent.com/DuiBR/modulosTeste/main/verificador.py"
chmod 777 sshplus.sh dragonmodule delete.py sincronizar.py verificador.py jq

apt install dos2unix
dos2unix rem.sh
wget "https://raw.githubusercontent.com/DuiBR/atlasPainel/main/verificador.py" -O verificador.py 
python3 verificador.py
