indexing
	description	: "Final state of the wizard."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

	EXECUTION_ENVIRONMENT
		rename
			command_line as ex_command_line
		end

create
	make

feature -- Basic Operations

	proceed_with_current_info is
		do
			project_generator.generate_code
			write_bench_notification_ok (wizard_information)

			Precursor
		end

feature -- Access

	display_state_text is
		local
			word: STRING
		do
			title.set_text ("Completing the New Vision2%NApplication Wizard")
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

feature {NONE} -- Implementation

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Wel Wizard

end -- class WIZARD_FINAL_STATE
