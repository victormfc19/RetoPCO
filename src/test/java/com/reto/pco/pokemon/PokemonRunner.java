package com.reto.pco.pokemon;

import com.intuit.karate.junit5.Karate;

class PokemonRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("users").relativeTo(getClass());
    }    

}
