%w[colorize csv json ruby-fann pry thor yaml].each { |gem_name| require gem_name }

%w[cli bot feedback game].each do |file_name|
  require "./lib/#{file_name}"
end

ROOT_PATH       = Dir.pwd.freeze
LOCALES         = YAML.load_file('./config/locales.yml').freeze
JSON_FEEDBACK   = "#{ROOT_PATH}/replayer/assets/data.json".freeze
SLEEPER_IN_SEC  = 1
MAX_LOOP        = 100
MAX_EPOCH       = 100
MAX_ERRORS      = 10
DESIRED_MSE     = 0.05

BotVsGame::CLI.start(ARGV)
