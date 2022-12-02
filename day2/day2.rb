ANSWERS = %w[A B C]
POINTS = { win: 6, draw: 3, lose: 0, A: 1, B: 2, C: 3 }
PART_B_EVAL = { X: :lose, Y: :draw, Z: :win }
lines = File.readlines("day2a.txt").map(&:chomp)

# Part A
def decrypt_answer(letter)
  alphabet = ("A".."Z").to_a
  alphabet[alphabet.index(letter) - 23]
end

def evaluate_game(enemy, player)
  result_idx = ANSWERS.index(player) - ANSWERS.index(enemy)
  %i[draw win lose][result_idx]
end

puts("PART A: " + lines.map do |line|
  parts = line.split
  game_eval = evaluate_game(parts[0], decrypt_answer(parts[1]))
  POINTS[game_eval] + POINTS[decrypt_answer(parts[1]).to_sym]
end.sum(0).to_s)

# Part B
def pick_move(enemy, game_eval)
  enemy_idx = ANSWERS.index(enemy)
  return ANSWERS[enemy_idx] if game_eval == :draw

  game_eval == :win ? ANSWERS[enemy_idx - 2] : ANSWERS[enemy_idx - 1]
end

puts("PART B: " + lines.map do |line|
  parts = line.split
  game_eval = PART_B_EVAL[parts[1].to_sym]
  picked_move = pick_move(parts[0], game_eval)
  POINTS[game_eval] + POINTS[picked_move.to_sym]
end.sum(0).to_s)
