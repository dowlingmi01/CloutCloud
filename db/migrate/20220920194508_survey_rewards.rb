class SurveyRewards < ActiveRecord::Migration[7.0]
    def change
      create_table :survey_rewards do |t|
      t.belongs_to :survey
      t.belongs_to :user
      t.decimal :rewards_cashes
      t.integer :experiences
      t.datetime :rewarded_at

      t.timestamps
    end
  end
end