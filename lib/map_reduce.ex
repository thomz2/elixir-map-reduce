defmodule MapReduce do
  @moduledoc """
  Documentation for `MapReduce`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MapReduce.hello()
      :world

  """
  def hello do
    :world
  end

  def execute(data) do
    data
    |> Enum.flat_map( fn line -> Mapper.map_line(line, " ") end )
    |> Shuffler.shuffle()
    |> Reducer.reduce_grouped_data()
  end
end
