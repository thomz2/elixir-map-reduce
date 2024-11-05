defmodule MapReduceFlow do

    defp maybe_inspect(data, true, label), do: IO.inspect(data, label: label)
    defp maybe_inspect(data, false, _label), do: data

    def execute(data, debug \\ false, skip \\ false) do
      data
      |> Flow.from_enumerable()
      |> Flow.flat_map( fn line -> Mapper.map_line(line, " ", skip) end )
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

    def execute_w_time(data, debug \\ false, skip \\ false) do
      {time, result} = :timer.tc(fn -> execute(data, debug, skip) end)
      IO.puts("MapReduceFlow: #{time} ms")
      result
    end

    defp get_top_words(result, n) do
      result
      |> Enum.to_list()
      |> Enum.sort_by(fn {_word, count} -> -count end)
      |> Enum.take(n)
    end
    
    def run_tweets do
      CSVReader.read_csv("assets/tweets.csv", 1)
      |> execute_w_time(false, true)
      |> get_top_words(20)
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