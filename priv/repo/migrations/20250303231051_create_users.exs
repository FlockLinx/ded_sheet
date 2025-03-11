defmodule DedSheet.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      add :description, :text
      add :favcolor, :string
      add :second_age, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
