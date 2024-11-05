defmodule Mapper do
  def map_line(line, pattern \\ " ", skip \\ false) do
    line
    |> String.split(pattern)
    |> Enum.filter(fn word -> !skip || String.length(word) > 4 end)
    |> Enum.map( fn word -> {String.downcase(word), 1} end )
  end
end
