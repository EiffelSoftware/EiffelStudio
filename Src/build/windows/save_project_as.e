
class SAVE_PROJECT_AS

inherit

	SAVE_PROJECT
		export
			{NONE} all;
			{ANY} execute
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

end
