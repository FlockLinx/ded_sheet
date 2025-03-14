defmodule DedSheet.Repo.Migrations.AddDexterity do
  use Ecto.Migration

  def change do
    alter table(:character_sheets) do
      add :dexterity_modifier, :integer, default: 0
      add :dexterity_score, :integer, default: 0
      add :dexterity_saving_throw_proficient, :boolean, default: false
      add :dexterity_saving_throw, :integer, default: 0
      add :acrobatics_proficient, :boolean, default: false
      add :acrobatics, :integer, default: 0
      add :sleight_of_hands_proficient, :boolean, default: false
      add :sleight_of_hands, :integer, default: 0
      add :stealth_proficient, :boolean, default: false
      add :stealth, :integer, default: 0
    end
  end
end
