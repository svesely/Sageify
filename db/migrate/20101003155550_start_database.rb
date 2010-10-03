class StartDatabase < ActiveRecord::Migration
  def self.up

    create_table "answers", :force => true do |t|
      t.integer  "question_id"
      t.integer  "assessment_id"
      t.string   "value"
      t.boolean  "correct"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "assessments", :force => true do |t|
      t.integer  "exam_id"
      t.integer  "learner_id"
      t.integer  "organization_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "assignments", :force => true do |t|
      t.integer  "user_id"
      t.integer  "lesson_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "choices", :force => true do |t|
      t.integer  "question_id"
      t.string   "text"
      t.string   "letter"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "completions", :force => true do |t|
      t.integer  "user_id"
      t.integer  "lesson_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "exams", :force => true do |t|
      t.string   "name"
      t.integer  "author_id"
      t.integer  "organization_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.float    "pass_requirement"
    end

    create_table "exams_lessons", :id => false, :force => true do |t|
      t.integer  "exam_id"
      t.integer  "lesson_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "lessons", :force => true do |t|
      t.string   "name"
      t.integer  "author_id"
      t.integer  "organization_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "public",          :default => false, :null => false
      t.integer  "lessonable_id"
      t.string   "lessonable_type"
      t.integer  "position"
      t.text     "description"
    end

    create_table "organizations", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "pages", :force => true do |t|
      t.string   "title"
      t.text     "content"
      t.integer  "author_id"
      t.integer  "lesson_id"
      t.integer  "position"
      t.integer  "organization_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "questions", :force => true do |t|
      t.string   "text"
      t.string   "questionable_type"
      t.integer  "questionable_id"
      t.integer  "position"
      t.boolean  "active"
      t.integer  "correct_choice_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "roles", :force => true do |t|
      t.string   "name",              :limit => 40
      t.string   "authorizable_type", :limit => 40
      t.integer  "authorizable_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "roles_users", :id => false, :force => true do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "sessions", :force => true do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "subscriptions", :force => true do |t|
      t.integer  "organization_id"
      t.integer  "transaction_id"
      t.date     "expiration_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string "first_name"
      t.string "last_name"
      t.integer "organization_id"
      t.database_authenticatable
      t.rememberable
      t.trackable
      t.timestamps
    end

  end

  def self.down
  end
end
