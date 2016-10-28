require 'bigdecimal'

class Api::InternalApiController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :http_basic_authenticate

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == ENV['my_http_basic_password']
    end
  end

  def authenticate_with_extra_ids
    client_id       = params[:client_id]
    extra_id        = params[:extra_id]
    minimum_balance = BigDecimal.new(params[:minimum_balance])

    given_account = Account.find_by(extra_id: extra_id)
    if (is_invalid(given_account, minimum_balance))
      render json: [client_id]
      return
    end
  end

  def transfer_with_extra_ids
    from_client_id  = params[:from_client_id]
    from_extra_id   = params[:from_extra_id]
    to_client_id    = params[:to_client_id]
    to_extra_id     = params[:to_extra_id]
    amount          = BigDecimal.new(params[:amount])

    account_from  = Account.find_by(extra_id: from_extra_id)
    account_to    = Account.find_by(extra_id: to_extra_id)
    invalid_accounts = get_invalid_accounts(account_from, account_to, amount, from_client_id, to_client_id)

    if (invalid_accounts.any?)
      render json: invalid_accounts
      return
    end
    if (account_from.id == account_to.id) ; return end

    Account.transaction do
      account_from.balance -= amount
      account_from.save!
      account_to.balance += amount
      account_to.save!
    end
  end

  def get_invalid_accounts(account_from, account_to, amount, from, to)
    invalid_accounts = []
    if is_invalid(account_from, amount); invalid_accounts << from end
    if is_invalid(account_to, amount);   invalid_accounts << to end
    return invalid_accounts
  end

  def is_invalid(account, minimum_balance)
    return account == nil || account.balance < minimum_balance
  end
end