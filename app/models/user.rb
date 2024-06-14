# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = { basic: 0, admin: 1 }.freeze
  enum :role, ROLES

  def self.presentable_roles
    ROLES.map { |role, num| [role, num] }
  end

  def selected_role
    [role, ROLES[role.to_sym]]
  end

  def admin?
    role == 'admin'
  end

  def basic?
    role == 'basic'
  end
end
