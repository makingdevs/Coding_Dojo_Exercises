file = File.open("boxes.txt","r")

paper_for_all_boxes = file.readlines.collect do |s|
  s.split("x").collect do |n_string|
    n_string.to_i
  end
end

paper_for_all_boxes_with_slack = paper_for_all_boxes.collect do |(a,b,c)|
  [2*a*b,2*b*c,2*a*c, [a*b,b*c,a*c].min]
end

#p paper_for_all_boxes_with_slack

total_paper_per_box = paper_for_all_boxes_with_slack.collect { |paper_needed| paper_needed.reduce :+ }

p total_paper_per_box.reduce :+

ribbon_for_all_boxes_with_slack = paper_for_all_boxes.collect do |(a,b,c)|
  (2 * ([a+b,b+c,a+c].min)) + (a * b * c)
end

p ribbon_for_all_boxes_with_slack.reduce :+
