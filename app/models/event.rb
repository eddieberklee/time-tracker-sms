class Event < ActiveRecord::Base
  before_save :set_start_time

  def set_start_time
    if self.start_time.nil?
      self.start_time = Time.now.to_datetime
      self.save
    end
  end

  def self.get_last_event
    events = Event.where(:created_at => Time.now-60*60*24..Time.now+60*60*24)
    puts Time.now
    puts Time.now-60*60*12
    puts Time.now+60*60*12
    if events.order(:created_at).size >= 2
      last_event = events.order(:created_at).reverse[1]
    end
  end

end
