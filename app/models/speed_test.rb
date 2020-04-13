class SpeedTest < ApplicationRecord

  def self.get_pings(tests)
    data = {}
    tests.each do |t|
      data[t.created_at.strftime('%H:%M %m/%d')] = t.ping
    end
    return data.sort
  end

  def self.get_upload_speed(tests)
    data = {}
    tests.each do |t|
      data[t.created_at.strftime('%H:%M %m/%d')] = t.upload
    end
    return data.sort
  end

  def self.get_download_speed(tests)
    data = {}
    tests.each do |t|
      data[t.created_at.strftime('%H:%M %m/%d')] = t.download
    end
    return data.sort
  end
end
