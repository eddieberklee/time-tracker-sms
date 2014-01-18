class EventsController < ApplicationController
  def index
    "Hello"
  end

  def respond_incoming
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey Monkey. Thanks for the message!"
        end
    @t = twiml.text
  end

  def send_message
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
        :body => "- - - Test sending to #{name}!"
      )
    end
    @message = "Sent a message to Eddie!"
  end

  def create
  end

  def add_end_time
  end
end
