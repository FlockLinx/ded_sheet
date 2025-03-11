defmodule DedSheet.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DedSheet.Store` context.
  """

  @doc """
  Generate a products.
  """
  def products_fixture(attrs \\ %{}) do
    {:ok, products} =
      attrs
      |> Enum.into(%{
        athletics: 42,
        class: 42,
        name: "some name",
        price: 42,
        prof_bonus: 42,
        strength: 42,
        strength_saving: true,
        strength_saving_number: 42,
        tax: 42
      })
      |> DedSheet.Store.create_products()

    products
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        athletics: 42,
        class: 42,
        name: "some name",
        price: 42,
        prof_bonus: 42,
        strength: 42,
        strength_saving: true,
        strength_saving_number: 42,
        tax: 42
      })
      |> DedSheet.Store.create_product()

    product
  end
end
