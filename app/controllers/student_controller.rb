class StudentsController < ApplicationController
   


    get '/students' do
        @students = Student.all
        erb :'students/index'
      end
      get '/students/' do
        @students = Student.all
        erb :'students/index'
      end

    #  New Student form and  create a new student
    get '/students/new' do
        erb :'students/new'
    end

    # Creating a new student form post method
    post '/students' do
    
        if params[:first_name] !=" " && params[:email] !=" " && params[:password] !=" "
           @student = Student.create(params[:students])
               session[:user_id] = @student.id
               redirect "/students/#{@student.id}"
          else
            redirect '/students/new'
        end
    end
      get '/students/:id' do
        @student = Student.find(params[:id])
        #finding the applications submitted by the current user.
        
        
        
        
        erb :'students/show'
      end
      
       get '/students/:id/edit' do
      
        @student = Student.find(params[:id])
        erb :'students/edit'
      end
      
       patch "/students/:id" do
        @student = Student.find(params[:id])
        if authorized_to_edit?(@student) 
        @student.update(params[:students])
      
        redirect "/students/#{@student.id}"
        else 
          redirect '/'
        end
      end
      
      delete '/students/:id' do
        @student = Student.find(params[:id])
        if authorized_to_edit?(@student) 
        @student.destroy
        redirect '/'
        else
        redirect '/'
        end
      end 

      get '/logout' do
        session.clear
        redirect '/'
    end
     #helpers
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

      def authorized_to_edit?(student)
        @student == current_user
      end
end
