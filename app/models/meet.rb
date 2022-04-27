class Meet < ApplicationRecord
    # include ActiveModel::API
    belongs_to :user
    belongs_to :service

    validates :planned_at, presence: { message: 'La date est obligatoire' }

    # scope :will_full_name, -> { select('`*`, CONCAT_WS(' ', `first_name`, `last_name`)')}
    #     attribute :full_name, :string, default: nil
    # end

    scope :old, -> { where("planned_at < ?", Date.today ) }
    scope :to_come, -> { where("planned_at >= ?", Date.today ) }
    scope :incoming, -> { to_come.take(3) }

    def planned_at_timestamp
        planned_at.to_time.to_i
    end
end
