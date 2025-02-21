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
      :heroic_inspiration
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
      :passive_perception
    ])
  end
end
