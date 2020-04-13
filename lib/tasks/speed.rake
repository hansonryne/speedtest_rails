namespace :speed do
  desc 'Creates a new SpeedTest record'
  task run_test: :environment do
    new_test = Speedtest::Test.new(
      download_runs: 2,
      upload_runs: 2,
      ping_runs: 2,
      download_sizes: [750, 1500],
      upload_sizes: [10000, 400000],
      debug: true
    )
    results = new_test.run
    SpeedTest.create(
      ping: results.latency,
      upload: (results.upload_rate / 1000000.0),
      download: (results.download_rate / 1000000.0),
      server: results.server
    )
  end
end
