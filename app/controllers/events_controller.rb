class EventsController < ApplicationController
  def index
    @all_events = Event.all.order('created_at')
    @dates = []
    @events = {}
    if not @all_events.first.nil?
      @dates = (@all_events.first.created_at.to_date..@all_events.last.created_at.to_date)
      @dates = @dates.to_a
      unless @dates.include?(Time.now.to_date)
        @dates = @dates.push(Time.now.to_date)
      end
      @today = "#{Time.now.to_date.strftime('%b')} #{Time.now.to_date.day}"
      @events = {}
      @dates = @dates.reverse()
      @dates.each do |d|
        @selected_date = d
        events = Event.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)
        puts events
        events = events.order(:start_time).reverse
        @events[d] = events
      end
    end
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

  def sendm(msg)
    account_sid = "AC550124adbe074b4cfec3d8967b949844"
    auth_token = "e381b44bd42cb00339c62f9f19a4a040"
    client = Twilio::REST::Client.new account_sid, auth_token
    from = "+15103435046"
    to = "+12486223852"
    body = "- - - " + msg
    client.account.messages.create(
      :from => from,
      :to => to,
      :body => body,
    )
  end

  def create
    sender = params[:From]
    body = params[:Body]
    # puts params
     
    # Artificial Intelligence
    temp_body = body
    # SMS
    if temp_body.index('#reminder')
      eddie = Person.find(1)
      eddie.reminders.append(body)
      eddie.save
    end
    # if (temp_body.indexOf('#gym') >= 0 || temp_body.indexOf('#gymtime'))
    #   @me = People.first
    # end
    # Artificial Intelligence End

    puts 'Body' + body
    e = Event.new(:title => body)
    e.save

    last_event = Event.get_last_event

    if not last_event.nil?

      if last_event.end_time.nil? and last_event != e
        last_event.end_time = e.created_at
        last_event.save
      end

      last_event_duration = ((last_event.end_time - last_event.start_time)/60).round(0)

      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "- - - Finished '#{last_event.title}' (#{last_event_duration} min)"
          end
      @t = twiml.text.html_safe
      render :text => @t

    end
  end

  def add_end_time
  end
end
