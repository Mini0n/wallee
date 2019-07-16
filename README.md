# README

##Wallee

Wallee is an e-Waller/Digital-Wallet project built in RoR.

* Built as an API since the beginning
* User model is simple, secure and extendable <sub>_controller is only 20 lines (**devise** 👀)_</sub>
* Tokenized operations and permissions powered by [JWT](https://jwt.io/)
* Credit card funding and withdrawal (only debit) simul through helper. <sub>ready to add Faraday||Savon real stuff</sub>
* Enforced validations & helpers for each piece
* Complete unit testing &:ExceptionHandler
* Everything is given and received through JSON
* GUI could be anything. Everything can interact with it <sub>it's pretty solud though</sub>
  <sub>expect sniffers, i think, but https</sub>


Technical Stuff

* Ruby version
  ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]

* System dependencies
  No esoteric dependencies were used. I tried to build everything as light as possible.

  * Tests use RSpec with FactoryBot and Faker for tests fabrics
  * Shoulda-matchers makes more pleasant spec code.
  * DatabaseClear was set to ensure clean tests.
  * [CreditCardValidators](https://github.com/Fivell/credit_card_validations) checks and fabricates valid card numbers
  * [JWT](https://jwt.io/) creates and decodes tokens for all operations any operation to be doable

* Database creation && initialization
  0. ``mkdir wallee ; cd wallee``
  1. ``git clone git@github.com:Mini0n/wallee.git``
  2. ``cd wallee``
  3. ``bunble install``
  4. ``rails db:setup``

* How to run the test suite
  * ``rspec``

* ...
