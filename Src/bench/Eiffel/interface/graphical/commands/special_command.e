indexing

	description:	
		"Command to show the version number of ebench.";
	date: "$Date$";
	revision: "$Revision$"

class SPECIAL_COMMAND 

inherit

	SYSTEM_CONSTANTS
	PIXMAP_COMMAND

creation

	make

feature -- Initialization

	make (t_w: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (t_w);
		end;
	
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Default 
		end;
 
	name: STRING is
			-- Name of the command.
		once
			Result := "ISE Eiffel 4 (v";
			Result.append (Version_number);
			Result.extend (')');
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Useless here.
		do
			-- Do nothing
		end;

end -- class SPECIAL_COMMAND
