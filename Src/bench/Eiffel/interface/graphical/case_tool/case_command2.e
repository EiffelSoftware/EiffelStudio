indexing
	description: "general format of commands for CASE_W";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	CASE_COMMAND2

inherit
	COMMAND

	WINDOWS

feature
	
	make (w: CASE_INTERFACE) is
		do
			case_window := w
		end

	case_window : CASE_INTERFACE

end -- class CASE_COMMAND2
