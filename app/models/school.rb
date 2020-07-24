class School < ActiveRecord::Base
has_many :uniapps
has_many :students, through: :uniapps
end
