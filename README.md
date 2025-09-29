Este projeto tem como objetivo criar um modelo lógico estrutural de uma oficina mecânica e elaborar o script de criação do banco de dados. Por fim, algumas queries serão realizadas em cima dos dados persistidos na DB.

Tabelas:

- Customers: Armazena os dados dos clientes, como nome e contato.

- Vehicles: Contém as informações de cada veículo (marca, modelo, placa) e os conecta ao seu respectivo dono na tabela Customers.

- Mechanics: Lista os mecânicos da oficina e suas especialidades.

- Services: É o catálogo de todos os serviços oferecidos, como "Troca de Óleo" ou "Alinhamento", com seus preços base.

- Parts: Funciona como o inventário, registrando todas as peças disponíveis, seu preço e a quantidade em estoque.

- WorkOrders (Ordens de Serviço): É a tabela mais importante, pois representa o coração da operação. Cada registro aqui é um trabalho a ser feito, conectando um Vehicle (e seu cliente) a um Mechanic e registrando o status e as datas do serviço.

- WorkOrder_Services e WorkOrder_Parts: Como uma única ordem de serviço pode incluir vários serviços e usar diversas peças, estas tabelas fazem a ponte. Elas detalham exatamente quais serviços foram realizados e quais peças foram usadas em cada ordem de serviço específica.
