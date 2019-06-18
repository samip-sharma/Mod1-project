require "catpix_mini"

def display_picture
  CatpixMini::print_image "url",
 :limit_x => 1.0,
 :limit_y => 0,
 :center_x => true,
 :center_y => true,
 :bg => "white",
 :bg_fill => true,
 :resolution => "low"
end
display_picture
