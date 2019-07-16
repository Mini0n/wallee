require 'credit_card_validations/string'

class CardCallback

  # Just a simple delay to simulate a response waiting
  def self.simulate(card_number)
    if card_number.to_s.valid_credit_card_brand?
      sleep(2.seconds)
      true
    else
      false
    end
  end
end