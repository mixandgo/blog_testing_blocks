require 'minitest/autorun'
require_relative './example'

describe MyFiles do
  describe '.upload' do
    it "invokes #upload! on the Net::SFTP's block argument" do
      conn_info = [ 'host', 'user', { password: 'secret' } ]

      # We're mocking the argument (`sftp` in our case) that is sent to the
      # block.
      sftp_mock = Minitest::Mock.new

      # We want to know that the implementation is calling the `upload!` method
      # with these exact arguments.
      sftp_mock.expect :upload!, true, ['./example.txt', '~/example.txt']

      # The third argument to the `stub` method stands for the block argument
      # (`sftp` in our case).
      Net::SFTP.stub :start, conn_info, sftp_mock do
        # For the duration of this block, the `start` method on the `Net::SFTP`
        # class is stubbed and the block argument it receives is our
        # `sftp_mock`.
        MyFiles.upload('mixandgo.com', 'cezar', 'secret')
      end

      sftp_mock.verify
    end
  end
end
