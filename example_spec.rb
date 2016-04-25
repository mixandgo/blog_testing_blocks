# This is the RSpec version of the Minitest example
require_relative './example'

RSpec.describe MyFiles do
  describe '.upload' do
    it "invokes #upload! on the Net::SFTP's block argument" do
      conn_info = [ 'mixandgo.com', 'cezar', { password: 'secret' } ]

      # We're mocking the argument (`sftp` in our case) that is sent to the
      # block.
      sftp_mock = double.as_null_object
      allow(Net::SFTP).to receive(:start).with(*conn_info).and_yield(sftp_mock)

      # We want to know that the implementation is calling the `upload!` method
      # with these exact arguments.
      expect(sftp_mock).to receive(:upload!).with('./example.txt', '~/example.txt')

      MyFiles.upload('mixandgo.com', 'cezar', 'secret')
    end
  end
end

