@GithubRegistro @Smoke
Feature: Registro

  Scenario: Registro exitoso con todos los campos obligatorios
    Given El usuario se encuentra en la pagina de registro de Github
    When El usuario completa el campo "EMAIL" con "cynthia+01@gmail.com"
    And El usuario completa el campo "CONTRASEÑA" con "@Underc0de12345"
    And El usuario completa el campo "USERNAME" con "Cynthia2025Qarmy"
    And El usuario hace click en el dropdown pais
    And El usuario escribe "Argentina" en el campo de busqueda y lo selecciona
    And El usuario hace click en el boton CREATE ACCOUNT
    Then El usuario deberia ser redireccionado a la pantalla de confirmacion de email

  Scenario: Registro incorrecto con email sin estructura valida
    Given El usuario se encuentra en la pagina de registro de Github
    When El usuario completa el campo "EMAIL" con "cynthia"
    And El usuario completa el campo "CONTRASEÑA" con "@Underc0de12345"
    And El usuario completa el campo "USERNAME" con "Cynthia2025Qarmy"
    And El usuario hace click en el dropdown pais
    And El usuario escribe "Argentina" en el campo de busqueda y lo selecciona
    And El usuario hace click en el boton CREATE ACCOUNT
    Then El sistema deberia permanecer en la pagina de registro
    And El usuario deberia ver un mensaje de error

  Scenario: Registro incorrecto con contraseña debil
    Given El usuario se encuentra en la pagina de registro de Github
    When El usuario completa el campo "EMAIL" con "cynthia+neg1@gmail.com"
    And El usuario completa el campo "CONTRASEÑA" con "12345"
    And El usuario completa el campo "USERNAME" con "Cynthia2025Qarmy2"
    And El usuario hace click en el dropdown pais
    And El usuario escribe "Argentina" en el campo de busqueda y lo selecciona
    And El usuario hace click en el boton CREATE ACCOUNT
    Then El sistema deberia permanecer en la pagina de registro
    And El usuario deberia ver un mensaje de error

  Scenario: Registro incorrecto con username invalido
    Given El usuario se encuentra en la pagina de registro de Github
    When El usuario completa el campo "EMAIL" con "cynthia+neg2@gmail.com"
    And El usuario completa el campo "CONTRASEÑA" con "@Underc0de12345"
    And El usuario completa el campo "USERNAME" con "inválido!!!"
    And El usuario hace click en el dropdown pais
    And El usuario escribe "Argentina" en el campo de busqueda y lo selecciona
    And El usuario hace click en el boton CREATE ACCOUNT
    Then El sistema deberia permanecer en la pagina de registro
    And El usuario deberia ver un mensaje de error

  Scenario: Registro incorrecto sin seleccionar pais
    Given El usuario se encuentra en la pagina de registro de Github
    When El usuario completa el campo "EMAIL" con "cynthia+neg3@gmail.com"
    And El usuario completa el campo "CONTRASEÑA" con "@Underc0de12345"
    And El usuario completa el campo "USERNAME" con "Cynthia2025Qarmy3"
    # A propósito no se selecciona país
    And El usuario hace click en el boton CREATE ACCOUNT
    Then El sistema deberia permanecer en la pagina de registro
    And El usuario deberia ver un mensaje de error