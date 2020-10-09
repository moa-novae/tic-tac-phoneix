defmodule PhoenixcraWeb.GameView do
  use PhoenixcraWeb, :view
  alias PhoenixcraWeb.GameView

  def render("index.json", %{games: games}) do
    %{data: render_many(games, GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id,
      xIsNext: game.xIsNext,
      history: game.history
    }
  end
end
