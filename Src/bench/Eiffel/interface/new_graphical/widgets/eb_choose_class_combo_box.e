indexing
	description	: "Combo box to choose a class in the system. Accept wildcards"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHOOSE_CLASS_COMBO_BOX

inherit
	EV_COMBO_BOX

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the dialog with the manager `a_favorites_manager'
		do
			default_create
			prepare
		end

	prepare is
			-- Create the controls and setup the layout
		local
		do
		end

feature -- Activation

feature -- Access

feature {NONE} -- Implementation

end -- class EB_CHOOSE_CLASS_COMBO_BOX
	
