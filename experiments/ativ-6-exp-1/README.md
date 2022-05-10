# Atividade 6: Executando aplicações na nuvem computacional

## Grupo de segurança

- Acessar AWS

- Acessar serviço EC2

- Criar grupo de segurança
    - Escolher um nome e descrição

    - Regra do grupo de segurança 1: Acesso ssh

- Salve o grupo.

- Edite o mesmo grupo de segurança:

    - Adicionar nova regra:
    - Tipo: Todo o tráfego, Protocolo: tudo, Intervalo de portas: tudo, origem: nome do grupo de segurança usado


## Criar instâncias

- Acessar serviço EC2

- Executar instância
    - Numero de instancias: 2

    - Ubuntu Server 20.04 x86

    - Tipo de instancia: t2.medium

- Escolher seu par de chaves

- Configurações de rede: editar
    - Selecionar grupo de segurança existente, criado na etapa anterior.

- Configurar armazenamento:
    - 32GiB

- Detalhes avançados:
    - Dados de usuário:

        - Cole o script a seguir para instalar o docker automaticamente nas instâncias:

```
#!/bin/bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install docker-ce -y
sudo usermod -aG docker ubuntu
```

- Vá ao menu instâncias

- Aguarde as instancias iniciarem

- Coletar endereços de ip públicos para conectar via ssh

- Coletar endereços de ip privados para atualizar no script

## Executar os programas

- Após logar com o ssh em ambas as máquinas. Fazer o clone do repositório:
```
git clone https://github.com/lcnzg/Distributed-DCGAN && cd Distributed-DCGAN && git checkout ativ-6-exp-1
cd experiments/ativ-6-exp-1
```

- Editar o arquivo [run.sh](./run.sh) e atualizar a variável MASTER_IP para o ip privado da máquina 1, e na outra máquina editar o MASTER_IP e o rank para 1.

- Rodar o script [./run.sh](./run.sh) em ambas as máquinas

## Resultados:

- Máquina 1: [out-1.txt](./out-1.txt)
```
[rank: 1] Epoch 0 took: 1359.0164 seconds
[rank: 0] Epoch 0 took: 1359.0635 seconds
```

- Máquina 2: [out-2.txt](./out-2.txt)
```
[rank: 2] Epoch 0 took: 1359.0733 seconds
[rank: 3] Epoch 0 took: 1359.1297 seconds

```

## Terminar instâncias

- Acessar a EC2

- Vá ao menu instâncias

- Selecione suas 2 instâncias que estão rodando

- Clique no menu "Estado da instância" e em "Encerrar instância"

- Confirme e clique em "Encerrar"
