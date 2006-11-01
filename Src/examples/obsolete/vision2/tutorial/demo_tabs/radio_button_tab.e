indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end


create
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects

		once
			Precursor {ANY_TAB} (Void)
			
				-- Creates the objects and their commands
			create label.make_with_text(Current, "All features are inherited from EV_CHECK_BUTTON,%Ntherefore there are no features unique to EV_RADIO_BUTTON to modify")
			set_child_position (label, 0, 0, 1, 1)
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Radio Button"
		end

	label: EV_LABEL

feature -- Execution feature  

feature -- Access

	current_widget: EV_RADIO_BUTTON
	f1: FEATURE_MODIFIER	
	b1: EV_BUTTON;
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


end -- class RADIO_BUTTON_TAB

