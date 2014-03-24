class Person < ActiveRecord::Base
  serialize :personality, Hash
  serialize :reminders, Array

  def send_reminders
    account_sid = "ACa2881e70c9136176e5fed5efa17d161d"
    auth_token = "eef3c20c01b13d6bf1540e8ee721b6b6"
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
