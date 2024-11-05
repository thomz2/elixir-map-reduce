defmodule MapReduce do

  defp maybe_inspect(data, true, label), do: IO.inspect(data, label: label)
  defp maybe_inspect(data, false, _label), do: data

  def execute(data, debug \\ false, skip \\ false) do
    data
    |> Enum.flat_map( fn line -> Mapper.map_line(line, " ", skip) end )
    |> maybe_inspect(debug, "op1 data")
    |> Shuffler.shuffle()
    |> maybe_inspect(debug, "op2 data")
    |> Reducer.reduce_grouped_data()
    |> maybe_inspect(debug, "op3 data")
  end

  def execute_w_time(data, debug \\ false, skip \\ false) do
    {time, result} = :timer.tc(fn -> execute(data, debug, skip) end)
    IO.puts("MapReduce: #{time} ms")
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

    execute(data)
  end
end
