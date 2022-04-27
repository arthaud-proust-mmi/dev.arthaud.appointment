class Meet < ApplicationRecord
    belongs_to :user
    belongs_to :service

    validates :planned_at, presence: { message: 'La date est obligatoire' }

    STATES = {
        'confirmed': 0,
        'canceled': 1,
    }

    scope :old, -> { where("planned_at < ?", Date.today ) }
    scope :to_come, -> { where("planned_at >= ?", Date.today ) }
    scope :incoming, -> { to_come.take(3) }

    scope :confirmed, -> { where(state: STATES[:confirmed] ) }
    scope :canceled, -> { where(state: STATES[:canceled] ) }


    def is_old
        planned_at < Date.today 
    end

    def is_to_come
        planned_at >= Date.today 
    end
    

    def planned_at_timestamp
        planned_at.to_time.to_i
    end

    def is_confirmed
        state == STATES[:confirmed]
    end

    def is_canceled
        state == STATES[:canceled]
    end
end
