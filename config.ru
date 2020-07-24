require './config/environment'
require 'sinatra'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/school_controller'
require_relative 'app/controllers/session_controller'
require_relative 'app/controllers/student_controller'
require_relative 'app/controllers/uniapp_controller'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
run ApplicationController
use SessionsController
use StudentsController
use SchoolsController
use UniappsController