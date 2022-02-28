Feature: consult documents of a process
    As a user
    I want to access the documents attached to a process
    so that I can validate the process with the necessary burocracy

Scenario: Anexar um novo documento a um processo
    Given the process “Processo de Alguma Coisa” is stored in the system
    And the system has no document attached to process “Processo de Alguma Coisa” stored
    When I ask the system to store a document “Copia RG do Rel.pdf”
    And I tell the system the document “Copia RG do Rel.pdf” is attached to process “Processo de Alguma Coisa”
    Then document “Copia RG do Rel.pdf” is stored in the system
    And the process “Processo de Alguma Coisa” is stored in the system
    And the document “Copia RG do Rel.pdf” is attached to process “Processo de Alguma Coisa”

Scenario: Acessar lista de documentos de um processo filtrados por data
    Given the process “Processo de Alguma Coisa” is stored in the system with documents “Copia RG do Rel.pdf”, “Certidao Nascimento Rel.pdf” and “Copia Passaporte Rel.pdf” attached
    And the document “Copia RG do Rel.pdf” is stored in the system with date “3/12/2021”
    And the document “Certidao Nascimento Rel.pdf” is stored in the system with date “23/02/2022”
    And the document “Copia Passaporte Rel.pdf” is stored in the system with date “9/10/2021”
    When I ask the system for documents attached to process “Processo de Alguma Coisa” with dates before “1/01/2022”
    Then the system returns the documents “Copia RG do Rel.pdf” and “Copia Passaporte Rel.pdf”
    And the process “Processo de Alguma Coisa” is stored in the system with documents “Copia RG do Rel.pdf”, “Certidao Nascimento Rel.pdf” and “Copia Passaporte Rel.pdf” attached
    And the document “Copia RG do Rel.pdf” is stored in the system with date “3/12/2021”
    And the document “Certidao Nascimento Rel.pdf” is stored in the system with date “23/02/2022”
    And the document “Copia Passaporte Rel.pdf” is stored in the system with date “9/10/2021”

Scenario: Acessando processo existente do usuário
    Given I am logged in as user “Fulano Detal” with cpf “123.456.789-10” and password “senha1234”
    And I am in the “processes” page
    And I see a process “Processo de Alguma Coisa”
    When I open details of process “Processo de Alguma Coisa”
    Then I am in the “details” page of process “Processo de Alguma Coisa”

Scenario: Anexando documento em um processo existente
    Given I am logged in as user “Fulano Detal” with cpf “123.456.789-10” and password “senha1234”
    And the date is “23/02/2022”
    And the local time is “15:23 UTC-3:00”
    And I am in the “details” page of process “Processo de Alguma Coisa”
    And I don’t see a document “Copia RG do Rel.pdf”
    When I attach document
    And I choose the file “Copia RG do Rel.pdf” in my local system
    Then I see a success message
    And I still am in the “details” page of process “Processo de Alguma Coisa”
    And I see a document “Copia RG do Rel.pdf” attached by “Fulano Detal” at “15:23 UTC-3:00” in “23/02/2022”

