helpers do 
  def current_user
    @current_user = User.where(id: session[:id]).first
  end
end
# Homepage (Root path)
get '/' do
  if session[:id] then redirect "/users/#{session[:id]}" end
  erb :index
end

get '/users/new' do

  erb :'/users/new'
end

post '/users' do
  @user = User.new(
    firstname: params[:firstname],
    lastname: params[:lastname],
    email: params[:email],
    phone: params[:phone],
    password: params[:password]
    )
  if @user.save
    session[:id] = @user.id
    redirect "/users/#{session[:id]}"
  else
    erb :'users/new'
  end
end

get '/users/:id' do 
  @user = User.find(session[:id])
  @events = Event.where("user_id = ?", session[:id]).reverse
  # session[:current_event] = nil
  erb :'users/show'
end

get '/login' do
  erb :'login'
end

post '/login' do
  @user = User.where(email: params[:email]).first
  if @user
    if @user.password == params[:password]
      session[:id] = @user.id
      session[:message] = nil
      redirect :"/users/#{session[:id]}"
    else
      session[:message] = "Invalid password"
      erb :'login'
    end
  else
    session[:message] = "Invalid user name"
    erb :'login'
  end
end

get '/logout' do
  session[:id] = nil
  session[:message] = nil
  redirect '/'
end

get '/events/new' do
  erb :'events/new'
end

get '/events/edit/:url' do
  @event = Event.where('url = ?', "#{params[:url]}").first
  erb :'events/edit'
end

post '/events/update' do
  #url= ('a'..'z').to_a.shuffle[0,9].join # this should be moved into the model as an AactiveRecord validationsuch as: before_validation : generate_token, on :create 
  @event = Event.where('url = ?', "#{params[:url]}").first
                       # and the generate_token method should a private
    @event.name= params[:name]
    @event.details= params[:details]
    @event.status= params[:status]
    @event.date= params[:date]
    @event.message_length= params[:message_length]
    @event.limit_messages= params[:limit_messages]
    @event.user_id= session[:id]

  if @event.valid?
    @event.save
    session[:message] = "Changes Saved!"
    redirect :"/users/#{session[:id]}"
  else
    #session[:message] = @event.errors.full_messages
    redirect :'/events/edit'
  end
end


post '/events' do
  #url= ('a'..'z').to_a.shuffle[0,9].join # this should be moved into the model as an AactiveRecord validationsuch as: before_validation : generate_token, on :create 
  @event = Event.new(                     # and the generate_token method should a private
    name: params[:name],
    details: params[:details],
    status: params[:status],
    date: params[:date],
    message_length: params[:message_length],
    limit_messages: params[:limit_messages],
    user_id: session[:id])

  if @event.valid?
    @event.save
    session[:message] = "Event Saved!"
    redirect :"/users/#{session[:id]}"
  else
    #session[:message] = @event.errors.full_messages
    redirect :'/events/new'
  end
end

get '/events/call/:url' do
  @event = Event.where('url = ?', params[:url]).first
  session[:message] = nil
  erb :'events/call'
end

post '/events/call' do
  @event = Event.where('url = ?', params[:url]).first
  CallBack.initiate_call(@event, params[:phone])
  erb :"/events/thankyou"
end

post '/events/record/:url' do
  @event = Event.where('url = ?', "#{params[:url]}").first
  content_type 'text/xml'
  @xml_response = CallBack.record_instructions(@event)
  erb :'events/record.xml', layout: false
end

post '/events/recording/:eventid' do 
  @message = Message.create(
              event_id: params[:eventid],
              recording_url: params[:RecordingUrl],
              from_phone: params[:To],
              call_sid: params[:CallSid],
              recording_sid: params[:RecordingSid])
end

get '/events/:url' do
  @event = Event.where('url = ?', "#{params[:url]}").first
  @messages = Message.where('event_id = ?', @event.id )
  session[:message] = nil
  erb :'events/show'
end



