class Scrabble::Scoring

  SCORE_CHART = {
"A" => 1,
"E" => 1,
"I" => 1,
"O" => 1,
"U" => 1,
"L" => 1,
"N" => 1,
"R" => 1,
"S" => 1,
"T" => 1,
"D" => 2,
"G" => 2,
"B" => 3,
"C" => 3,
"M" => 3,
"P" => 3,
"F" => 4,
"H" => 4,
"V" => 4,
"W" => 4,
"Y" => 4,
"K" => 5,
"J" => 8,
"X" => 8,
"Q" => 10,
"Z" => 10
}

  # Take a word, upcase it, and return an array of its letters
  def self.word_letters(word)
     word.upcase.split(//)
  end

  # Finds the point value of each letter given
  def self.letter_points(letter)
    SCORE_CHART.fetch(letter)
  end

  # Finds point value of each letter in a word
  # Creates an array of points for each letter
  def self.word_points(word)
    word_letters(word).map { |i| letter_points(i) }
  end

  # Sums the points from the word_points array
  def self.score(word)
    total = 0
    # Adds a bonus for 7-letter words.
    if word_points(word).length == 7 then total = 50 end
    total += word_points(word).reduce(:+)
    total
    #=> Fixnum score of word Ex: if word = "dumpling" returns 14
  end

  def self.word_scores(array_of_words)
    # word_scores stores the points of each word in the array_of_words
    array_of_words.map { |word| score(word) }
    #=> Ex: TEST_WORD_ARRAY3 => [5, 20, 7, 20, 3, 70]
  end

  def self.word_score_pairs(array_of_words)
    # scores each word in array_of_words, then zips scores to words, creating subarray pairs - still in original TEST_WORD_ARRAY order.
    array_of_words.zip(word_scores(array_of_words))
    #=> Ex: TEST_WORD_ARRAY3 => [["cat", 5], ["jeez", 20], ["foot", 7], ["furzy", 20], ["see", 3], ["bcmpbcg", 70]]
  end

  def self.sort_pairs(array_of_words)
    # takes array from word_score_pairs and sorts by points.
    word_score_pairs(array_of_words).sort_by { |pair| pair[1]}
    #=> Ex: TEST_WORD_ARRAY3 => [["see", 3], ["cat", 5], ["foot", 7], ["jeez", 20], ["furzy", 20], ["bcmpbcg", 70]]
  end

  def self.find_ties(array_of_words)
    # If multiple words have the same highest-score, return the word with the least letters
    sort_pairs(array_of_words).find_all { |pair| pair[1] == sort_pairs(array_of_words)[-1][1] }
    #=> Ex: TEST_WORD_ARRAY3 => [["bcmpbcg", 70]]
    #=> Ex: TEST_WORD_ARRAY2 => [["jeez", 20], ["furzy", 20]]
  end

  def self.ties_w_seven_letters(array_of_words)
    find_ties(array_of_words).find_all { |word, points| word.length == 7 }
    #=> Ex: TEST_WORD_ARRAY5 => [["bgeeeee", 60]]
  end

  # Returns the highest-valued word in a word_array.
  def self.highest_score_from(array_of_words, index)
    if find_ties(array_of_words).length > 1
      if ties_w_seven_letters(array_of_words).length >= 1
        return ties_w_seven_letters(array_of_words)[0][index]
      else
        least_letters = find_ties(array_of_words).min_by { |pair| pair[0].length}
        return least_letters[index]
      end
    end
    # Returns the highest-scoring word.
    p sort_pairs(array_of_words)[-1][index]
    # "affined"
    # "bcmpbcg"
  end
end
