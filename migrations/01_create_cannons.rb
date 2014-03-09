Sequel.migration do
  change do
    create_table(:cannons) do
      primary_key :id
      Integer :weight, null: false
      Integer :length, null: false
      Integer :bore, null: false
      DateTime :last_fired_at
    end
  end
end