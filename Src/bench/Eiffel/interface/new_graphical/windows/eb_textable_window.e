indexing
	description	: "A window with a text"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TEXTABLE_WINDOW

inherit
	EB_WINDOW

	EB_STONABLE

	EB_TEXTABLE

feature -- Update

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text area.
		do
			refresh
		end

feature -- Pick and Drop Implementation

	drop (s: STONE) is
			-- Drop the stone `s' in Current.
		do
			if s /= Void then 
				set_stone (s) 
			end
		end

	reset is
			-- Reset the window contents.
		do
			text_area.clear_window
		end

end -- class EB_TEXTABLE_WINDOW

