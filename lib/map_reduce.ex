defmodule MapReduce do

  def execute(data) do
    data
    |> Enum.flat_map( fn line -> Mapper.map_line(line, " ") end )
    # |> IO.inspect(label: "mapped data")
    |> Shuffler.shuffle()
    |> Reducer.reduce_grouped_data()
  end

  def run_example do
    data = [
      "Elixir is awesome",
      "Elixir is concurrent",
      "Concurrency is awesome in Elixir"
    ]

    execute(data)
  end
end
