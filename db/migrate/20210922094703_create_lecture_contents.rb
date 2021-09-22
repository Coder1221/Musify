class CreateLectureContents < ActiveRecord::Migration[6.1]
  def change
    create_table :lecture_contents do |t|
      t.integer :lecture_id
      t.string :desciption
      t.string :content
      t.timestamps
    end
  end
end
