defmodule LibraryApp.Books do
  import Ecto.Query, warn: false
  alias LibraryApp.Repo
  alias LibraryApp.Book

  # list all books
  def list_books do
    Repo.all(Book)
  end

  # get book by id
  def get_book!(id) do
    Repo.get!(Book, id)
  end

  def get_book(id) do
    Repo.get(Book, id)
  end


  # create book
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  # updata book
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  # delete book
  def delete_book(id) do
    case get_book!(id) do
      nil -> {:error, :not_found}
      book -> Repo.delete(book)
    end
  end

  # usefull later if we want to add soem logic
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end



end
