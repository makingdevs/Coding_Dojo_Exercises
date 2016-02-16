def process(s, floor, position)
  current = s.pop
  position+=1
  floor+=1 if current == "("
  floor-=1 if current == ")"
  raise "at least in floor #{floor} at position #{position}" if floor == -1
  process(s, floor, position)
end
