class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    has_many :services
    has_many :meets
    has_many :pro_meets, through: :services, source: :meets

    require 'uri'

    def adress_to_maps
        uri = URI.parse('https://www.google.com/maps/search/')
        uri.query = URI.encode_www_form(
            'api' => 1,
            'query' => adress
        )
        uri.to_s
    end
end