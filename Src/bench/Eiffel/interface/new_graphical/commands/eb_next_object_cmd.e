indexing

	description:	
		"Retarget the object tool with the next object in history."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEXT_OBJECT_CMD

inherit
	EB_NEXT_TARGET_CMD
		redefine
			execute_licensed
		end

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

creation

	make

feature -- Execution

	execute_licensed (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Retarget the object tool with the next object in history.
		local
			status: APPLICATION_STATUS
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_System_not_stopped)
			else
				{EB_NEXT_TARGET_CMD} Precursor (argument, data)
			end
		end

end -- class EB_NEXT_OBJECT_CMD
