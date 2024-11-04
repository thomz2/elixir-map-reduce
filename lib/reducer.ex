defmodule Reducer do
  def reduce_grouped_data(grouped_data) do
    Enum.map(
      grouped_data,
      fn {key, values} -> {key, Enum.sum(values)} end
    )
    |> Enum.into(%{})
  end
end
