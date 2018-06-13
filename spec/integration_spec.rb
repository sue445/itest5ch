RSpec.describe Itest5ch, type: :integration do
  around do |example|
    WebMock.disable!

    example.run

    WebMock.enable!
  end

  it "successful real http connection" do # rubocop:disable RSpec/ExampleLength
    category_and_boards = Retryable.with_context(:default) do
      Itest5ch::Board.all
    end

    expect(category_and_boards).to be_an_instance_of(Hash)

    boards = category_and_boards.values.flatten

    aggregate_failures do
      expect(boards).not_to be_empty
      expect(boards).to all(be_an_instance_of(Itest5ch::Board))
    end

    board = boards.sample

    thread_exception_cb = proc do |_exception|
      puts "Error: #{board.json_url}"
    end

    threads = Retryable.with_context(:default, exception_cb: thread_exception_cb) do
      board.threads
    end

    aggregate_failures do
      expect(threads).not_to be_empty
      expect(threads).to all(be_an_instance_of(Itest5ch::Thread))
    end

    thread = threads.sample

    comment_exception_cb = proc do |_exception|
      puts "Error: #{thread.json_url}"
    end

    comments = Retryable.with_context(:default, exception_cb: comment_exception_cb) do
      thread.comments
    end

    aggregate_failures do
      expect(comments).not_to be_empty
      expect(comments).to all(be_an_instance_of(Itest5ch::Comment))
    end
  end
end
