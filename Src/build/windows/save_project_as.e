
class SAVE_PROJECT_AS

inherit

	SAVE_PROJECT
		export
			{NONE} all;
			{ANY} execute
		undefine
			continue_after_popdown
		redefine
			make_backup
		end;

creation

	make

feature -- Creation

	make (c: SAVE_AS_PROJ_WIN) is
			-- Create command and set caller to `c'
		do
			caller := c
		end;

feature {NONE} 

	caller: SAVE_AS_PROJ_WIN;
			-- Calling window that executed this command

	continue_after_popdown (box: ERROR_BOX; ok: BOOLEAN) is
		do
			if box = error_box then
				caller.continue_after_error;
			end;
		end;

	make_backup is
		do
		end;


end
