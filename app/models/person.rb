class Person < ActiveRecord::Base
  serialize :personality, Hash
  serialize :reminders, Array
end
