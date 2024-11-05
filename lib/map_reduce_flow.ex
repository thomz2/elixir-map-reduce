defmodule MapReduceFlow do

    defp maybe_inspect(data, true, label), do: IO.inspect(data, label: label)
    defp maybe_inspect(data, false, _label), do: data

    def execute(data, debug \\ false) do
      data
      |> Flow.from_enumerable()
      |> Flow.flat_map( fn line -> Mapper.map_line(line, " ") end )
      |> maybe_inspect(debug, "op1 data")
      |> Flow.partition() # acc
      |> maybe_inspect(debug, "op1 data")
      |> Flow.reduce(
        fn -> %{} end, # inicio                             #fn x -> x + value
        fn {key, value}, acc -> Map.update(acc, key, value, &(&1 + value)) end
      )
      |> maybe_inspect(debug, "op1 data")
      |> Enum.into(%{})
    end

    def execute_w_time(data, debug \\ false) do
      {time, result} = :timer.tc(fn -> execute(data, debug) end)
      IO.puts("MapReduceFlow: #{time} ms")
      result
    end

    def run_example do
      data = [
        "Elixir is awesome",
        "Elixir is concurrent",
        "Concurrency is awesome in Elixir"
      ]
    
      execute(data, true)
    end
end