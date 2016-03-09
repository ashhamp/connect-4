class Player
  attr_reader  :game_piece
  attr_accessor :name

  def initialize(game_piece)
    @game_piece = game_piece
    @name = name
  end
end
