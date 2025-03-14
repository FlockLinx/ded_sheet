defmodule DedSheet.Repo.Migrations.AddWisdom do
  use Ecto.Migration

  def change do
    alter table(:character_sheets) do
      add :wisdom_modifier, :integer, default: 0
      add :wisdom_score, :integer, default: 0
      add :wisdom_saving_throw_proficient, :boolean, default: false
      add :wisdom_saving_throw, :integer, default: 0
      add :animal_handling, :integer, default: 0
      add :animal_handling_proficient, :boolean, default: false
      add :insight, :integer, default: 0
      add :insight_proficient, :boolean, default: false
      add :medicine, :integer, default: 0
      add :medicine_proficient, :boolean, default: false
      add :perception, :integer, default: 0
      add :perception_proficient, :boolean, default: false
      add :survival, :integer, default: 0
      add :survival_proficient, :boolean, default: false
    end
  end
end
