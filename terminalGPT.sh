#!/bin/bash
# By Passos, OMAR
# abr/12/2023 5:30pm
OKBLUE='\033[94m'
OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
OKYELLOW='\033[0;33m'
OKBYELLOW='\033[1;33m'
OKBRED='\033[0;31m'
OKBBLUE='\033[0;34m'
OKBGREEN='\033[0;32m'
OKBOLD='\033[1m'
OKWARNING='\033[93m'
OKUNDERLINE='\033[4m'
OKFAIL='\033[91m'
OKHEADER='\033[95m'
RESET='\e[0m'
# Função para enviar a mensagem ao GPT
send_message() {
    local message="$1"
    local model="gpt-3.5-turbo"
    local api_key="sua-chave"
    # Enviar a mensagem para a API de chat
    curl -X POST "https://api.openai.com/v2/chat/completions" \
    -H "Authorization: Bearer $api_key" \
    -H "Content-Type: application/json" \
    -d '{
        "model": "'"$model"'",
        "messages": [
            {"role": "system", "content": "Você: '"$message"'"},
            {"role": "user", "content": "'"$message"'"}
        ]
    }'
}
# Função para formatar e exibir a resposta do GPT
display_response() {
    local response="$1"
    echo local reply=$(echo "$response" | jq -r '.choices[].message.content')
    echo -e "$OKBRED * OpenAI: $RESET  $reply"
}
function logo {
  echo -e "$OKRED   ____           _                        _      ____    __  __    ___    ____   $RESET"
  echo -e "$OKRED  / ___|  _   _  | |__     ___   _ __     / \    |  _ \  |  \/  |  / _ \  |  _ \  $RESET"
  echo -e "$OKRED | |     | | | | | '_ \   / _ \ | '__|   / _ \   | |_) | | |\/| | | | | | | |_) | $RESET"
  echo -e "$OKRED | |___  | |_| | | |_) | |  __/ | |     / ___ \  |  _ <  | |  | | | |_| | |  _ <  $RESET"
  echo -e "$OKRED  \____|  \__, | |_.__/   \___| |_|    /_/   \_\ |_| \_\ |_|  |_|  \___/  |_| \_\ $RESET"
  echo -e "$OKRED          |___/                                                                   $RESET"
  echo -e "$RESET"
  echo -e "$OKORANGE ➜ [ https://github.com/ReturnByte$RESET $BOLD(Passos, OMAR)$RESET"
  echo -e "$OKORANGE ➜ [ cyberARMOR by @ReturnByte$RESET"
  echo -e "$OKORANGE ➜ [ https://meutudo.com.br$RESET"
  echo -e "$OKBOLD ➜ [ Applying artificial inteligence$RESET"
  echo ""
}
reset
logo
# Loop
while true; do
    echo -e "$OKGREEN ➜ Digite sua pergunta ou duvida Omar:  (ou digite 'sair') $RESET"
    read -r user_input
    # Verifica se eu quero sair
    if [ "$user_input" == "sair" ]; then
        echo -e "$OKHEADER Até a proxima Omar! $RESET"
        exit 0
    fi
    # Enviar mensagem para o ChatGPT e exibir a resposta
    response=$(send_message "$user_input")
    display_response "$response"
done
