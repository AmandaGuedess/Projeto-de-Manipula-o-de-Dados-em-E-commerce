# Projeto de Manipulação de Dados em E-commerce

## Descrição do Projeto
Este projeto tem o objetivo de demonstrar a criação de uma procedure SQL para manipulação de dados em um banco de dados de e-commerce. A procedure permite realizar operações de inserção, atualização, remoção e seleção de registros na tabela Cliente.

## Estrutura do Projeto

- Banco de Dados: O banco de dados utilizado é chamado company.

- Tabela Alvo: A tabela manipulada pela procedure é a tabela Cliente.

- Procedure: A procedure ManipularCliente foi criada para realizar operações de manipulação de dados de forma flexível.

## Como Utilizar

### 1. Inserir um Cliente:
```
CALL ManipularCliente(1, NULL, 'Nome', 'Meio', 'Sobrenome', 'CPF', 'Endereco', 'DataDeNascimento', TipoClienteID);
```

### 2. Atualizar um Cliente:
```
CALL ManipularCliente(2, idCliente, 'Nome', 'Meio', 'Sobrenome', 'CPF', 'Endereco', 'DataDeNascimento', TipoClienteID);
```

### 3. Deletar um Cliente:
```
CALL ManipularCliente(3, idCliente, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
```

### 4. Selecionar um Cliente:
```
CALL ManipularCliente(4, idCliente, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
```

## Observações

- A variável acao define a operação a ser realizada.
- As variáveis p_idCliente e outras são usadas dependendo da operação selecionada.
