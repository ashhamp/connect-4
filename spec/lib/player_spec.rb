require "spec_helper"

describe Player do
  let(:player) { Player.new('X') }

  describe ".new" do
    it "should have a name and game piece that is a GamePiece" do
      player.name = "Ashley"
      expect(player.name).to eq("Ashley")
      player.game_piece = 'X'
      expect(player.game_piece).to eq('X')
    end
  end

end
