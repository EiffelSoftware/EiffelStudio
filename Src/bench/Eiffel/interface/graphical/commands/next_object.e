-- Retarget the object tool with the next object in history

class

	NEXT_OBJECT

inherit

	NEXT_TARGET
		rename
			work as nt_work
		end;

	NEXT_TARGET
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
			-- Retarget the object tool with the next object in history.
		do
			if not Run_info.is_running then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not Run_info.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			else
				nt_work (argument)
			end
		end;

end -- class NEXT_OBJECT
