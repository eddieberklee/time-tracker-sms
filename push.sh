git status
git ci -am 'automated pushing'
git push origin master
git remote add heroku git@heroku.com:time-tracker-sms.git
git push heroku master
