defmodule DedSheet.Repo.Migrations.AddNewCharacterSheetFields do
  use Ecto.Migration

  def change do
    alter table(:character_sheets) do
      add :proficiency_bonus, :integer, default: 2
      add :initiative, :integer, default: 0
      add :size, :string, default: "Medium"
      add :passive_perception, :integer, default: 10
      add :heroic_inspiration, :boolean, default: false
    end
  end
end
