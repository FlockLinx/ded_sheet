defmodule DedSheet.Repo.Migrations.CreateCharacterSheets do
  use Ecto.Migration

  def change do
    create table(:character_sheets) do
      add :strength_modifier, :integer, default: 0
      add :player_level, :integer, default: 1

      add :strength_score, :integer, default: 0
      add :strength_saving_throw_proficient, :boolean, default: false
      add :strength_saving_throw, :integer, default: 0
      add :athletics_proficient, :boolean, default: false
      add :athletics, :integer, default: 0
      add :intelligence_modifier, :integer, default: 0
      add :intelligence_score, :integer, default: 0
      add :intelligence_saving_throw_proficient, :boolean, default: false
      add :intelligence_saving_throw, :integer, default: 0
      add :arcana_proficient, :boolean, default: false
      add :arcana, :integer, default: 0
      add :history_proficient, :boolean, default: false
      add :history, :integer, default: 0
      add :investigation_proficient, :boolean, default: false
      add :investigation, :integer, default: 0
      add :nature_proficient, :boolean, default: false
      add :nature, :integer, default: 0
      add :religion_proficient, :boolean, default: false
      add :religion, :integer, default: 0

      timestamps(type: :utc_datetime)
    end
  end
end
