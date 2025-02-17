Feature: consult documents of a process
    As a user
    I want to access the documents attached to a process
    so that I can validate the process with the necessary burocracy

Scenario: Anexar um novo documento a um processo
    Given the process “Processo de Alguma Coisa” is stored in the system
    And the system has no document attached to process “Processo de Alguma Coisa” stored
    When I ask the system to store a document “Copia RG do Rel”
    And I tell the system the document “Copia RG do Rel” is attached to process “Processo de Alguma Coisa”
    Then document “Copia RG do Rel” is stored in the system
    And the process “Processo de Alguma Coisa” is stored in the system
    And the document “Copia RG do Rel” is attached to process “Processo de Alguma Coisa”

Scenario: Acessar lista de documentos de um processo filtrados por data
    Given the process “Processo de Alguma Coisa” is stored in the system with documents “Copia RG do Rel”, “Certidao Nascimento Rel” and “Copia Passaporte Rel” attached
    And the document “Copia RG do Rel” is stored in the system with date “3/12/2021”
    And the document “Certidao Nascimento Rel” is stored in the system with date “23/02/2022”
    And the document “Copia Passaporte Rel” is stored in the system with date “9/10/2021”
    When I ask the system for documents attached to process “Processo de Alguma Coisa” with dates before “1/01/2022”
    Then the system returns the documents “Copia RG do Rel” and “Copia Passaporte Rel”
    And the process “Processo de Alguma Coisa” is stored in the system with documents “Copia RG do Rel”, “Certidao Nascimento Rel” and “Copia Passaporte Rel” attached
    And the document “Copia RG do Rel” is stored in the system with date “3/12/2021”
    And the document “Certidao Nascimento Rel” is stored in the system with date “23/02/2022”
    And the document “Copia Passaporte Rel” is stored in the system with date “9/10/2021”

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
    And I don’t see a document “Copia RG do Rel”
    When I attach document
    And I choose the file “Copia RG do Rel” in my local system
    Then I see a success message
    And I still am in the “details” page of process “Processo de Alguma Coisa”
    And I see a document “Copia RG do Rel” attached by “Fulano Detal” at “15:23 UTC-3:00” in “23/02/2022”

Scenario: Acessando documento de um processo existente
    Given I am logged in as user “Fulano Detal” with cpf “123.456.789-19” and password “senha1234”
    And I am in the “details” page of process “Processo de Alguma Coisa”
    And I see a document “Copia RG do Rel” attached by lawyer “Fulano Detal” at “15:23 UTC-3:00” in “23/02/2022”
    When I open details of “Copia RG do Rel”
    Then I visualize the document “Copia RG do Rel”
    And I see it was attached by lawyer “Fulano Detal”
    And I see it was attached at “15:23 UTC-3:00”
    And I see it was attached in “23/02/2022”

Scenario: Removendo documento anexado em processo existente
    Given I am logged in as user “Fulano Detal” with cpf “123.456.789-19” and password “senha1234”
    And I am in the “details” page of process “Processo de Alguma Coisa”
    And I see a document “Copia RG do Rel” attached by lawyer “Fulano Detal” at “15:23 UTC-3:00” in “23/02/2022”
    And I opened details of “Copia RG do Rel”
    When I remove “Copia RG do Rel”
    And I confirm the removal
    Then I still and in the “details” page of process “Processo de Alguma Coisa”
    And I still am logged in as user “Fulano Detal” with cpf “123.456.789-19” and password “senha1234”
    And I don’t see document “Copia RG do Rel”

Scenario: Solicitar documentos do um processo no sistema
    Given the system has documents "Copia RG do Rel", "Certidao Nascimento Rel" and  “Copia Passaporte Rel” stored
    And the system has a process "Processo de Alguma Coisa" stored
    And the process "Processo de Alguma Coisa" has the documents "Copia RG do Rel", "Certidao Nascimento Rel" and  “Copia Passaporte Rel” attached
    When I ask the system for documents attached to process "Processo de Alguma Coisa"
    Then I receive documents "Copia RG do Rel", "Certidao Nascimento Rel" and  “Copia Passaporte Rel”
    And  the system has documents "Copia RG do Rel", "Certidao Nascimento Rel" and  “Copia Passaporte Rel” stored
    And the system has a process "Processo de Alguma Coisa" stored
    And the process "Processo de Alguma Coisa" has the documents "Copia RG do Rel", "Certidao Nascimento Rel" and  “Copia Passaporte Rel” attached

