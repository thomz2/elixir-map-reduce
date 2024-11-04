defmodule MapReduce do

  defp maybe_inspect(data, true, label), do: IO.inspect(data, label: label)
  defp maybe_inspect(data, false, _label), do: data

  def execute(data, debug \\ false) do
    data
    |> Enum.flat_map( fn line -> Mapper.map_line(line, " ") end )
    |> maybe_inspect(debug, "op1 data")
    |> Shuffler.shuffle()
    |> maybe_inspect(debug, "op2 data")
    |> Reducer.reduce_grouped_data()
    |> maybe_inspect(debug, "op3 data")
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
