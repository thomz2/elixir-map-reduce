defmodule MapReduceTest do
  use ExUnit.Case
  doctest MapReduce

  test "map reduce counts word frequency correctly" do
    data = [
      "Elixir is awesome",
      "Elixir is concurrent",
      "Concurrency is awesome in Elixir",
    ]

    result = MapReduce.execute(data)

    assert result == %{
      "elixir" => 3,
      "is" => 3,
      "awesome" => 2,
      "concurrent" => 1,
      "concurrency" => 1,
      "in" => 1
    }
  end
end
