indexing
	description: "EiffelBuild top window."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOP_WINDOW

inherit
	EV_WINDOW
		rename
			make as window_make
		end

--	UNDO_REDO_ACCELERATOR

creation
	make

feature -- Initialization

	make is
			-- Create a top level window.
		do
			make_top_level
--			add_undo_redo_accelerator (Current)
		end

end -- class EB_TOP_WINDOW

