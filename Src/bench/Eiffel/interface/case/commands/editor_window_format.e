indexing

	description: "Abstract command representing a format for editor windows.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	EDITOR_WINDOW_FORMAT

inherit
	FORMAT_COMMAND
		select
			work
			--execute_licensed
		end

	--EDITOR_WINDOW_COM
	--	undefine
	--		work 
	--	end

	EC_EDITOR_WINDOW_COM


end -- class EDITOR_WINDOW_FORMAT
