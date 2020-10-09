defmodule Phoenixcra.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :xIsNext, :boolean, default: false, null: false
      add :history, :json, null: false
      timestamps()
    end
  end
end
