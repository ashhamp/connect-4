require "spec_helper"

describe Connect4Game do
  let(:game) { Connect4Game.new }

  describe ".new" do
    it "has a board and player1 and player2" do
      expect(game.board).to be_a(ConnectFourGrid)
      expect(game.player1).to be_a(Player)
      expect(game.player2).to be_a(Player)
    end
  end

  describe "#player1_name" do
    it "gets player1's name from user" do
      game.player1_name
      allow(game).to receive(:gets).and_return("Ashley")
      expect(game.player1.name).to eq("Ashley")
    end
  end
end
