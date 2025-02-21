defmodule DedSheet.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DedSheet.Game` context.
  """

  @doc """
  Generate a character_sheet.
  """
  def character_sheet_fixture(attrs \\ %{}) do
    {:ok, character_sheet} =
      attrs
      |> Enum.into(%{
        arcana: 42,
        arcana_proficient: true,
        athletics: 42,
        athletics_proficient: true,
        history: 42,
        history_proficient: true,
        intelligence_modifier: 42,
        intelligence_saving_throw: 42,
        intelligence_saving_throw_proficient: true,
        intelligence_score: 42,
        investigation: 42,
        investigation_proficient: true,
        nature: 42,
        nature_proficient: true,
        religion: 42,
        religion_proficient: true,
        strength_modifier: 42,
        strength_saving_throw: 42,
        strength_saving_throw_proficient: true,
        strength_score: 42
      })
      |> DedSheet.Game.create_character_sheet()

    character_sheet
  end
end
