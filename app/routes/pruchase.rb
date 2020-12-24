# frozen_string_literal: true

PURCHASE_ROUTE = proc do
  # Purchase some goods
  post '' do
    req = JSON.parse(request.body.read)
    price = req['price'].to_i
    count = req['count'].to_i
    user_id = req['userId']
    raise BadRequestError.new('Wrong Arguments') if price.nil? || count.nil? || user_id.nil?

    entity = TokenCoin.where(user_id: user_id)&.first
    raise NotFoundError.new("User: #{user_id}", 'User Not Existed') if entity.nil?

    total = price * count

    raise BadRequestError.new('Token Coin Not Enough') if entity.token_coin < total

    entity.token_coin -= total
    entity.save

    # Return new balance
    yajl :token_coin, locals: { token_coin: entity }
  end
end
