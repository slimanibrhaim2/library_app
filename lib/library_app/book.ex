defmodule LibraryApp.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :author, :string
    field :year, :integer
    field :available, :boolean, default: true

    timestamps()
  end

  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :year, :available])
    |> validate_required([:title, :author])
    |> validate_length(:title, min: 1, max: 200)
    |> validate_length(:author, min: 1, max: 100)
    |> validate_number(:year, greater_than: 1000, less_than: 2030)
  end

  def availability_changeset(book, attrs) do
    book
    |> cast(attrs, [:available])
    |> validate_required([:available])
  end
end
