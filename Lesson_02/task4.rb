vowels_hash = { a: 0, e: 0, i: 0, o: 0, u: 0, y: 0 }
vowels_hash_with_index = {}

(:a..:z).each_with_index do |letter, index|
  vowels_hash_with_index[letter] = index + 1 unless (vowels_hash[letter]).nil?
end

puts vowels_hash_with_index
