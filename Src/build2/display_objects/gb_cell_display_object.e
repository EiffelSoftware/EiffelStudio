indexing
	description: "Objects that represent a visible representation of an%
		%EV_CELL."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CELL_DISPLAY_OBJECT

inherit
	GB_DISPLAY_OBJECT
		redefine
			child
		end

create
	make_with_name_and_child,
	make_as_root_window

feature -- Initialization

	make_as_root_window (window: EV_TITLED_WINDOW) is
			-- Create `Current' as a root_window.
			-- Assign `window' to `child'.
		require
			window_not_void: window /= Void
		do
			default_create
			child := window
		ensure
			child = window
		end

feature -- Access

	child: EV_CELL
		-- The actual cell that we are representing.

end -- class GB_CELL_DISPLAY_OBJECT