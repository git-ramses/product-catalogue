# frozen_string_literal: true

# policy to interact with users
class UserPolicy < ApplicationPolicy
  def show?
    user.id == record.id
  end

  def edit?
    user.id == record.id
  end

  def update?
    user.admin? || (user.id == record.id)
  end
end
