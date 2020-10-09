defmodule Phoenixcra.TicTest do
  use Phoenixcra.DataCase

  alias Phoenixcra.Tic

  describe "games" do
    alias Phoenixcra.Tic.Game

    @valid_attrs %{" ": "some  "}
    @update_attrs %{" ": "some updated  "}
    @invalid_attrs %{" ": nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tic.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Tic.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Tic.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Tic.create_game(@valid_attrs)
      assert game.  == "some  "
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tic.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Tic.update_game(game, @update_attrs)
      assert game.  == "some updated  "
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Tic.update_game(game, @invalid_attrs)
      assert game == Tic.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Tic.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Tic.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Tic.change_game(game)
    end
  end

  describe "users" do
    alias Phoenixcra.Tic.User

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tic.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Tic.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Tic.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Tic.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tic.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Tic.update_user(user, @update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Tic.update_user(user, @invalid_attrs)
      assert user == Tic.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Tic.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Tic.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Tic.change_user(user)
    end
  end
end
