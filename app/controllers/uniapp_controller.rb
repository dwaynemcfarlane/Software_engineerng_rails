class UniappsController < ApplicationController
   

    get'/uniapps/new' do

        @applications = Uniapp.all
        @programs = School.all
      
        erb :'uniapps/new'
      
      end
      post '/uniapps' do
        #get entire program object
        @program = School.find_by(program_name: params[:uniapps][:program_name])
        # session[:user_id] = @student.id
      
        #create new application linking program with current user
        @application = Uniapp.create(student_id: current_user.id, school_id: @program.id)
        
        
        redirect "/students/#{current_user.id}"
        
      end
      get '/uniapps' do
      
        @applications = Uniapp.all #define instance variable for view
      
        @student = Student.all
      
        erb :'uniapps/index' #show all applications view (index)
      
      end
      
      #edit the application
      get '/uniapps/:id/edit' do
        
          @application = Uniapp.find(params[:id])
          erb :'students/show'
        end
        
        
        patch "/uniapps/:id" do
          
          @application = Uniapp.find(params[:id])
          
          @application.update(params[:application])
        
          redirect "/uniapps/#{@application.id}"
        end
      
      get '/uniapps/:id' do
      
      
        #gets params from url
      
        @application = Uniapp.find(params[:id]) #define instance variable for view
      
        erb :'uniapps/show' #show single application view
      
      end
      #helper
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
end
