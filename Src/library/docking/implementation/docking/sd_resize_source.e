indexing
	description: "Objects that have the functions and fields used for resizeing. Window want to be resized by user should inherit this."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_RESIZE_SOURCE

feature -- Resize stuffs.
	
	start_resize_operation (a_bar: SD_RESIZE_BAR; a_screen_boundary: EV_RECTANGLE) is
			-- Things to do when start resize operation.
		require
			a_bar_not_void: a_bar /= Void
			a_screen_boundary_not_void: a_screen_boundary /= Void
		deferred
		end
	
	end_resize_operation (a_bar: SD_RESIZE_BAR; a_delta: INTEGER) is
			-- Things to do when end resize operation. Normally should resize the widget size.
		require
			a_bar_not_void: a_bar /= Void
		deferred
		end

feature -- Resize enumeration
	 
	 horizontal: INTEGER is 1
	 		-- Resize horizontal.
	 
	 vertical: INTEGER is 2
	 		-- Resize vertical.

end
