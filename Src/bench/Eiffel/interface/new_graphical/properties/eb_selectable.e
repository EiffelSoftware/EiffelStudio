indexing
	description	: "Object that can be selected/deselectable."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_SELECTABLE

feature -- Status report
	
	is_selected: BOOLEAN
			-- Is current selected?

feature -- Status setting

	enable_selected is
			-- Set `is_selected' to True.
		deferred
		ensure
			selected: is_selected
		end

	disable_selected is
			-- Set `is_selected' to False.
		deferred
		ensure
			not_selected: not is_selected
		end

end -- class EB_SELECTABLE
