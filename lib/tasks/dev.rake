namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts "Resetado o banco de dados"
    %x( rails db:drop db:create db:migrate)
    puts "Banco de dados resetado com sucesso!"

    puts "Cadastrando tipos de contato...."

    kinds = %w[Amigo Comercial Conhecido]
    kinds.each do |kind_name|
      Kind.create!(description: kind_name) # Certifique-se de que os tipos de contato estão criados primeiro
    end

    puts "Tipos de contato cadastrados com sucesso!"

    puts "Cadastrando os contatos"
    100.times do |i|
      begin
        # Escolha um kind aleatório
        kind = Kind.order("RANDOM()").first # Obter um tipo de contato aleatório

        Contact.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
          kind: kind # Atribuir o kind ao contato
        )
      rescue => e
        puts "Erro ao criar contato #{i + 1}: #{e.message}"
      end
    end
    puts "Contatos cadastrados com sucesso!"

    puts "Cirando phones para contato!"

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end
    puts "phones para contato criado com sucesso!"

    puts "Criando endreço para os contatos!"
    Contact.all.each do |contact|
      Address.create(
        street: Faker::Address.street_name,
        city: Faker::Address.city,
        contact: contact
      )
    end
    puts "Endereço criado com sucesso!"
  end
end
