indexing
	description: "general format of commands for CASE_W";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	CASE_COMMAND2

inherit
	COMMAND

feature
	make ( w : CASE_W ) is
	do
		case_window := w
	end

	case_window : CASE_W


end -- class CASE_COMMAND2
