indexing

	description:	
		"Retarget the object tool with the previous object in history."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREVIOUS_OBJECT_CMD

inherit
	EB_PREVIOUS_TARGET_CMD
		redefine
			execute_licensed
		end

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Implementation

	execute_licensed is
			-- Retarget the object tool with the previous object in history.
		local
			status: APPLICATION_STATUS
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				create wd.make_with_text (Warning_messages.w_System_not_running)
				wd.show_modal
			elseif not status.is_stopped then
				create wd.make_with_text (Warning_messages.w_System_not_stopped)
				wd.show_modal
			else
				{EB_PREVIOUS_TARGET_CMD} Precursor
			end
		end;

end -- class EB_PREVIOUS_OBJECT_CMD
