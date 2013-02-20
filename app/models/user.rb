#encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :categories
  
  after_create :record_category
  
  class << self
    def current_user=(user)
	Thread.current[:current_user] = user
    end

    def current_user
	Thread.current[:current_user]
    end
  end
  
  HUMAN_ATTRIBUTE_NAMES = {
    :name => 'Имя',
    :email => 'Электронный адрес',
    :password => 'Пароль',
    :password_confirmation => "Подтверждение пароля",
    :remember_me => "Запомнить меня"
  }
  class << self
    def human_attribute_name attribute_name
	HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
    end
  end
  
  def record_category
    log =  Rails.logger
    log.debug("record_category")
    copy_category(Basecategory.roots, nil)
  end
  
  def copy_category(child_ids, parent_id)
      child_ids.each do |child_id|
        src = Basecategory.find_by_uuid(child_id)
        dst = Category.unscoped.new(src.attributes.symbolize_keys.except(:created_at, :created_by, :updated_at, :updated_by, :id, :uuid))
        dst.parent = parent_id
        dst.user_id = self.id
        dst.save!
        copy_category(src.child_ids, dst)
      end
  end
  
end
