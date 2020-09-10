class UniappsController < ApplicationController
   

    get'/uniapps/new' do

        @applications = Uniapp.all
        @programs = School.all
      
        erb :'uniapps/new'
      end
      post '/uniapps' do
        #get entire program object

        @school = School.find_by(program_name: params[:uniapps][:program_name])
        # session[:user_id] = @student.id
      
        #create new application linking program with current user
        @application = Uniapp.create(student_id: current_user.id, school_id: @school.id)
        
        
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
          @school = School.all
          erb :'uniapps/edit'
        end
        
        
        patch "/uniapps/:id" do
          
          @application = Uniapp.find(params[:id])
          @school = School.all
       
          # binding.pry
          @application.update(params[:application])
          
          
        
          redirect "/uniapps/#{@application.id}"
        end
      
      get '/uniapps/:id' do
      
      
        #gets params from url
      
        @application = Uniapp.find(params[:id]) #define instance variable for view
      
        erb :'uniapps/show' #show single application view

      
      end

      #Delete uniapp
      delete '/uniapps/:id' do
     
        
        @uniapp = Uniapp.find(params[:id])
        # binding.pry
        if authorized_to_edit?(@uniapp) 
         
        @uniapp.destroy
        redirect '/'
        else
        erb :noaccess
        end
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

      def authorized_to_edit?(uniapp)
        @uniapp.student_id == current_user.id
      end
end
