#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import sys
import time

if len(sys.argv) != 2:
    sys.exit(1)

nome_arquivo = sys.argv[1]

with open(nome_arquivo, 'r') as arquivo:
    linhas = arquivo.readlines()
    linhas = [linha for linha in linhas if linha.strip()]

    for linha in linhas:
        colunas = linha.split()
        if len(colunas) >= 2:
            # Usando sshpro.sh para remoção V2ray
            os.system("/root/sshpro.sh v2raydel " + colunas[1] + " " + colunas[0])
        else:
            linha = linha.replace(' ', '')
            # Usando sshpro.sh para remoção SSH
            os.system("/root/sshpro.sh removessh " + linha)
    arquivo.close()
    os.system("rm " + nome_arquivo)
    
    # Reinicia o serviço apropriado (v2ray ou xray)
    if os.path.exists("/usr/local/etc/xray/config.json"):
        os.system("sudo systemctl restart xray")
    else:
        os.system("sudo systemctl restart v2ray")