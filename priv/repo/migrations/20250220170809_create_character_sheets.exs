defmodule DedSheet.Repo.Migrations.CreateCharacterSheets do
  use Ecto.Migration

  def change do
    create table(:character_sheets) do
      add :strength_modifier, :integer
      add :strength_score, :integer
      add :strength_saving_throw_proficient, :boolean, default: false, null: false
      add :strength_saving_throw, :integer
      add :athletics_proficient, :boolean, default: false, null: false
      add :athletics, :integer
      add :intelligence_modifier, :integer
      add :intelligence_score, :integer
      add :intelligence_saving_throw_proficient, :boolean, default: false, null: false
      add :intelligence_saving_throw, :integer
      add :arcana_proficient, :boolean, default: false, null: false
      add :arcana, :integer
      add :history_proficient, :boolean, default: false, null: false
      add :history, :integer
      add :investigation_proficient, :boolean, default: false, null: false
      add :investigation, :integer
      add :nature_proficient, :boolean, default: false, null: false
      add :nature, :integer
      add :religion_proficient, :boolean, default: false, null: false
      add :religion, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
