# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Phoenixcra.Repo.insert!(%Phoenixcra.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Delete all previous entries before seeding
Phoenixcra.Repo.delete_all Phoenixcra.Game
Phoenixcra.Repo.delete_all Phoenixcra.User

# Only one game right now
Phoenixcra.Repo.insert!(%Phoenixcra.Game{
  xIsNext: false,
  history: [[nil, nil, nil, nil, nil, nil, nil, nil, nil]]
})

Phoenixcra.Repo.insert!(%Phoenixcra.User{
  name: "x",
  win: 0
})

Phoenixcra.Repo.insert!(%Phoenixcra.User{
  name: "o",
  win: 0
})
