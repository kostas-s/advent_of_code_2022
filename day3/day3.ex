defmodule Day3 do
  @points "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def point_for_letter(let) do
    1 +
      (String.split(@points, let)
       |> Enum.at(0)
       |> String.length())
  end

  def set_for_string_list(str_list) do
    Enum.map(str_list, fn x ->
      MapSet.new(String.graphemes(x))
    end)
  end
end

lines =
  File.read!("day3.txt")
  |> String.split("\n", trim: true)

Enum.map(lines, fn x ->
  len = String.length(x)
  {a, b} = String.split_at(x, div(len, 2))
  [a_set, b_set] = Day3.set_for_string_list([a, b])
  [let] = Enum.filter(a_set, fn x -> x in b_set end)
  Day3.point_for_letter(let)
end)
|> Enum.sum()
|> IO.inspect()

Enum.chunk_every(lines, 3)
|> Enum.map(fn x ->
  [set_a, set_b, set_c] = Day3.set_for_string_list(x)
  set = MapSet.intersection(set_a, set_b)
  set = MapSet.intersection(set, set_c)
  Day3.point_for_letter(Enum.at(set, 0))
end)
|> Enum.sum()
|> IO.inspect()
