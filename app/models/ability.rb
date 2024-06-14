# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :update, User, id: user.id

    return unless user.admin?

    can :update, User
  end
end
