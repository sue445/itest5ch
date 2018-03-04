RSpec.describe Itest5ch::Thread do
  let(:thread) do
    Itest5ch::Thread.new(
      subdomain: subdomain,
      board:     board,
      dat:       dat.to_i,
    )
  end

  let(:subdomain) { "egg" }
  let(:board)     { "applism" }
  let(:dat)       { 1_517_988_732 }
  let(:rand)      { "1234567890" }

  describe "#comments" do
    subject(:comments) { thread.comments }

    before do
      allow(thread).to receive(:rand) { rand }

      stub_request(:get, "http://itest.5ch.net/public/newapi/client.php?board=#{board}&dat=#{dat}&rand=#{rand}&subdomain=#{subdomain}").
        to_return(status: 200, body: fixture("applism_1517988732.json"))
    end

    its(:count) { should eq 1_002 }

    describe "[0]" do
      subject { comments[0] }

      let(:message) do
        <<~MSG.strip
          !extend:checked:vvvv:1000:512
          !extend:checked:vvvv:1000:512
          ☆スレ立て時↑が3行になるようにコピペして下さい


          欲しかったのは、鍵を開ける勇気。
          手にしたモノは、悪魔の力。

          魔剣たちはいつだって笑顔で、
          そして、残酷だ。

          真実はあまりにも、痛い。

          公式 http://grimoire.co/bxb/
          公式twitter https://twitter.com/bra_x_bla?lang=ja
          公式ヘルプ https://bxb.grimoire.codes/help_categories
          ブレブレwiki　http://s.gaym.jp/iPhone/bravesword-blazesoul/

          次スレは>>950 が宣言をしてからスレを立ててください。
          無理そうなら>>980 までに安価指定するか、踏み逃げの場合宣言をしてから立ててください。
          スレ立ての際に>>1の1行目に
          「!extend:checked:vvvv:1000:512」
          を書き込むこと。
          忘れると荒らされてスレのみんなが悲しみます。
          ※前スレ
          【自爆運営】ブレイブソード×ブレイズソウル★138【ブレブレ】
          https://egg.5ch.net/test/read.cgi/applism/1515815622/l50 VIPQ2_EXTDAT: checked:vvvv:1000:512:----: EXT was configured
        MSG
      end

      its(:number)  { should eq 1 }
      its(:name)    { should eq "名無しさん＠お腹いっぱい。 (６段) (ﾜｯﾁｮｲ 60.101.77.254)" }
      its(:mail)    { should eq "" }
      its(:date)    { should eq "2018-02-07 16:32:12".in_time_zone }
      its(:id)      { should eq "T+wBkVi90" }
      its(:message) { should eq message }
    end

    describe "[29]" do
      subject { comments[29] }

      let(:message) do
        <<~MSG.strip
          ルルメが道路標識なぐさめてるタイトル絵がまぁじ尊い やばみがふかみ
        MSG
      end

      its(:number)  { should eq 30 }
      its(:name)    { should eq "名無しさん＠お腹いっぱい。 (ﾜｯﾁｮｲWW 223.133.189.98)" }
      its(:mail)    { should eq "sage" }
      its(:date)    { should eq "2018-02-09 10:12:02".in_time_zone }
      its(:id)      { should eq "nlJjIXKK0" }
      its(:message) { should eq message }
    end
  end
end
