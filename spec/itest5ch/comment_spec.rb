RSpec.describe Itest5ch::Comment do
  describe "#anchor_numbers" do
    subject { comment.anchor_numbers }

    let(:comment) do
      Itest5ch::Comment.new(
        number: 1,
        name: "7743",
        mail: "sage",
        date: "2017/12/16(土) 05:43:23.34",
        id: "AAAAAAA",
        message: message,
      )
    end

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
end
