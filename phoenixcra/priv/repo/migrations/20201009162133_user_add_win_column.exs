defmodule Phoenixcra.Repo.Migrations.UserAddWinColumn do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :win, :integer
    end
  end
end
