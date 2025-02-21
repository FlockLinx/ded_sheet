defmodule DedSheet.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias DedSheet.Repo

  alias DedSheet.Game.CharacterSheet

  @doc """
  Returns the list of character_sheets.

  ## Examples

      iex> list_character_sheets()
      [%CharacterSheet{}, ...]

  """
  def list_character_sheets do
    Repo.all(CharacterSheet)
  end

  @doc """
  Gets a single character_sheet.

  Raises `Ecto.NoResultsError` if the Character sheet does not exist.

  ## Examples

      iex> get_character_sheet!(123)
      %CharacterSheet{}

      iex> get_character_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_character_sheet!(id), do: Repo.get!(CharacterSheet, id)

  @doc """
  Creates a character_sheet.

  ## Examples

      iex> create_character_sheet(%{field: value})
      {:ok, %CharacterSheet{}}

      iex> create_character_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_character_sheet(attrs \\ %{}) do
    %CharacterSheet{}
    |> CharacterSheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a character_sheet.

  ## Examples

      iex> update_character_sheet(character_sheet, %{field: new_value})
      {:ok, %CharacterSheet{}}

      iex> update_character_sheet(character_sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_character_sheet(%CharacterSheet{} = character_sheet, attrs) do
    character_sheet
    |> CharacterSheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a character_sheet.

  ## Examples

      iex> delete_character_sheet(character_sheet)
      {:ok, %CharacterSheet{}}

      iex> delete_character_sheet(character_sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_character_sheet(%CharacterSheet{} = character_sheet) do
    Repo.delete(character_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking character_sheet changes.

  ## Examples

      iex> change_character_sheet(character_sheet)
      %Ecto.Changeset{data: %CharacterSheet{}}

  """
  def change_character_sheet(%CharacterSheet{} = character_sheet, attrs \\ %{}) do
    CharacterSheet.changeset(character_sheet, attrs)
  end
end
