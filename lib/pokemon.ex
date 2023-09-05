defmodule Pokelixir.Pokemon do
  @moduledoc """
  Documentation for a Pokemon struct
  """
  @enforce_keys [
    :id,
    :name,
    :hp,
    :attack,
    :defense,
    :special_attack,
    :special_defence,
    :speed,
    :weight,
    :height,
    :types
  ]
  defstruct [
    :id,
    :name,
    :hp,
    :attack,
    :defense,
    :special_attack,
    :special_defence,
    :speed,
    :weight,
    :height,
    :types
  ]
end
