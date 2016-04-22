require 'net/sftp'

class MyFiles
  def self.upload(host, username, password)
    Net::SFTP.start(host, username, password: password) do |sftp|
      sftp.upload!("./example.txt", "~/example.txt")
    end
  end
end
