defmodule DedSheet.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :description, :string
    field :age, :integer
    field :favcolor, :string
    field :second_age, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age, :description, :favcolor, :second_age])
    |> validate_required([:name, :age, :description, :favcolor, :second_age])
  end
end
