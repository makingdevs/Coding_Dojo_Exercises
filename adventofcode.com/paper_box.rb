def get_area(l,w,h)
  2*(w*h + l*h + l*w)
end

def min(l,w,h)
  [l*w, l*h, w*h].min
end

def get_total_per_box (l,w,h)
  get_area(l,w,h)+min(l,w,h)
end

def process_file()
  f = File.open "datos.txt"
  total_order = 0
  f.each_line do | l |
    elements = l.split('x')
    total_order += get_total_per_box(elements[0].to_i,elements[1].to_i,elements[2].to_i)
  end
  total_order
end

