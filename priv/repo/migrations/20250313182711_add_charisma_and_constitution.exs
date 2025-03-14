defmodule DedSheet.Repo.Migrations.AddCharismaAndConstitution do
  use Ecto.Migration

  def change do
    alter table(:character_sheets) do
      add :charisma_modifier, :integer, default: 0
      add :charisma_score, :integer, default: 0
      add :charisma_saving_throw_proficient, :boolean, default: false
      add :charisma_saving_throw, :integer, default: 0
      add :constitution_modifier, :integer, default: 0
      add :constitution_score, :integer, default: 0
      add :constitution_saving_throw_proficient, :boolean, default: false
      add :constitution_saving_throw, :integer, default: 0
      add :deception_handling, :integer, default: 0
      add :deception_handling_proficient, :boolean, default: false
      add :intimidation, :integer, default: 0
      add :intimidation_proficient, :boolean, default: false
      add :performance, :integer, default: 0
      add :performance_proficient, :boolean, default: false
      add :persuasion, :integer, default: 0
      add :persuasion_proficient, :boolean, default: false
    end
  end
end
