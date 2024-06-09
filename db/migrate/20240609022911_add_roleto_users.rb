# frozen_string_literal: true

class AddRoletoUsers < ActiveRecord::Migration[7.0]
  TABLE = :users
  COLUMN = :role
  TYPE = :integer

  def up
    add_column(TABLE, COLUMN, TYPE, if_not_exists: true)
  end

  def down
    remove_column(TABLE, COLUMN, if_exists: true)
  end
end
