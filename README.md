# cripto

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


#cryptocurrencies

- Aplicação desenvolvida em Flutter para gerenciamento de criptomoedas. Ela oferece funcionalidades como login e cadastro com Firebase, salvamento de moedas favoritas no Firestore, gráficos de variação de valores de criptomoedas, histórico de compras, envio de comprovantes da galeria, e captura de fotos de documentos. A aplicação foi desenvolvida para a web e utiliza boas práticas de desenvolvimento e gerenciamento de estado.

# Funcionalidades
- Cadastro e Login com Firebase: Autenticação de usuários via email e senha, com integração com o Firebase Authentication.
- Firestore Database: Armazenamento de dados relacionados a moedas favoritas e histórico de compras no Firebase Firestore.
- SharedPreferences: Armazenamento de dados locais para melhorar a experiência do usuário, como preferências e configurações.
- Gráficos de Carteira: Visualização da carteira de criptomoedas com gráficos para mostrar os valores em tempo real.
- Histórico de Compras: Visualização de todas as transações feitas pelo usuário, incluindo data e valor.
- Gráficos de Variação de Moedas: Acompanhamento de preços das criptomoedas e variação de valores ao longo do tempo.
- Envio de Comprovantes: Capacidade de enviar comprovantes da galeria de fotos do dispositivo.
- Câmera para Fotos de Documentos: Funcionalidade de tirar fotos diretamente da câmera para enviar documentos e comprovantes.

# Tecnologias Utilizadas
- Flutter: Framework para desenvolvimento de aplicativos nativos para dispositivos móveis e web.
- Firebase: Para autenticação de usuários (Firebase Authentication), armazenamento de dados (Firestore) e funções em segundo plano.
- SharedPreferences: Para armazenamento local de dados.
- Fl_chart: Para gráficos de variação de moedas e carteira de criptomoedas.

# Gerenciamento de Estado
- A aplicação utiliza o Provider para gerenciamento de estado. Cada tela ou serviço que precisa de dados dinâmicos, como o histórico de compras ou as moedas favoritas, utiliza o Provider para acessar os dados de forma eficiente e reativa.

# Demonstração

- [Veja o Projeto](https://cryptocurrencies-taupe.vercel.app/)

### Mobile Login
<img src="https://i.imgur.com/30bwwiE.png" alt="Mobile Screenshot" width="300"/> 


### Mobile Criptomoedas
<img src="https://i.imgur.com/UhpKNhT.png" alt="Mobile Screenshot" width="300"/> 


### Mobile Favoritas
<img src="https://i.imgur.com/WW1WEZA.png" alt="Mobile Screenshot" width="300"/> 

### Mobile Carteira
<img src="https://i.imgur.com/YjivjQq.png" alt="Mobile Screenshot" width="300"/> 

### Mobile Conta
<img src="https://i.imgur.com/uEp5TIk.png" alt="Mobile Screenshot" width="300"/> 
