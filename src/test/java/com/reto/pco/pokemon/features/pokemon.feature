Feature:

  Background:
    * url 'https://pokeapi.co/api/v2/pokemon'
    * def order = Java.type('com.reto.pco.utils.Order')

    Scenario: 1. Realizar prueba de contrato y validar respuesta exitosa y statuscode 200.
      * def namePokemon = 'squirtle'
      And path namePokemon
      When method GET
      Then status 200
      And match response == read('classpath:com/reto/pco/pokemon/response/squirtle-res.json')


    Scenario Outline: 2. Encontrar los nombres de las evoluciones y hacer match con los ejemplos
      And path '<namePokemon>'
      When method GET
      Then status 200
      * def urlEvolution2 = response.species.url

      Given url urlEvolution2
      When method GET
      Then status 200
      * def urlEvolutonChain3 = response.evolution_chain.url

      Given url urlEvolutonChain3
      When method GET
      Then status 200

      * def nameEvolution2 = response.chain.evolves_to[0].species.name
      * def nameEvolution3 = response.chain.evolves_to[0].evolves_to[0].species.name

      And match nameEvolution2 == '<PokemonEvolution_2>'
      And match nameEvolution3 == '<PokemonEvolution_3>'

      Examples:
        | namePokemon | PokemonEvolution_2 | PokemonEvolution_3   |
        | charmander  | charmeleon         | charizard            |



    Scenario: 3. Obtener el listado de solo nombres de movimientos del Pokemon squirtle y ordenarlos en orden alfabetico de la A a la Z. Sin la propiedad .sort()
      * def namePokemon = 'squirtle'
      And path namePokemon
      When method GET
      Then status 200
      * def array = response.moves.map(x => x.move.name)
      * def listNames = order.namesByBubble(array)
      * print JSON.stringify(listNames)


    Scenario Outline: 4. Obtener el secret power del pokemon Pikachu y validar que su valor sea 70
      And path '<namePokemon>'
      When method GET
      Then status 200
      * def urlSecretPower = response.moves.find(x => x.move.name == 'secret-power').move.url

      Given url urlSecretPower
      When method GET
      Then status 200
      And match response.power == <power-secretpower>

      Examples:
        | namePokemon | power-secretpower |
        | pikachu     |        70         |

  