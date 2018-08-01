class Router
  def initialize(controller, view)
    @controller = controller
    @view = view

    @running = true
  end

  def run
    @view.welcome
    @controller.list

    while @running
      display_tasks
      action = @view.ask_for("action")
      @view.clear
      perform(action)
    end
  end

  def perform(action)
    index = action.to_i - 1

    if index >= 0 && index < tasks.size
      task = tasks[index][1]
      task[0].send(task[1])
    else
      @view.invalid_action
    end
  end

  def display_tasks
    @view.header
    @view.list_with_index(tasks.map(&:first))
  end

  def tasks
    [
      ["List users", [@controller, :list]],
      ["Add order", [@controller, :order]],
      ["Create user", [@controller, :create]],
      ["Exit program", [self, :stop]],
    ]
  end

  def stop
    @running = false
  end
end
