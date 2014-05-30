class CallBack

account_sid = 'AC78ebd26aa18b190fd9b819b546b49654'
auth_token = '9d0981c62a42b8a7489ac68269dcf1d1'
 
# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

  def self.initiate_call(event, phone_num)
    @call = @client.account.calls.create(
    :from => '17786547065',   # From your Twilio number
    :to => '16048805822',     # phone_num
    # Fetch instructions from this URL when the call connects
    :url => 'http://localhost:3000') 
  end
end