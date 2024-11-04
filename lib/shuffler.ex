defmodule Shuffler do
  def shuffle(mapped_data) do
    Enum.group_by(
      mapped_data,
      fn {key, _value} -> key end,
      fn {_key, value} -> value end
    )
  end
end
