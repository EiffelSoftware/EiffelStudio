indexing
	description	: "Final state of the wizard."
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
			title.set_text (Interface_names.m_Final_title)
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

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string ("eiffel_wizard_icon")
			 Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_FINAL_STATE
