class EventsController < ApplicationController
  def index
    @all_events = Event.all.order('created_at')
    @dates = []
    @events = {}

    if not @all_events.nil?
      if not @all_events.first.nil?
        @dates = (@all_events.first.created_at.to_date..@all_events.last.created_at.to_date)
        @dates = @dates.to_a
        unless @dates.include?(Time.now.to_date)
          @dates = @dates.push(Time.now.to_date)
        end
        @dates = @dates.reverse()

        @today = "#{Time.now.to_date.strftime('%b')} #{Time.now.to_date.day}"

        @dates.each do |d|
          events = Event.where(:created_at => d.beginning_of_day..d.end_of_day)
          puts events
          events = events.order(:start_time).reverse
          @events[d] = events
        end
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
    account_sid = "AC5eb6b5af49fe93e6948fcfaae2e1489d"
    auth_token = "79caddc95ca00f03317972acd999dc20"
    client = Twilio::REST::Client.new account_sid, auth_token
    from = "+12483657429"
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
    account_sid = "AC5eb6b5af49fe93e6948fcfaae2e1489d"
    auth_token = "79caddc95ca00f03317972acd999dc20"
    client = Twilio::REST::Client.new account_sid, auth_token
    from = "+12483657429"
    to = "+12486223852"
    body = "- - - " + msg
    client.account.messages.create(
      :from => from,
      :to => to,
      :body => body,
    )
  end

  def special_command(body)
    body = body.downcase

    if body == 'delete' or body == 'delete last' or body == 'del'
      last_event = Event.get_last_event
      last_event.destroy
      return true
    end

    lastEvent = ['last', 'last activity', 'last tracked', 'what did i just do', \
                 'what did i last do', 'last thing i did', 'last thing']
    if lastEvent.index(body)
      last_event = Event.get_last_event
      last_event_message = "#{last_event.title} #{last_event.duration}"
      sendm(last_event_message)
      return true
    end

    return false
  end

  def create
    sender = params[:From]
    body = params[:Body]

    if special_command(body)
      return # if one of the special commands caught on, we should skip the following code
    end

    # Artificial Intelligence
    temp_body = body
    # SMS
    if temp_body.index('#reminder')
      eddie = Person.find(1)
      eddie.reminders.append(body)
      eddie.save
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "- - - Reminder saved!"
          end
      @t = twiml.text.html_safe
      render :text => @t
      return
    end

    # if (temp_body.indexOf('#gym') >= 0 || temp_body.indexOf('#gymtime'))
    #   @me = People.first
    # end
    # Artificial Intelligence End

    e = Event.new(:title => body)
    e.save

    last_event = Event.get_last_event

    if not last_event.nil?

      if last_event.end_time.nil? and last_event != e
        last_event.end_time = e.created_at
        last_event.save
      end
    end

    render :text => "" # CHECK IF THIS GETS RID OF TWILIO GIVING A WARNING

    # twiml = Twilio::TwiML::Response.new do |r|
    #   r.Message ". . . Finished '#{last_event.title}' (#{last_event_duration} min)"
    #     end
    # @t = twiml.text.html_safe
    # render :text => @t

  end

  def add_end_time
  end
end
