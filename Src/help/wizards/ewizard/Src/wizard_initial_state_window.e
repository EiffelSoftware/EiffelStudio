indexing
	description	: "Initial State"
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	BENCH_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end
		
	WIZARD_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- basic Operations

	proceed_with_current_info is 
			-- Process user entries, and perform actions accordingly.
			-- This is executed when user press 'Next'.
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_PROJECT_NAME_AND_LOCATION_STATE}.make(wizard_information))
		end

	display_state_text is
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.t_Initial_state)
			message.set_text (Interface_names.m_Initial_state)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Store Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_INITIAL_STATE
