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
		rename
			on_wm_erase_background as old_erase_background
		redefine
			on_size
		end			


	WEL_FRAME_WINDOW
		redefine
			on_wm_erase_background,
			on_size
		select
			on_wm_erase_background
		end		


creation
	make_top


feature
	
	attach_container (the_container: EV_CONTAINER_IMP) is
		do
			container := the_container
		end

feature {NONE} -- Implementation

	on_wm_erase_background (wparam: INTEGER) is
		do
			if container.the_child = Void then
				old_erase_background (wparam)
			else
				disable_default_processing
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			if container.the_child /= Void then
				container.the_child.parent_ask_resize (a_width, a_height)
			end
		end

feature {NONE} -- Access

	container: EV_CONTAINER_IMP

end -- class EV_WEL_FRAME_WINDOW
