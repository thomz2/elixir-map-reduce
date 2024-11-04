defmodule Mapper do
  def map_line(line, pattern = " ") do
    line
    |> String.split(pattern)
    |> Enum.map( fn word -> {String.downcase(word), 1} end )
  end
end
