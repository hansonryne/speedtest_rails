class SpeedTest < ApplicationRecord

  def self.get_pings(tests)
    data = {}
    tests.each do |t|
      data[t.created_at.in_time_zone("America/New_York").strftime('%m/%d %H:%M')] = t.ping
    end
    return data.sort
  end

  def self.get_upload_speed(tests)
    data = {}
    tests.each do |t|
      data[t.created_at.in_time_zone("America/New_York").strftime('%m/%d %H:%M')] = t.upload
    end
    return data.sort
  end

  def self.get_download_speed(tests)
    data = {}
    tests.each do |t|
      data[t.created_at.in_time_zone("America/New_York").strftime('%m/%d %H:%M')] = t.download
    end
    return data.sort
  end
end
