# ////  @MercadoLibreSearch @Smoke
# Feature: MercadoLibre search
#     Scenario: User search and validate results
#         Given User navigates to MercadoLibre page
#         When User search for cars options
#         Then It should show all the results according to the search ////
@Navegacion @Smoke
Feature: Navegacion pagina K0lmena
  Scenario: Verificar que se pueda navegar la pagina de K0lmena
    Given El usuario esta en la pagina de K0lmena
    When El usurio clickea el link de changelog
    And El usuario clickea la version 2.0
    Then El usuario ve la informacion de la version 2.0