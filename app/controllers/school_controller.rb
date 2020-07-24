class SchoolsController < ApplicationController
    get '/schools' do
    @schools = School.all
    erb :'schools/index'

    end

    get '/schools/:id' do
        @school = School.find(params[:id])
        erb :'schools/show'
      end
end
