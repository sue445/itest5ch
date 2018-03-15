RSpec.describe Itest5ch::Comment do
  let(:thread) do
    Itest5ch::Thread.new(
      subdomain: thread_subdomain,
      board:     thread_board,
      dat:       thread_dat,
      name:      thread_name,
    )
  end

  let(:thread_subdomain) { "egg" }
  let(:thread_board)     { "applism" }
  let(:thread_dat)       { 1_517_988_732 }
  let(:thread_name)      { "【自爆運営】ブレイブソード×ブレイズソウル★138【ブレブレ】" }

  let(:comment) do
    Itest5ch::Comment.new(
      number:  number,
      name:    name,
      mail:    mail,
      date:    date,
      id:      id,
      message: message,
      thread:  thread,
    )
  end

  let(:number)  { 1 }
  let(:name)    { "7743" }
  let(:mail)    { "sage" }
  let(:date)    { "2017-12-16 05:43:23".in_time_zone }
  let(:id)      { "AAAAAAA" }
  let(:message) { "test" }

  describe "#anchor_numbers" do
    subject { comment.anchor_numbers }

    context "not found" do
      let(:message) do
        <<~MSG
          Test
        MSG
      end

      it { should be_empty }
    end

    context "with hankaku" do
      let(:message) do
        <<~MSG
          >>10
          >20
          乙
        MSG
      end

      it { should eq [10, 20] }
    end

    context "with zenkaku" do
      let(:message) do
        <<~MSG
          ＞＞３０
          ＞４０
          乙
        MSG
      end

      it { should eq [30, 40] }
    end

    context "with range" do
      let(:message) do
        <<~MSG
          >>10-11
          >20-21
          乙
        MSG
      end

      it { should eq [10, 11, 20, 21] }
    end

    context "with invalid range" do
      let(:message) do
        <<~MSG
          >>10-9
          >20-21
          乙
        MSG
      end

      it { should eq [20, 21] }
    end
  end

  describe "#pc_url" do
    subject { comment.pc_url }

    it { should eq "http://egg.5ch.net/test/read.cgi/applism/1517988732/1" }
  end

  describe "#smartphone_url" do
    subject { comment.smartphone_url }

    it { should eq "http://itest.5ch.net/egg/test/read.cgi/applism/1517988732/1" }
  end

  describe "#id_checker_url" do
    subject { comment.id_checker_url }

    let(:thread_board) { "applism" }
    let(:id)           { "T+wBkVi90" }
    let(:date)         { "2018-02-07 16:32:12".in_time_zone }

    it { should eq "http://hissi.org/read.php/applism/20180207/VCt3QmtWaTkw.html" }
  end
end
