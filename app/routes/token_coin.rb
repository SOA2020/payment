# frozen_string_literal: true

TOKEN_COIN_ROUTE = proc do
  # Create Token Coin record for new users
  post '' do
    req = JSON.parse(request.body.read)
    user_id = req['userId']
    token_coin = req['tokenCoin']
    raise BadRequestError.new('Wrong Arguments') if user_id.nil? || token_coin.nil?
    TokenCoin.create(
      user_id: user_id,
      token_coin: token_coin
    )
    yajl :empty
  end

  # Get a user's balance
  get '' do
    user_id = params['userId']
    raise BadRequestError.new('Wrong Arguments') if user_id.nil?

    entity = TokenCoin.where(user_id: user_id)&.first
    raise NotFoundError.new("User: #{user_id}", 'User Not Existed') if entity.nil?

    yajl :token_coin, locals: { token_coin: entity }
  end

  # Update a user's balance
  put '' do
    req = JSON.parse(request.body.read)
    user_id = req['userId']
    token_coin = req['tokenCoin']
    raise BadRequestError.new('Wrong Arguments') if user_id.nil? || token_coin.nil?

    entity = TokenCoin.where(user_id: user_id)&.first
    raise NotFoundError.new("User: #{user_id}", 'User Not Existed') if entity.nil?

    entity.token_coin = token_coin
    entity.save

    yajl :token_coin, locals: { token_coin: entity }
  end
end
