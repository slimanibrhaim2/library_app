# 📚 Book Library Manager

A simple Book Library Management system built with **Elixir** and **Ecto** for learning purposes.

## 🎯 Project Overview

This project demonstrates core Ecto concepts:
- **Schemas** - Data structure definition
- **Repo** - Database interface
- **Changesets** - Data validation and transformation
- **Queries** - Database operations and searches

## 📋 Features

- ✅ Add new books to the library
- ✅ Update existing book information
- ✅ Delete books from the library
- ✅ Search books by author, title, or year
- ✅ Filter available/unavailable books
- ✅ Get library statistics
- ✅ Data validation (title, author, year constraints)

## 🗄️ Database Schema

**Books Table:**
```
- id (integer, primary key)
- title (string, required, max 200 chars)
- author (string, required, max 100 chars)  
- year (integer, between 1000-2030)
- available (boolean, default: true)
- inserted_at (timestamp)
- updated_at (timestamp)
```

## 🚀 Setup Instructions

### Prerequisites
- Elixir 1.19+
- PostgreSQL database running
- Mix build tool

### Installation Steps

1. **Clone and setup project:**
```bash
cd library_app
mix deps.get
```

2. **Configure database** (already done in `config/config.exs`):
```elixir
config :library_app, LibraryApp.Repo,
  database: "library_app_dev",
  username: "postgres", 
  password: "postgres",
  hostname: "localhost"
```

3. **Create and migrate database:**
```bash
mix ecto.create
mix ecto.migrate
```

4. **Start interactive console:**
```bash
iex -S mix
```

## 🧪 Testing Guide

### Basic Setup in IEx
```elixir
# Import modules for easier access
alias LibraryApp.Books
alias LibraryApp.Book
```

### 1. Creating Books
```elixir
# Create a new book
{:ok, book1} = Books.create_book(%{
  title: "The Alchemist", 
  author: "Paulo Coelho", 
  year: 1988
})

# Create more books
{:ok, book2} = Books.create_book(%{
  title: "1984", 
  author: "George Orwell", 
  year: 1949
})

{:ok, book3} = Books.create_book(%{
  title: "Animal Farm", 
  author: "George Orwell", 
  year: 1945,
  available: false
})
```

**Expected Result:**
```elixir
{:ok,
 %LibraryApp.Book{
   __meta__: #Ecto.Schema.Metadata<:loaded, "books">,
   id: 1,
   title: "The Alchemist",
   author: "Paulo Coelho",
   year: 1988,
   available: true,
   inserted_at: ~N[2025-11-20 12:33:34],
   updated_at: ~N[2025-11-20 12:33:34]
 }}
```

### 2. Reading Books
```elixir
# List all books
Books.list_books()

# Get specific book by ID
Books.get_book(1)

# Get book (raises error if not found)
Books.get_book!(1)
```

**Expected Result:**
```elixir
[
  %LibraryApp.Book{
    id: 1,
    title: "The Alchemist",
    author: "Paulo Coelho",
    year: 1988,
    available: true,
    # ... timestamps
  },
  # ... more books
]
```

### 3. Updating Books
```elixir
# Update book information
Books.update_book(book1, %{year: 1987, available: false})

# Update using get_book
book = Books.get_book!(1)
Books.update_book(book, %{title: "The Alchemist - Updated"})
```

### 4. Deleting Books
```elixir
# Delete a book
book_to_delete = Books.get_book!(3)
Books.delete_book(book_to_delete)
```

### 5. Search Operations
```elixir
# Search by author (case-insensitive, partial match)
Books.get_books_by_author("George Orwell")
Books.get_books_by_author("george")  # Also works

# Search in title or author
Books.search_books("Alchemist")
Books.search_books("Paulo")

# Filter by availability
Books.list_available_books()

# Filter by publication year
Books.get_books_by_year(1949)

# Get statistics
Books.get_books_stats()
```

**Expected Search Results:**
```elixir
# Books by author
[
  %LibraryApp.Book{title: "1984", author: "George Orwell", year: 1949},
  %LibraryApp.Book{title: "Animal Farm", author: "George Orwell", year: 1945}
]

# Statistics
%{total: 3, available: 2}
```

### 6. Testing Validations
```elixir
# Test validation errors
Books.create_book(%{title: "", author: "Test Author"})
# Returns: {:error, %Ecto.Changeset{...}} - title required

Books.create_book(%{title: "Test Book", author: "Test", year: 3000})
# Returns: {:error, %Ecto.Changeset{...}} - year too high

Books.create_book(%{title: "A" * 201, author: "Test"})
# Returns: {:error, %Ecto.Changeset{...}} - title too long
```

**Expected Validation Error:**
```elixir
{:error,
 %Ecto.Changeset{
   errors: [
     title: {"can't be blank", [validation: :required]},
     year: {"must be less than %{number}", [validation: :number, kind: :less_than, number: 2030]}
   ],
   valid?: false
 }}
```

## 📁 Project Structure

```
lib/
├── library_app/
│   ├── application.ex      # OTP Application
│   ├── repo.ex            # Database repository
│   ├── book.ex            # Book schema & changesets
│   └── books.ex           # Books context (CRUD operations)
├── library_app.ex         # Main module
config/
└── config.exs             # Database configuration
priv/repo/migrations/
└── *_create_books_table.exs  # Database migration
```

## 🔧 Available Functions

### LibraryApp.Books Context

| Function | Description | Example |
|----------|-------------|---------|
| `list_books/0` | Get all books | `Books.list_books()` |
| `get_book/1` | Get book by ID | `Books.get_book(1)` |
| `get_book!/1` | Get book by ID (raises if not found) | `Books.get_book!(1)` |
| `create_book/1` | Create new book | `Books.create_book(%{title: "...", author: "..."})` |
| `update_book/2` | Update existing book | `Books.update_book(book, %{year: 2020})` |
| `delete_book/1` | Delete book | `Books.delete_book(book)` |
| `list_available_books/0` | Get only available books | `Books.list_available_books()` |
| `get_books_by_author/1` | Search by author | `Books.get_books_by_author("Orwell")` |
| `search_books/1` | Search title or author | `Books.search_books("1984")` |
| `get_books_by_year/1` | Filter by year | `Books.get_books_by_year(1949)` |
| `get_books_stats/0` | Get library statistics | `Books.get_books_stats()` |

## 🎓 Learning Objectives Achieved

- ✅ **Ecto Schemas**: Defined Book schema with proper field types
- ✅ **Ecto Repo**: Created repository for database operations  
- ✅ **Ecto Changesets**: Implemented validation rules and data transformation
- ✅ **Ecto Queries**: Built complex search and filter operations
- ✅ **Database Migrations**: Created and ran database schema changes
- ✅ **Context Pattern**: Organized business logic in Books context
- ✅ **CRUD Operations**: Full Create, Read, Update, Delete functionality

## 🚀 Next Steps

Ready to move to **Phoenix Framework**? This foundation will help you understand:
- Phoenix Controllers (will use your Books context)
- Phoenix Views/Templates (will display your Book data)  
- Phoenix Forms (will use your Book changesets)
- Phoenix LiveView (real-time updates to your book library)

**Great job building your first Ecto application!** 🎉