indexing
	description: "EiffelVision wel_control_window is a certain kind of %
				  % wel_control_window designed for ev."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_CONTROL_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			make as wel_make
		redefine
			on_size,
			on_wm_erase_background,
			on_erase_background
		end			

	WEL_RGN_CONSTANTS


creation
	make


feature -- Initialization

	make (a_parent: WEL_WINDOW; name: STRING) is
			-- Create the window
		do
			make_with_coordinates (a_parent, "", 0, 0, 0, 0)
			!! erase_region.make_empty
		end

feature -- Access

	erase_region: WEL_REGION
			-- Region that needs to be erase before a repaint.

	old_width, old_height: INTEGER
			-- The size before a resizing

feature -- Status setting

	initialize_erase_region is
			-- Initializes the `erase_region' to the entire container area.
		do
			erase_region.set_rect (0, 0, width, height)
		end

	remove_child_rectangle (child: EV_WIDGET_IMP) is
			-- Informs the window of the presence of a child.
			-- A child update himself, therefore, there is no
			-- need for the window to update the rectangle 
			-- of the child.
		local
			child_region: WEL_REGION
		do
			!! child_region.make_rect (child.x, child.y, child.x + child.width, child.y + child.height)
			erase_region := erase_region.combine(child_region, Rgn_diff)
		end


feature {NONE} -- Implementation

	on_size (size_type, new_width, new_height: INTEGER) is
			-- Is called when the window resizes itself
		local
			container_region: WEL_REGION
		do
			if new_width > old_width or new_height > old_height then
				!! container_region.make_polygon_winding (<< 0, old_height, old_width, old_height, old_width, 0, new_width, 0, new_width, new_height, 0, new_height, 0, old_height>>)
				erase_region := erase_region.combine (container_region, Rgn_or)  
			end
			old_width := width
			old_height := height
		end


	on_wm_erase_background (wparam: INTEGER) is
			-- Doesn't erase everything, just what is needed, which is the 
			-- erase_region. Never lets the defaults processing handle
			-- the problem.
		local
			paint_dc: WEL_PAINT_DC
		do
			!! paint_dc.make_by_pointer (Current, cwel_integer_to_pointer (wparam));
 			if scroller /= void then
 				paint_dc.set_viewport_origin (- scroller.horizontal_position, - scroller.vertical_position)
 			end;
			paint_dc.select_clip_region (erase_region)
			on_erase_background (paint_dc, client_rect)
			disable_default_processing
		end

   	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
   			-- Erases the background, even when there is no background brush
		do
 			paint_dc.fill_rect (invalid_rect, class_background)
  		end
	

end -- class EV_WEL_CONTROL_WINDOW
