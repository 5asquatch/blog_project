RSpec.configure do |config|
    
    config.before (:suite) do
        DatabaseCleaner.clean.without(:truncation)
    end

    config.before (:each) do
        DatabaseCleaner.strategy = Capybara.current_driver == :rack_test ? :transaction : :truncation
        DatabaseCleaner.start
    end

    config.after (:each) do
        DatabaseCleaner.clean
    end
end