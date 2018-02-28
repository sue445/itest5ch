module FixtureUtil
  def fixture(fixture_name)
    spec_dir.join("support", "fixtures", fixture_name).read
  end
end

RSpec.configure do |config|
  config.include FixtureUtil
end
