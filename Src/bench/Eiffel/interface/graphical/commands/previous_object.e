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
				warner.set_window (text_window);
				warner.gotcha_call ("System is not running")
			elseif not Run_info.is_stopped then
				warner.set_window (text_window);
				warner.gotcha_call ("System is not stopped")
			else
				pt_work (argument)
			end
		end;

end -- class PREVIOUS_OBJECT
