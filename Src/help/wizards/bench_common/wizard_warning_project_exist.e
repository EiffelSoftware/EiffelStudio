indexing
	description	: "Wizard state: Error in the choosen directory"
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_WARNING_PROJECT_EXIST

inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

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
			title.set_text (Bench_interface_names.t_Project_allready_exist)
			message.set_text (Bench_interface_names.m_Project_allready_exist)
		end

	proceed_with_current_info is
		do
			Precursor
			proceed_with_new_state(create {WIZARD_SECOND_STATE}.make (wizard_information))
		end
		

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_WARNING_PROJECT_EXIST

