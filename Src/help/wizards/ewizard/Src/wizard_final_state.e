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

create
	make

feature -- Basic Operations

	proceed_with_current_info is
		local
			ace_location: FILE_NAME
		do
			create ace_location.make_from_string (wizard_information.project_location)
			ace_location.set_file_name ("ace")
			ace_location.add_extension ("ace")
			wizard_information.set_ace_location (ace_location)

			project_generator.generate_code
			write_bench_notification_ok (wizard_information)

			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		local
			word: STRING
		do
			title.set_text ("Completing the New Wizard %NApplication Wizard")
			if wizard_information.compile_project then
				word :=" and compile "
			else
				word := " "
			end
			message.set_text (
				"You have specified the following settings:%N%
				%%N%
				%Project name: %T" + wizard_information.project_name + "%N%
				%Location:     %T" + wizard_information.project_location + "%N%
				%%N%
				%%N%
				%Click Finish to generate" + word + "this project")
		end

	final_message: STRING is
		do
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Store Wizard

end -- class WIZARD_FINAL_STATE
