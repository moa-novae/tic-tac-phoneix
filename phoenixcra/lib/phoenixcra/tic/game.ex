defmodule Phoenixcra.Tic.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :xIsNext, :boolean, default: true
    field :history, Phoenixcra.Json.Type
    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:xIsNext])
    |> validate_required([:xIsNext])
  end
end
