indexing
	description: "Entry in a menu used to hide or show the %
				% history window."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	HISTORY_WINDOW_ENTRY

inherit

	MAIN_PANEL_TOGGLE

	SHARED_CONTEXT

creation

	make

feature {NONE}

	toggle_pressed is
			-- Display or hide the history window.
		do
			if armed then
				History_window.show
			else
				History_window.hide
			end
		end

end -- class HISTORY_WINDOW_ENTRY
