defmodule Pokelixir do
  @moduledoc """
  Documentation for `Pokelixir`.
  """


  def get(name) do
    get_pokemon_pokeapi(name)
  end

  def all() do
    all_pokemon_pokeapi()
  end

  defp all_pokemon_pokeapi() do
    method = :get
    url = "https://pokeapi.co/api/v2/pokemon"
    response = Finch.build(method, url) |> Finch.request!(PokeFinch)
    decode_body = Jason.decode!(response.body)
    generate_pokemon_list(decode_body)
  end


  defp get_pokemon_pokeapi(name) do
    method = :get
    url = "https://pokeapi.co/api/v2/pokemon/#{name}"
    response = Finch.build(method, url) |> Finch.request!(PokeFinch)
    decoded_body = Jason.decode!(response.body)
    decode_pokemon(decoded_body)
  end

  defp decode_pokemon(pokemon) do

    stats = find_stats(pokemon["stats"])

    types = find_types(pokemon["types"])

    %Pokelixir.Pokemon{
      id: pokemon["id"],
      name: pokemon["name"],
      hp: stats[:hp],
      attack: stats[:attack],
      defense: stats[:defense],
      special_attack: stats[:"special-attack"],
      special_defence: stats[:"special-defense"],
      speed: stats[:speed],
      weight: pokemon["weight"],
      height: pokemon["height"],
      types: types
    }
  end

  defp generate_pokemon_list(body) do
    %{"results" => results} = body
    Enum.map(results, fn %{"name" => name} ->
      get(name)
    end)
  end

  defp find_stats(stats) do
    Enum.map(stats, fn stat ->
      %{"base_stat" => value, "stat" => %{"name" => name}} = stat
      {String.to_atom(name), value}
    end)
  end

  defp find_types(types) do
    Enum.map(types, fn type ->
      %{"type" => %{"name" => name}} = type
      name
    end)
  end
end
