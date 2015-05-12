class GameCreationService
  def self.create(params, user)
    game = Game.create(params)
    game.subscribe(user, role: :master) if game.valid?
    game
  end
end
