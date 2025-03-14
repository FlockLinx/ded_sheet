defmodule DedSheet.Game.CharacterSheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "character_sheets" do
    field :history, :integer
    field :strength_modifier, :integer
    field :strength_score, :integer
    field :strength_saving_throw_proficient, :boolean, default: false
    field :strength_saving_throw, :integer
    field :athletics_proficient, :boolean, default: false
    field :athletics, :integer
    field :intelligence_modifier, :integer
    field :intelligence_score, :integer
    field :intelligence_saving_throw_proficient, :boolean, default: false
    field :intelligence_saving_throw, :integer
    field :arcana_proficient, :boolean, default: false
    field :arcana, :integer
    field :history_proficient, :boolean, default: false
    field :investigation_proficient, :boolean, default: false
    field :investigation, :integer
    field :nature_proficient, :boolean, default: false
    field :nature, :integer
    field :religion_proficient, :boolean, default: false
    field :religion, :integer
    field :player_level, :integer, default: 1
    field :proficiency_bonus, :integer, default: 2
    field :initiative, :integer, default: 0
    field :size, :string, default: "Medium"
    field :passive_perception, :integer, default: 10
    field :heroic_inspiration, :boolean, default: false
    field :dexterity_modifier, :integer
    field :dexterity_score, :integer
    field :dexterity_saving_throw_proficient, :boolean, default: false
    field :dexterity_saving_throw, :integer, default: 0
    field :acrobatics_proficient, :boolean, default: false
    field :acrobatics, :integer, default: 0
    field :sleight_of_hands_proficient, :boolean, default: false
    field :sleight_of_hands, :integer, default: 0
    field :stealth_proficient, :boolean, default: false
    field :stealth, :integer, default: 0
    field :wisdom_modifier, :integer
    field :wisdom_score, :integer
    field :wisdom_saving_throw_proficient, :boolean, default: false
    field :wisdom_saving_throw, :integer, default: 0
    field :animal_handling, :integer, default: 0
    field :animal_handling_proficient, :boolean, default: false
    field :insight, :integer, default: 0
    field :insight_proficient, :boolean, default: false
    field :medicine, :integer, default: 0
    field :medicine_proficient, :boolean, default: false
    field :perception, :integer, default: 0
    field :perception_proficient, :boolean, default: false
    field :survival, :integer, default: 0
    field :survival_proficient, :boolean, default: false
    field :charisma_modifier, :integer
    field :charisma_score, :integer
    field :charisma_saving_throw_proficient, :boolean, default: false
    field :charisma_saving_throw, :integer, default: 0
    field :constitution_modifier, :integer
    field :constitution_score, :integer
    field :constitution_saving_throw_proficient, :boolean, default: false
    field :constitution_saving_throw, :integer, default: 0
    field :deception_handling, :integer, default: 0
    field :deception_handling_proficient, :boolean, default: false
    field :intimidation, :integer, default: 0
    field :intimidation_proficient, :boolean, default: false
    field :performance, :integer, default: 0
    field :performance_proficient, :boolean, default: false
    field :persuasion, :integer, default: 0
    field :persuasion_proficient, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(character_sheet, attrs) do
    character_sheet
    |> cast(attrs, [
      :strength_modifier,
      :strength_score,
      :strength_saving_throw_proficient,
      :strength_saving_throw,
      :athletics_proficient,
      :athletics,
      :intelligence_modifier,
      :intelligence_score,
      :intelligence_saving_throw_proficient,
      :intelligence_saving_throw,
      :arcana_proficient,
      :arcana,
      :history_proficient,
      :history,
      :investigation_proficient,
      :investigation,
      :nature_proficient,
      :nature,
      :religion_proficient,
      :religion,
      :player_level,
      :proficiency_bonus,
      :initiative,
      :size,
      :passive_perception,
      :heroic_inspiration,
      :dexterity_modifier,
      :dexterity_score,
      :dexterity_saving_throw_proficient,
      :dexterity_saving_throw,
      :acrobatics_proficient,
      :acrobatics,
      :sleight_of_hands_proficient,
      :sleight_of_hands,
      :stealth_proficient,
      :stealth,
      :wisdom_modifier,
      :wisdom_score,
      :wisdom_saving_throw_proficient,
      :wisdom_saving_throw,
      :animal_handling,
      :animal_handling_proficient,
      :insight,
      :insight_proficient,
      :medicine,
      :medicine_proficient,
      :perception,
      :perception_proficient,
      :survival,
      :survival_proficient,
      :wisdom_score,
      :wisdom_saving_throw_proficient,
      :wisdom_saving_throw,
      :animal_handling,
      :animal_handling_proficient,
      :insight,
      :insight_proficient,
      :medicine,
      :medicine_proficient,
      :perception,
      :perception_proficient,
      :survival,
      :survival_proficient,
      :charisma_modifier,
      :charisma_score,
      :charisma_saving_throw_proficient,
      :charisma_saving_throw,
      :constitution_modifier,
      :constitution_score,
      :constitution_saving_throw_proficient,
      :constitution_saving_throw,
      :deception_handling,
      :deception_handling_proficient,
      :intimidation,
      :intimidation_proficient,
      :performance,
      :performance_proficient,
      :persuasion,
      :persuasion_proficient
    ])
    |> validate_required([
      :strength_modifier,
      :strength_score,
      :strength_saving_throw_proficient,
      :strength_saving_throw,
      :athletics_proficient,
      :athletics,
      :intelligence_modifier,
      :intelligence_score,
      :intelligence_saving_throw_proficient,
      :intelligence_saving_throw,
      :arcana_proficient,
      :arcana,
      :history_proficient,
      :history,
      :investigation_proficient,
      :investigation,
      :nature_proficient,
      :nature,
      :religion_proficient,
      :religion,
      :player_level,
      :proficiency_bonus,
      :size,
      :passive_perception,
      :dexterity_modifier,
      :dexterity_score,
      :dexterity_saving_throw_proficient,
      :dexterity_saving_throw,
      :acrobatics_proficient,
      :acrobatics,
      :sleight_of_hands_proficient,
      :sleight_of_hands,
      :stealth_proficient,
      :stealth,
      :wisdom_modifier,
      :wisdom_score,
      :wisdom_saving_throw_proficient,
      :wisdom_saving_throw,
      :animal_handling,
      :animal_handling_proficient,
      :insight,
      :insight_proficient,
      :medicine,
      :medicine_proficient,
      :perception,
      :perception_proficient,
      :survival,
      :survival_proficient,
      :charisma_modifier,
      :charisma_score,
      :charisma_saving_throw_proficient,
      :charisma_saving_throw,
      :constitution_modifier,
      :constitution_score,
      :constitution_saving_throw_proficient,
      :constitution_saving_throw,
      :deception_handling,
      :deception_handling_proficient,
      :intimidation,
      :intimidation_proficient,
      :performance,
      :performance_proficient,
      :persuasion,
      :persuasion_proficient
    ])
  end
end
