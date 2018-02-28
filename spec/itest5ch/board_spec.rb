RSpec.describe Itest5ch::Board do
  describe ".all" do
    subject { Itest5ch::Board.all }

    before do
      stub_request(:get, Itest5ch::Board::BOARDS_URL).
        to_return(status: 200, body: fixture("index.html"))
    end

    its(:count) { should eq 47 }

    it { expect(subject["家電製品"].count).to eq 23 }
    it { expect(subject["家電製品"]).to include(Itest5ch::Board.new("http://itest.5ch.net/subback/applism", name: "スマホアプリ")) }
  end
end
