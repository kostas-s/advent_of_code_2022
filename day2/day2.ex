defmodule RpsGame do
  @answers ["A", "B", "C"]
  @alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def decrypt_answer(letter) do
    idx = index_of(@alphabet, letter)
    String.at(@alphabet, idx - 23)
  end

  def evaluate_game(enemy, player) do
    results = [:draw, :win, :lose]
    Enum.at(results, index_of(@alphabet, player) - index_of(@alphabet, enemy))
  end

  def pick_move(enemy, game_eval) do
    enemy_idx = Enum.find_index(@answers, fn x -> x == enemy end)
    modifier = Enum.find_index([:draw, :lose, :win], fn x -> x == game_eval end)
    Enum.at(@answers, enemy_idx - modifier)
  end

  defp index_of(string, substr) do
    String.split(string, substr)
    |> Enum.at(0)
    |> String.length()
  end
end

points = %{win: 6, draw: 3, lose: 0, A: 1, B: 2, C: 3}
part_b_eval = %{X: :lose, Y: :draw, Z: :win}

lines =
  File.read!("day2a.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x -> String.split(x, " ") end)

Enum.map(lines, fn x ->
  enemy = Enum.at(x, 0)
  player = RpsGame.decrypt_answer(Enum.at(x, 1))
  evaluation = RpsGame.evaluate_game(enemy, player)
  points[evaluation] + points[String.to_atom(player)]
end)
|> Enum.sum()
|> IO.inspect()

Enum.map(lines, fn x ->
  enemy = Enum.at(x, 0)
  player = Enum.at(x, 1)
  evaluation = part_b_eval[String.to_atom(player)]
  picked_move = RpsGame.pick_move(enemy, evaluation)
  points[evaluation] + points[String.to_atom(picked_move)]
end)
|> Enum.sum()
|> IO.inspect()
