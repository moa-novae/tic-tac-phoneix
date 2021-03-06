defmodule Extensions.JSON do
  alias Postgrex.TypeInfo

  @behaviour Postgrex.Extension
  @json ["json", "jsonb"]

  def init(_parameters, opts),
    do: Keyword.fetch!(opts, :library)

  def matching(_library),
    do: [type: "json", type: "jsonb"]

  def format(_library),
    do: :binary

  def encode(%TypeInfo{type: "json"}, map, _state, library),
    do: library.encode!(map)

  def encode(%TypeInfo{type: "jsonb"}, map, _state, library),
    do: <<1, library.encode!(map)::binary>>

  def decode(%TypeInfo{type: "json"}, json, _state, library),
    do: library.decode!(json)

  def decode(%TypeInfo{type: "jsonb"}, <<1, json::binary>>, _state, library),
    do: library.decode!(json)
end

defmodule Phoenixcra.Json do
  defmodule Type do
    @behaviour Ecto.Type
    alias Jsonexample.Json

    def type, do: :json

    def load({:ok, json}), do: {:ok, json}
    def load(value), do: load(Poison.decode(value))

    def dump(value), do: Poison.encode(value)
  end
end
