defmodule LibraryApp.Repo.Migrations.CreateBooksTable do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false
      add :author, :string, null: false
      add :year, :integer
      add :available, :boolean, default: true, null: false

      timestamps()
    end
    # add the indxes for better performance
    create index(:books, [:author])
    create index(:books, [:available])
  end
end
