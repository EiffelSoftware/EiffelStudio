indexing
	description	: "Wizard state: Error in the supplied runtime information record."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_RUNTIME_INFO_RECORD_ERROR_STATE

inherit
	EB_WIZARD_ERROR_STATE_WINDOW

	EB_PROFILER_WIZARD_SHARED_INFORMATION
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
		do
			title.set_text (Interface_names.wt_Runtime_information_record_error)
			message.set_text (Interface_names.wb_Runtime_Information_Record_Error (information.generation_path))
		end

end -- class EB_PROFILER_WIZARD_RUNTIME_INFO_RECORD_ERROR_STATE
