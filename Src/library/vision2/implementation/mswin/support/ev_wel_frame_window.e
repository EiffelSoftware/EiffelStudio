indexing
	description: "EiffelVision wel frame window is a certain kind of %
				  % wel_frame_window designed for ev."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_FRAME_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_size,
			on_wm_erase_background
		end			

creation
	make_top

feature
	
	add_child (the_child: EV_CONTAINER_IMP) is
		do
			child := the_child
		end

feature {NONE} -- Implementation

	on_wm_erase_background (wparam: INTEGER) is
		do
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			if a_width > child.minimum_width or a_height > child.minimum_height then
				child.child_has_resized (a_width.max(child.minimum_width), a_height.max(child.minimum_height), child)
			else
				child.child_has_resized (child.minimum_width, child.minimum_height, child)
			end
		end

feature {NONE} -- Access

	child: EV_CONTAINER_IMP

end -- class EV_WEL_FRAME_WINDOW
