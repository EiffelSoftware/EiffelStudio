indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROL_WINDOW

inherit
	EV_WINDOW
		redefine
			make
		end

creation
	make

feature -- Initialization

    make (par: EV_WINDOW) is
			-- Create a window with a parent. Current
			-- window will be closed when the parent is
			-- closed. The parent of window is a window 
			-- (and not any EV_CONTAINER).
		do
			{EV_WINDOW} Precursor (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end


end -- class CONTROL_WINDOW
