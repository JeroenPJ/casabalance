class Controller
  def initialize(user_repository, view)
    @users = user_repository
    @view = view
  end

  def list
    @view.p("Current user balances:")
    @view.list(@users.all) do |user|
      user.description
    end

    @view.jar(@users.jar)
  end

  def order
    @users.all.each do |user|
      spent = -@view.ask_amount(user, "spent").to_i
      paid = @view.ask_amount(user, "paid").to_i
      user.update_balance(spent + paid)

      @view.clear
    end

    @users.save_csv
    list
  end

  def create
    @view.header
    name = @view.ask_for("name")
    @users.add(User.new(name: name)) unless name == ""
    @view.clear
  end
end
