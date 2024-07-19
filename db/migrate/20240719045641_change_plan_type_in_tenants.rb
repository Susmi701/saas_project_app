class ChangePlanTypeInTenants < ActiveRecord::Migration[7.1]
  def up
    change_column :tenants, :plan, :string
  end

  def down
    change_column :tenants, :plan, :integer
  end
end
