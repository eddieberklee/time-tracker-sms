class EventsController < ApplicationController
  def index
    @today = "#{Time.now.to_date.strftime('%b')} #{Time.now.to_date.day}"
    @selected_date = Time.now.to_date
    @events = Event.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)
    @events = @events.order(:start_time)
  end

  def respond_incoming
    sender = params[:From]
    body = params[:Body]
    puts params
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey #{sender}. Thanks for the message: #{body}!"
        end
    @t = twiml.text.html_safe
    render :text => @t
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
    sender = params[:From]
    body = params[:Body]
    # puts params

    e = Event.new(:title => body)
    e.save

    last_event = Event.get_last_event
    if not last_event.nil?
      if last_event.end_time.nil? and last_event != e
        last_event.end_time = e.created_at
        last_event.save
      end
    end

    last_event_duration = last_event.end_time - last_event.start_time

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "- - - You just finished '#{last_event.title}' (duration: #{last_event_duration})"
        end
    @t = twiml.text.html_safe
    render :text => @t
  end

  def add_end_time
  end
end
