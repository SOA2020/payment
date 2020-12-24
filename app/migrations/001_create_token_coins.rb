# frozen_string_literal: true

Sequel.migration do
  transaction
  change do
    create_table(:token_coins) do
      primary_key :id
      String :user_id, size: 255, null: false, unique: true
      Integer :token_coin, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
