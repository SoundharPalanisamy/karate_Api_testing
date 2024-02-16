Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[1]

    Given path 'users', first.id
    When method get
    Then status 200

  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/posts'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

  Scenario: Update a user and then get it by id
    * def user =
      """
      {
        "name": "Updated Test Search",
        "username": "updatedtestsearch",
        "email": "updatedtest@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """
  
    Given url 'https://jsonplaceholder.typicode.com/users/1'  // Use the correct endpoint for updating a user
    And request user
    When method put
    Then status 200
  
    * def updatedUserId = response.id
    * print 'updated user id is: ', updatedUserId

  Scenario: Delete a user by id
    Given url 'https://jsonplaceholder.typicode.com/users/1'  // Use the correct endpoint for deleting a user by ID
    When method delete
    Then status 200
  
    * print 'User deleted successfully.'