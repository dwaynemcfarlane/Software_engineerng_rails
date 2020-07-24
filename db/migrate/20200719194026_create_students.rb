class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password_digest
      t.integer :sat_score
      t.integer :age

      t.timestamps null: false
    end
  end
end
