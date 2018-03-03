RSpec.describe Itest5ch::Board do
  before do
    stub_request(:get, Itest5ch::Board::BOARDS_URL).
      to_return(status: 200, body: fixture("index.html"))
  end

  let(:board) { Itest5ch::Board.new("http://itest.5ch.net/subback/applism") }

  describe "#threads" do
    subject { board.threads }

    before do
      stub_request(:get, "http://itest.5ch.net/subbacks/applism.json").
        to_return(status: 200, body: fixture("applism.json"))
    end

    its(:count) { should eq 632 }

    its("first.subdomain")      { should eq "egg" }
    its("first.board")          { should eq "applism" }
    its("first.dat")            { should eq 1_519_836_119 }
    its("first.name")           { should eq "【マギレコ】マギアレコード 魔法少女まどか☆マギカ外伝 877周目" }
    its("first.comments_count") { should eq 249 }
  end

  describe ".json_url" do
    subject { Itest5ch::Board.json_url(url) }

    context "with Smartphone url" do
      let(:url) { "http://itest.5ch.net/subback/applism/" }

      it { should eq "http://itest.5ch.net/subbacks/applism.json" }
    end

    context "with PC url" do
      let(:url) { "https://egg.5ch.net/applism/" }

      it { should eq "http://itest.5ch.net/subbacks/applism.json" }
    end
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

    its("first.url")  { should eq "http://itest.5ch.net/subback/kaden" }
    its("first.name") { should eq "家電製品" }
  end

  describe ".find" do
    subject { Itest5ch::Board.find(board_name) }

    context "with board name" do
      let(:board_name) { "スマホアプリ" }

      its(:url)  { should eq "http://itest.5ch.net/subback/applism" }
      its(:name) { should eq "スマホアプリ" }
    end

    context "with board id" do
      let(:board_name) { "applism" }

      its(:url)  { should eq "http://itest.5ch.net/subback/applism" }
      its(:name) { should eq "スマホアプリ" }
    end
  end
end
