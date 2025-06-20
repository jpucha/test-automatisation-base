@REQ_BTDE_78 @agente2
Feature: Obtener todos los personajes

  Background:
    * configure ssl = true

  @id:1 @getOKStatus
  Scenario: T-API-BTDE_78-CA1- Verificar si el endpoint responde 200
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method GET
    Then status 200
    And print response

  @id:2 @getInternalServerError
  Scenario: T-API-BTDE_78-CA2- Verificar si el endpoint responde 500
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/'
    When method GET
    Then status 500
    And print response

  @id:3 @getAllCharacters
  Scenario: T-API-BTDE_78-CA3- Verificar si el endpoint responde 200 y la respuesta no es una lista vacía
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method GET
    Then status 200
    And match response != []
    And print response

  @id:4 @getCharacterByIdExists
  Scenario: T-API-BTDE_78-CA4- Verificar si el endpoint responde 200 con el id de personaje esperado
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/757'
    When method GET
    Then status 200
    And match response.id == 757
    And print response

  @id:5 @getCharacterByIdNotFound
  Scenario: T-API-BTDE_78-CA5- Verificar si el endpoint responde 404 porque el ID del personaje no existe
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999'
    When method GET
    Then status 404
    And print response

  @id:6 @createCharacterSuccess @ignore
  Scenario: T-API-BTDE_78-CA6-  Verificar si el endpoint responde 201 al crear un personaje exitosamente
    * header content-type = 'application/json'
    * def user = read('classpath:../data/CreateCharacterRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request user
    When method POST
    Then status 201
    And print response

  @id:7 @createCharacterNameDuplicate
  Scenario: T-API-BTDE_78-CA7-  Verificar si el endpoint responde 400 con mensaje de error Character name already exists
    * header content-type = 'application/json'
    * def user = read('classpath:../data/CreateCharacterDuplicateRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request user
    When method POST
    Then status 400
    And match response.error == "Character name already exists"
    And print response
