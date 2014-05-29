# Homepage (Root path)
get '/' do
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

post '/events' do
  url= ('a'..'z').to_a.shuffle[0,9].join
  @event = Event.new(
    name: params[:name],
    start_time: params[:start_date],
    end_time: params[:end_date],
    details: params[:details],
    message_length: params[:message_length],
    user_id: session[:id],
    url: url)

    if @event.valid?
      @event.save
      session[:message] = "Event Saved!"
      redirect :"/users/#{session[:id]}"
    else
      #session[:message] = @event.errors.full_messages
      redirect :'/events/new'
    end

 
end

get '/events/:id' do
  @event = Event.find(params[:id])

  erb :'events/show'
end
























