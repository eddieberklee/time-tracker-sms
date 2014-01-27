class Person < ActiveRecord::Base
  serialize :personality, Hash
  serialize :reminders, Array

  def send_reminders
    account_sid = "AC550124adbe074b4cfec3d8967b949844"
    auth_token = "e381b44bd42cb00339c62f9f19a4a040"
    client = Twilio::REST::Client.new account_sid, auth_token
    from = "+15103435046"
    friends = {
      "+12486223852" => "Eddie Lee",
    }
    friends.each do |phone, name|
      client.account.messages.create(
        :from => from,
        :to => phone,
        :body => "- - - Don't forget to time-track. Take 30 seconds to log."
      )
    end
  end


end
