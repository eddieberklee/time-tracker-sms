desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
    Person.find(1).send_reminders
end
