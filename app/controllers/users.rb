get '/users/new' do
  @user = User.new
  erb :'sessions/sign_up'
end

post '/users/create' do
  @user = User.create(params[:user])
  if @user.valid?
    session[:user_id] = @user.id
    redirect "/users/dashboard"
  else
    erb :'sessions/sign_up'
  end
end

get '/user/:id/delete' do
  User.delete(params[:id])
  redirect "/"
end

get '/users/dashboard' do
  @user = User.find(session[:user_id])
  @users = User.all
  erb :'users/dashboard'
end