indexing

	description:	
		"Command to do something special.";
	date: "$Date$";
	revision: "$Revision$"

class SPECIAL_COMMAND 

inherit

	SYSTEM_CONSTANTS
	ICONED_COMMAND

creation

	make

feature -- Initialization

	make (c: COMPOSITE; t_w: TEXT_WINDOW) is
			-- Initialize the command.
		do
--			init (c, t_w);
--			!!special_w.make (c);
			pict_create (new_name, c);
			set_symbol (symbol);
			add_enter_action (Current, get_in);
			add_leave_action (Current, get_out);
--			add_button_press_action (1, Current, t_w);
			text_window := t_w
		end;
	
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Default 
		end;
 
	command_name: STRING is
			-- Name of the command.
		once
			Result := "ISE Eiffel 3 (v";
			Result.append (Version_number);
			Result.extend (')');
		end;
	
feature -- Commented properties

--	special_w: SPECIAL_W;

feature {NONE} -- Implementation

	work (argument: ANY) is
		do
--			special_w.call
		end;

end -- class SPECIAL_COMMAND
