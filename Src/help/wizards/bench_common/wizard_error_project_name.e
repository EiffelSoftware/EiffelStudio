indexing
	description	: "Wizard state: Error in the project name"
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_ERROR_PROJECT_NAME

inherit
	BENCH_WIZARD_ERROR_STATE_WINDOW
	
	BENCH_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- basic Operations

	display_state_text is
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.t_Project_name_error_state)
			message.set_text (Interface_names.m_Project_name_error_state)
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Wel Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_ERROR_PROJECT_NAME

