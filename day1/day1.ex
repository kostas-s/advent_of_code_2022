defmodule FoodCounter do
  def list_with_totals(file) do
    String.split(file, "\n\n")
    |> Enum.map(fn x -> String.split(x, "\n") end)
    |> Enum.map(&map_to_integers/1)
    |> Enum.map(fn {_num, acc} -> acc end)
  end

  defp map_to_integers(tup) do
    Enum.reject(tup, fn x -> x == "" end)
    |> Enum.map_reduce(0, fn x, acc ->
      {val, _} = Integer.parse(x)
      {val + acc, val + acc}
    end)
  end
end

{:ok, file} = File.read("day1a.txt")

# Part A

max_food =
  FoodCounter.list_with_totals(file)
  |> Enum.max()

IO.inspect(max_food)

# Part B

sum_top_three =
  FoodCounter.list_with_totals(file)
  |> Enum.sort(:desc)
  |> Enum.slice(0..2)
  |> Enum.sum()

IO.inspect(sum_top_three)
