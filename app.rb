require 'yaml'

# ROUTES will be how our app decides how to route.
# It will always load from routes.yml If you want to change
# the routes for your application, change the routes.yml file.
ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), "app", "routes.yml")))

#This is so there are no confusion between users calling controllers in the app
#This connects controllers to our application, as well as our lib folder.
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each { |file| require file}

require "./lib/router"

class App
  attr_reader :router

  #Define the routes for our app when the app is initialized.
  def initialize
    @router = Router.new(ROUTES)
  end

  #returning the result's status, headers, and content
  #allows our application to meet the requirements of a Rack interface.
  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end

  def self.root
    File.dirname(__FILE__)
  end
end
