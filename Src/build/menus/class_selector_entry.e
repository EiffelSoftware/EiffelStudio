indexing
	description: "Entry in a menu used to hide or show the %
				% class selector."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_SELECTOR_ENTRY

inherit

	MAIN_PANEL_TOGGLE

	SHARED_CONTEXT

creation

	make

feature {NONE} -- Implementation

	toggle_pressed is
			-- Hide or show the class selector.
		do
			if armed then
				class_selector.display
			else
				class_selector.hide
			end
		end

end -- class CLASS_SELECTOR_ENTRY
