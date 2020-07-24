
    class SessionsController < ApplicationController
        helpers do
            def logged_in?
              !!current_user
            end
            def current_user
              Student.find_by(id: session[:user_id])
            end
          end
        
          get "/" do
            if logged_in?
                redirect "/students/#{current_user.id}"
            else
            erb :welcome
            end
          end

        # This sessions controller displays all information pertaining to user creation, passwords and sessions
        post '/login' do
         #switch line
            @student = Student.find_by(:email => params[:email])
    
         if params[:email] !=" " && params[:password] !=" "
             if params[:email] !="email" && params[:password] !="password"
                # @student.authenticate(params[:password])
                if !@student || !@student.authenticate(params[:password])
                    redirect '/'
                elsif 
                    @student && @student.authenticate(params[:password])
                    session[:user_id] = @student.id
                    redirect "/students/#{@student.id}"
                 end
             else
                redirect '/'
             end
            
         else 
            redirect '/'
         
         end
        end
    
        get '/signup' do
            erb :'students/new'
        end
    
        # old students sign up route
        # get '/students/new' do
        #     erb :signup
        # end
        
        
    #    #fallthrough to show sign up form again
    #         get '/students/' do
    #             erb :signup
    #         end
    
           
    end
    

