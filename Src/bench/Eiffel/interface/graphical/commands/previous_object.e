indexing

	description:	
		"Retarget the object tool with the previous object in history.";
	date: "$Date$";
	revision: "$Revision$"

class
	PREVIOUS_OBJECT

inherit
	PREVIOUS_TARGET
		redefine
			work
		end;

	SHARED_APPLICATION_EXECUTION

create
	make

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the object tool with the previous object in history.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if status = Void then
				warner (popup_parent).gotcha_call (Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				warner (popup_parent).gotcha_call (Warning_messages.w_System_not_stopped)
			else
				Precursor {PREVIOUS_TARGET} (argument)
			end
		end;

end -- class PREVIOUS_OBJECT
