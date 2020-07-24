class Student < ActiveRecord::Base
has_many :uniapps
has_many :schools, through: :uniapps
has_secure_password
include ActiveModel::Validations
validates :first_name, presence: true
validates :last_name, presence: true

validates :email,    :presence => true,
                     :uniqueness => true
validates :username,    :presence => true,
                     :uniqueness => true
                     

end
