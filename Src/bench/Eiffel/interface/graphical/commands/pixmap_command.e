deferred class ICONED_COMMAND 

inherit

	COMMAND_W
		redefine
			execute
		end;
	NAMER;
	PICT_COLOR_B
		rename
			make as pict_create
		end

feature {NONE}

	init (a_composite: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize a command with the `symbol' icon,
			-- in the composite `a_composite'.
			-- `a_text_window' is passed as argument to the activation action
		do
			pict_create (new_name, a_composite);
			set_symbol (symbol);
			!!get_in; !!get_out;
			add_enter_action (Current, get_in);
			add_leave_action (Current, get_out);
			add_button_press_action (1, Current, a_text_window);
			text_window := a_text_window
		ensure
			parent = a_composite
		end;

	get_in, get_out: ANY;
			-- To be used as arguments for callbacks on enter and leave actions
	
feature 

	text_window: TEXT_WINDOW;
			-- Text window which staus tells if we want to execute or not, and usually
			-- the target of the command

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into watch shape.
		do
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			else
				work (argument)
			end
		end;

	
feature {NONE}

	command_name: STRING is deferred end;

	
feature 

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

	
feature {NONE}

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		require
			non_void_arg: p /= Void
		do
			if p.is_valid then
				set_pixmap (p)
			end;
		end;


	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
		do
			Result := symbol
		end;

	
feature 

	darken (b: BOOLEAN) is
			-- Darken the symbol of current button if `b', lighten it otherwize
		do
			if b then
				set_symbol (dark_symbol)
			else
				set_symbol (symbol)
			end
		end;

end
