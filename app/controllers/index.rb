get '/' do
  if logged_in?
    redirect "/users/dashboard"
  else
    erb :index
  end
end
