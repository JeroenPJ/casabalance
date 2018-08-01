Dir["app/*.rb"].each { |file| require_relative file }
require_relative 'router'

CSV_DIRECTORY = "data/"

repo = Repository.new(User)
view = View.new

controller = Controller.new(repo, view)

router = Router.new(controller, view)

router.run
