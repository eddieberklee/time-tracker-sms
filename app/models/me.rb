class Event < ActiveRecord::Base
  serialize :personality, Hash
  serialize :reminders, Hash
end
