# README

## Wallee

Wallee is an e-Waller/Digital-Wallet project built in RoR.

* Built as an API since the beginning
* User model is simple, secure and extendable <sub>_controller is only 20 lines (**devise** 👀)_</sub>
* Tokenized operations and permissions powered by [JWT](https://jwt.io/)
* Credit card funding and withdrawal (only debit) simul through helper. <sub>ready to add Faraday||Savon real stuff</sub>
* Enforced validations & helpers for each piece
* Complete unit testing &:ExceptionHandler
* Everything is given and received through JSON
* Any GUI and interacction <sub>yet pretty solud though</sub>
  <sub>expect sniffers, i think, but https</sub>

#### Technical Stuff

* Ruby on Rails
  * ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]
  * Rails 5.2.3
* System dependencies
  No esoteric dependencies were used. I tried to build everything as light as possible.
  * Tests use RSpec with FactoryBot and Faker for tests fabrics
  * Shoulda-matchers makes more pleasant spec code.
  * DatabaseClear was set to ensure clean tests.
  * [CreditCardValidators](https://github.com/Fivell/credit_card_validations) checks and fabricates valid card numbers
  * [JWT](https://jwt.io/) creates and decodes tokens for all operations any operation to be doable

* Database creation && initialization
  1. ``mkdir wallee ; cd wallee``
  2. ``git clone git@github.com:Mini0n/wallee.git``
  3. ``cd wallee``
  4. ``bunble install``

  5. ``rails db:setup``
* How to run the test suite
  * ``rspec``

### Running

  * You can start the project with ``rails s`` or ``rails c``
    to execute any actions

### Trying it

  Here are some actions you can run with the help of ``curl`` it is important to note
  that the Auhorization is the one you get when logged in, so it must be changed with the one received

* Create User
``curl -d '{"name":"Test", "email":"test@test.com", "password":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:3000/signup``

* Create User 2 (for tests)
``curl -d '{"name":"Test2", "email":"test@test.com", "password":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:3000/signup``

* Login as Test
``curl -d '{"email":"test@test.com", "password":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:3000/auth/login``

* Read user cards [use gotten token]
``curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMyOTIwMTJ9.4d6dJ3ibE9ETDOGF3OwY3k4xqJcuWY3OIkZa03hFDmw" http://localhost:3000/cards``

* Create Card [debit]
``curl -d '{"name":"forbrugsforeningen", "name_on_card":"Maryanne Graham", "number":"2223412178883462", "expiry":"Fri, 10 Apr 2020", "debit":"true"}' -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMzNDM1NjR9.slo5R0LAqjRTTieS2QTVbRfUg68hm_TiPsSlBbNgmHY" -H "Content-Type: application/json" -X POST http://localhost:3000/cards``

* Create Card [credit]
``curl -d '{"name":"solo", "name_on_card":"Zackary Doyle", "number":"378083476107313", "expiry":"Fri, 10 Apr 2020", "debit":"false"}' -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMzNDM1NjR9.slo5R0LAqjRTTieS2QTVbRfUg68hm_TiPsSlBbNgmHY" -H "Content-Type: application/json" -X POST http://localhost:3000/cards``

* Fund Wallet
  ``curl -d '{"amount":"1000", "card_origin_id":"2", "wallet_destiny_id":"1"}' -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMzNDM1NjR9.slo5R0LAqjRTTieS2QTVbRfUg68hm_TiPsSlBbNgmHY" -H "Content-Type: application/json" -X POST http://localhost:3000/transactions``

* Withdraw from Wallet
  ``curl -d '{"amount":"1000", "card_destiny_id":"1", "wallet_origin_id":"1"}' -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMzNDM1NjR9.slo5R0LAqjRTTieS2QTVbRfUg68hm_TiPsSlBbNgmHY" -H "Content-Type: application/json" -X POST http://localhost:3000/transactions``

* Transfer to Wallet
  ``curl -d '{"amount":"100", "wallet_origin_id":"1", "wallet_destiny_id":"2"}' -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMzNDM1NjR9.slo5R0LAqjRTTieS2QTVbRfUg68hm_TiPsSlBbNgmHY" -H "Content-Type: application/json" -X POST http://localhost:3000/transactions``

* Review Transactons
  ``curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjMyOTIwMTJ9.4d6dJ3ibE9ETDOGF3OwY3k4xqJcuWY3OIkZa03hFDmw" http://localhost:3000/transactions``
