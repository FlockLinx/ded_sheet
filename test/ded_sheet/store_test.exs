defmodule DedSheet.StoreTest do
  use DedSheet.DataCase

  alias DedSheet.Store

  describe "products" do
    alias DedSheet.Store.Products

    import DedSheet.StoreFixtures

    @invalid_attrs %{
      name: nil,
      price: nil,
      tax: nil,
      class: nil,
      prof_bonus: nil,
      strength: nil,
      strength_saving: nil,
      strength_saving_number: nil,
      athletics: nil
    }

    test "list_products/0 returns all products" do
      products = products_fixture()
      assert Store.list_products() == [products]
    end

    test "get_products!/1 returns the products with given id" do
      products = products_fixture()
      assert Store.get_products!(products.id) == products
    end

    test "create_products/1 with valid data creates a products" do
      valid_attrs = %{
        name: "some name",
        price: 42,
        tax: 42,
        class: 42,
        prof_bonus: 42,
        strength: 42,
        strength_saving: true,
        strength_saving_number: 42,
        athletics: 42
      }

      assert {:ok, %Products{} = products} = Store.create_products(valid_attrs)
      assert products.name == "some name"
      assert products.price == 42
      assert products.tax == 42
      assert products.class == 42
      assert products.prof_bonus == 42
      assert products.strength == 42
      assert products.strength_saving == true
      assert products.strength_saving_number == 42
      assert products.athletics == 42
    end

    test "create_products/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_products(@invalid_attrs)
    end

    test "update_products/2 with valid data updates the products" do
      products = products_fixture()

      update_attrs = %{
        name: "some updated name",
        price: 43,
        tax: 43,
        class: 43,
        prof_bonus: 43,
        strength: 43,
        strength_saving: false,
        strength_saving_number: 43,
        athletics: 43
      }

      assert {:ok, %Products{} = products} = Store.update_products(products, update_attrs)
      assert products.name == "some updated name"
      assert products.price == 43
      assert products.tax == 43
      assert products.class == 43
      assert products.prof_bonus == 43
      assert products.strength == 43
      assert products.strength_saving == false
      assert products.strength_saving_number == 43
      assert products.athletics == 43
    end

    test "update_products/2 with invalid data returns error changeset" do
      products = products_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_products(products, @invalid_attrs)
      assert products == Store.get_products!(products.id)
    end

    test "delete_products/1 deletes the products" do
      products = products_fixture()
      assert {:ok, %Products{}} = Store.delete_products(products)
      assert_raise Ecto.NoResultsError, fn -> Store.get_products!(products.id) end
    end

    test "change_products/1 returns a products changeset" do
      products = products_fixture()
      assert %Ecto.Changeset{} = Store.change_products(products)
    end
  end

  describe "products" do
    alias DedSheet.Store.Product

    import DedSheet.StoreFixtures

    @invalid_attrs %{
      name: nil,
      price: nil,
      tax: nil,
      class: nil,
      prof_bonus: nil,
      strength: nil,
      strength_saving: nil,
      strength_saving_number: nil,
      athletics: nil
    }

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Store.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Store.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{
        name: "some name",
        price: 42,
        tax: 42,
        class: 42,
        prof_bonus: 42,
        strength: 42,
        strength_saving: true,
        strength_saving_number: 42,
        athletics: 42
      }

      assert {:ok, %Product{} = product} = Store.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.price == 42
      assert product.tax == 42
      assert product.class == 42
      assert product.prof_bonus == 42
      assert product.strength == 42
      assert product.strength_saving == true
      assert product.strength_saving_number == 42
      assert product.athletics == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()

      update_attrs = %{
        name: "some updated name",
        price: 43,
        tax: 43,
        class: 43,
        prof_bonus: 43,
        strength: 43,
        strength_saving: false,
        strength_saving_number: 43,
        athletics: 43
      }

      assert {:ok, %Product{} = product} = Store.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.price == 43
      assert product.tax == 43
      assert product.class == 43
      assert product.prof_bonus == 43
      assert product.strength == 43
      assert product.strength_saving == false
      assert product.strength_saving_number == 43
      assert product.athletics == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_product(product, @invalid_attrs)
      assert product == Store.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Store.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Store.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Store.change_product(product)
    end
  end
end
