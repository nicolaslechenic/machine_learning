%w[colorize ruby-fann pry thor yaml].each { |gem_name| require gem_name }

%w[cli bot displayer game].each do |file_name|
  require "./lib/#{file_name}"
end

LOCALES         = YAML.load_file('./config/locales.yml').freeze
SLEEPER_IN_SEC  = 1
MAX_LOOP        = 100
MAX_EPOCH       = 100
MAX_ERRORS      = 10
DESIRED_MSE     = 0.05

BotVsGame::CLI.start(ARGV)
