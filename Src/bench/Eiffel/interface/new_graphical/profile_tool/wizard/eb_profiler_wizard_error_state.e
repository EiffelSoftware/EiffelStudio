indexing
	description	: "State to display the error in the wizard generation step"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_GENERATION_ERROR_STATE

inherit
	EB_WIZARD_ERROR_STATE_WINDOW
	
	EB_ERROR_MANAGER
		export
			{NONE} all
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- basic Operations

	display_state_text is
		local
			errors: STRING
		do
				-- Compute the error message
			create errors.make (20)
			from
				error_messages.start
			until
				error_messages.after
			loop
				errors.append (error_messages.item)
				errors.append ("%N")
				error_messages.forth
			end
			errors.append ("%N")
			errors.append (Interface_names.wb_Click_back_and_correct_error)

				-- Display the error message
			title.set_text (Interface_names.wt_Generation_Error)
			message.set_text (errors)
			
				-- Clear the error log
			clear_error_messages	
		end

end -- class EB_PROFILER_WIZARD_GENERATION_ERROR_STATE
