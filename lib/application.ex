defmodule Pokelixir.Application do
  @moduledoc """
  Documentation for Application
  """

  use Application

  def start(_start_type, _start_args) do
    Pokelixir.Supervisor.start_link(name: PokeSupervisor)
  end
end
