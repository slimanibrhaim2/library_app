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

  # get available books
  def list_available_books do
    Book
    |> where([b], b.available == true)
    |> Repo.all()
  end

  # get by auther
  def get_books_by_author(author) do
    Book
    |>where([b], ilike(b.author, ^"%#{author}%"))
    |> Repo.all()
  end

  # general search for book
  def search_books(search_term) do
    search_pattern = "%#{search_term}%"
    Book
    |> where([b], ilike(b.title, ^search_pattern) or ilike(b.author, ^search_pattern))
    |> Repo.all()
  end

  # get books by year
  def get_books_by_year(year) do
    Book
    |> where([b], b.year == ^year)
    |> Repo.all()
  end

  # get status about books how many available and how mane books exists
  def get_books_status do
    total_books = Repo.aggregate(Book, :count, :id)
    available_book =
      Book
      |> where([b], b.available == true)
      |> Repo.aggregate(:count, :id)
    %{total: total_books, available: available_book}
  end

end
