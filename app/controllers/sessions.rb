get '/sessions/new' do
  erb :'sessions/sign_in'
end

post '/sessions' do
  @user = User.authenticate(params[:email],params[:password])
  if @user
    session[:user_id] = @user.id
    redirect "/"
  else
    erb :'sessions/sign_in'
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
end