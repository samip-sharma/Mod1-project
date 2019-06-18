require "catpix_mini"

def display_picture(url)
  CatpixMini::print_image url,
   :limit_x => 1,
   :limit_y => 0,
   :center_x => true,
   :center_y => true,
   :bg => "white",
   :bg_fill => true,
   :resolution => "high"
end
