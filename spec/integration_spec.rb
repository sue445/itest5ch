RSpec.describe Itest5ch, type: :integration do
  around do |example|
    WebMock.disable!

    example.run

    WebMock.enable!
  end

  it "successful real http connection" do # rubocop:disable RSpec/ExampleLength
    category_and_boards = Itest5ch::Board.all

    expect(category_and_boards).to be_an_instance_of(Hash)

    boards = category_and_boards.values.flatten

    aggregate_failures do
      expect(boards).not_to be_empty
      expect(boards).to all(be_an_instance_of(Itest5ch::Board))
    end

    board = boards.sample

    threads = board.threads

    aggregate_failures do
      expect(threads).not_to be_empty
      expect(threads).to all(be_an_instance_of(Itest5ch::Thread))
    end

    thread = threads.sample

    comments =
      Retryable.retryable(tries: 5, on: JSON::ParserError) do
        thread.comments
      end

    aggregate_failures do
      expect(comments).not_to be_empty
      expect(comments).to all(be_an_instance_of(Itest5ch::Comment))
    end
  end
end
