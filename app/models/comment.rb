# frozen_string_literal: true

class TokenCoin < Sequel::Model
  plugin :timestamps, update_on_create: true
end
