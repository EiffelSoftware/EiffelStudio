indexing
	description	: "Template for the last state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end
		
	WIZARD_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operations

	proceed_with_current_info is
		local
			ace_location: FILE_NAME
		do
			create ace_location.make_from_string (wizard_information.project_location)
			ace_location.set_file_name ("Ace")
			ace_location.add_extension ("ace")
			wizard_information.set_ace_location (ace_location)

			project_generator.generate_code
			write_bench_notification_ok (wizard_information)

			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
			-- Display message text relative to current state.
		local
			message_text: STRING
		do
			message_text :=	Interface_names.m_Final_state(wizard_information.compile_project,
					wizard_information.project_name, wizard_information.project_location)

			title.set_text (Interface_names.t_Final_state)
			message.set_text (message_text)
		end

	final_message: STRING is
		do
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Store Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_FINAL_STATE
