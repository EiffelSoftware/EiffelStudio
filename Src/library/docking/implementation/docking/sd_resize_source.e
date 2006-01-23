indexing
	description: "SD_ZONE  want to be resized by user should inherit this."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
