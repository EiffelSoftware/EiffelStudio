-- Retarget the object tool with the previous object in history

class

	PREVIOUS_OBJECT

inherit

	PREVIOUS_TARGET
		rename
			work as pt_work
		end;

	PREVIOUS_TARGET
		redefine
			work
		select
			work
		end;

	SHARED_DEBUG

creation

	make

feature

	work (argument: ANY) is
			-- Retarget the object tool with the previous object in history.
		do
			if not Run_info.is_running then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not Run_info.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			else
				pt_work (argument)
			end
		end;

end -- class PREVIOUS_OBJECT
