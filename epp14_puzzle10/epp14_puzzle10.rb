def perm(word, arr)
  arr.each_with_object("") do |ind, newword|
    newword << (word[ind] || '')
  end
end

#puts perm("silver", [2,1,3,4,5,0]) == 'livers'

def behead(word)
  word[1..-1]
end

#puts behead("gold") == 'old'

def chop(word)
  word.chop
end

#puts chop('irony') == 'iron'

def gut(word, ind)
  word[0..ind-1] << word[ind+1..-1]
end

#puts gut('waiter', 2) == 'water'

def concat(word, another)
  word << another
end

#puts concat('quick', 'silver') == 'quicksilver'

def insert(word, inside, ind)
  first = 0
  first = ind unless ind == 0
  word[0..first-1] << inside << word[first..-1]
end

#puts insert('rang', 'tin', 3) == 'ranting'

def head(word, letter)
  letter << word
end

#puts head('lead', 'p') == 'plead'

def tail(word, letter)
  word << letter
end

#puts tail('pip', 'e') == 'pipe'

def rev(word)
  word.reverse
end

#puts rev('rats') == 'star'

def rotn(n, word)
  n.times do
    word.tr!('abcdefghijklmnopqrstuvwxyz',
            'bcdefghijklmnopqrstuvwxyza')
  end
  word
end

#puts rotn(2, 'adds') == 'cffu'

def replace(word, letter, ind)
  (word[0...ind] || '') << letter << (word[ind+1..-1] || '')
end

#puts replace('cooper', 'p', 2) == 'copper'

def shiftr(word)
  word[-1] << word[0..-2]
end

#puts shiftr('tarts') == 'start'

def shiftl(word)
  word[1..-1] << word[0]
end

#puts shiftl('eros') == 'rose'

# puts insert(rotn(10,chop(rev('stew'))), 'l', 2)

# puts concat(rev(replace(gut(behead(perm('silver', [0,2,1,3,4,5])), 2), 'a', 2)), 
#   replace(replace('lead', 'o', 1), 'r', 0)) 

# puts replace(replace(perm(concat(replace(chop(chop(head('ore', 't'))), 'g', 0), 
#     tail(insert(replace(head(shiftl(replace('tin', 'k', 0)), 's'), 'g', 3), 
#       'l', 1), 's')), [0,3,1,2,7,4,5,6]), 'r', 1),'c', 0) 

# puts behead(behead(gut(shiftr('earth'), 4)))

# puts replace(replace(replace(perm('salt', [2,1,0,3]), 'o', 2), 's', 4), 'r', 1)

puts concat('rail', replace('load', 'r', 0))

puts replace(replace(perm(concat(replace(chop(chop(head('ore', 't'))), 'g', 0), 
    tail(insert(replace(head(shiftl(replace('tin', 'k', 0)), 's'), 'g', 3), 
      'l', 1), 's')), [0,3,1,2,7,4,5,6]), 'r', 1),'c', 0)

puts 'ar'

puts replace(replace('lost', 's', 3), 'r', 0)