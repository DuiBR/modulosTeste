# -*- coding: utf-8 -*-

from http.server import BaseHTTPRequestHandler, HTTPServer
import cgi
import subprocess
import os

# Senha de autenticação - ALTERE PARA SUA SENHA
senha_autenticacao = 'wKkq2UF0KtXx'

class MyRequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Verifica autenticação
        if 'Senha' not in self.headers or self.headers['Senha'] != senha_autenticacao:
            self.send_response(401)
            self.end_headers()
            self.wfile.write(b'Unauthorized')
            return

        # Processa o comando
        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={'REQUEST_METHOD': 'POST'}
        )
        
        comando = form.getvalue('comando')
        if not comando:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b'Bad Request')
            return

        try:
            # Executa via sshpro.sh
            resultado = subprocess.check_output(
                f"/root/sshpro.sh {comando}",
                shell=True,
                stderr=subprocess.STDOUT,
                timeout=30
            )
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            self.wfile.write(resultado)
        except subprocess.CalledProcessError as e:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(f'Command failed: {e.output.decode()}'.encode())
        except subprocess.TimeoutExpired:
            self.send_response(504)
            self.end_headers()
            self.wfile.write(b'Command timeout')

# Configuração do servidor
def run_server():
    host = '0.0.0.0'
    port = 6969
    server = HTTPServer((host, port), MyRequestHandler)
    print(f'Servidor iniciado em {host}:{port}')
    server.serve_forever()

if __name__ == '__main__':
    run_server()