RSpec.describe Itest5ch::Board do
  before do
    stub_request(:get, Itest5ch::Board::BOARDS_URL).
      to_return(status: 200, body: fixture("index.html"))
  end

  describe ".all" do
    subject { Itest5ch::Board.all }

    its(:count) { should eq 47 }

    it { expect(subject["家電製品"].count).to eq 23 }
    it { expect(subject["家電製品"]).to include(Itest5ch::Board.new("http://itest.5ch.net/subback/applism", name: "スマホアプリ")) }
  end

  describe ".find_category_boards" do
    subject { Itest5ch::Board.find_category_boards(category_name) }

    let(:category_name) { "家電製品" }
    its(:count) { should eq 23 }

    its([0]) { should eq Itest5ch::Board.new("http://itest.5ch.net/subback/kaden", name: "家電製品") }
  end

  describe ".find" do
    subject { Itest5ch::Board.find(board_name) }

    context "with board name" do
      let(:board_name) { "スマホアプリ" }

      it { should eq Itest5ch::Board.new("http://itest.5ch.net/subback/applism", name: "スマホアプリ") }
    end

    context "with board id" do
      let(:board_name) { "applism" }

      it { should eq Itest5ch::Board.new("http://itest.5ch.net/subback/applism", name: "スマホアプリ") }
    end
  end
end
