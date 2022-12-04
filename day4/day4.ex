lines =
  File.read!("day4.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x ->
    String.split(x, ",")
  end)
  |> Enum.map(fn x ->
    Enum.map(x, fn y ->
      [a, b] = String.split(y, "-", trim: true)

      Range.new(String.to_integer(a), String.to_integer(b))
    end)
  end)

# Part A
Enum.filter(lines, fn x ->
  first =
    Enum.at(x, 0)
    |> MapSet.new()

  second =
    Enum.at(x, 1)
    |> MapSet.new()

  MapSet.subset?(first, second) || MapSet.subset?(second, first)
end)
|> Enum.count()
|> IO.inspect()

# Part B
Enum.filter(lines, fn x ->
  !Range.disjoint?(Enum.at(x, 0), Enum.at(x, 1))
end)
|> Enum.count()
|> IO.inspect()
