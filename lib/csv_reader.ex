defmodule CSVReader do
    alias CSV, as: CSVLib
  
    def read_csv(file_path, column_index) do
      file_path
      |> File.stream!()
      |> CSVLib.decode()
      |> Enum.map(fn 
        {:ok, row} -> 
          Enum.at(row, column_index)
        {:error, _reason} -> 
          # IO.warn("error when reading line")
          nil
      end)
      |> Enum.filter(& &1) # filtra valores "verdadeiros"
    end
end
  