@REQ_BTDE_78 @agente2
Feature: Test Marvel Characters API

  Background:
    * configure ssl = true

  @id:1 @getOKStatus
  Scenario: T-API-BTDE_78-CA1- Verify if endpoint responds with 200 OK
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters'
    When method GET
    Then status 200
    And print response

  @id:2 @getInternalServerError
  Scenario: T-API-BTDE_78-CA2- Verify if endpoint responds with 500 Internal Server Error
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/'
    When method GET
    Then status 500
    And print response

  @id:3 @getAllCharacters
  Scenario: T-API-BTDE_78-CA3- Verify if endpoint responds with 200 OK and the response isn´t an empty list
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters'
    When method GET
    Then status 200
    And match response != []
    And print response

  @id:4 @getCharacterByIdExists
  Scenario: T-API-BTDE_78-CA4- Verify if endpoint responds with 200 OK witn expected character id
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters/1'
    When method GET
    Then status 200
    And match response.id == 1
    And print response

  @id:5 @getCharacterByIdNotFound
  Scenario: T-API-BTDE_78-CA5- Verify if endpoint responds with 404 because the character id doesn´t exists
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters/9999'
    When method GET
    Then status 404
    And match response.error == "Character not found"
    And print response

  @id:6 @createCharacterSuccess
  Scenario: T-API-BTDE_78-CA6-  Verify if endpoint responds with 201 to create a character successfully
    * header content-type = 'application/json'
    * def user = read('classpath:../data/CreateCharacterRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters'
    And request user
    When method POST
    Then status 201
    And print response

  @id:7 @createCharacterNameDuplicate
  Scenario: T-API-BTDE_78-CA7-  Verify if endpoint responds with 400 with error message Character name already exists
    * header content-type = 'application/json'
    * def user = read('classpath:../data/CreateCharacterDuplicateRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters'
    And request user
    When method POST
    Then status 400
    And match response.error == "Character name already exists"
    And print response

  @id:8 @createCharacterFieldsValidation
  Scenario: T-API-BTDE_78-CA8- Verify that the fields are not null and contain the expected messages
    * header content-type = 'application/json'
    * def user = read('classpath:../data/CreateCharacterFieldsValidationRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters'
    And request user
    When method POST
    Then status 400
    And match response.name == "Name is required"
    And match response.description == "Description is required"
    And match response.powers == "Powers are required"
    And match response.alterego == "Alterego is required"
    And print response

  @id:9 @updateCharacterSuccess
  Scenario: T-API-BTDE_78-CA9- Verify if endpoint responds with 200 to update a character successfully
    * header content-type = 'application/json'
    * def updatedCharacter = read('classpath:../data/UpdateCharacterRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters/1'
    And request updatedCharacter
    When method PUT
    Then status 200
    And match response.description == "Updated description again"
    And print response

  @id:10 @updateCharacterNotFound
  Scenario: T-API-BTDE_78-CA10- Verify if endpoint responds with 404 because the character id does not exist
    * header content-type = 'application/json'
    * def updatedCharacter = read('classpath:../data/UpdateCharacterNoExistsRequest.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters/9999'
    And request updatedCharacter
    When method PUT
    Then status 404
    And match response.error == "Character not found"
    And print response

  @id:11 @deleteCharacterSuccess
  Scenario: T-API-BTDE_78-CA11- Verify if endpoint responds with 204 to delete a character successfully
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters/3'
    When method DELETE
    Then status 204

  @id:12 @deleteCharacterNotExists
  Scenario: T-API-BTDE_78-CA12- Verify if endpoint responds with 404 to delete a character that does not exist
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/jlpuchaa/api/characters/999'
    When method DELETE
    Then status 404
    And match response.error == "Character not found"
    And print response
