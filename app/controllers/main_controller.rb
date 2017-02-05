class MainController < Controller
  def index
    @test = "Le testing text information"
    @arr = %w(one two three)
  end
end
