indexing

	description:	
		"Command with an associated icon.";
	date: "$Date$";
	revision: "$Revision$"

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
		end;
	SHARED_PIXMAPS;
	LICENCED_COMMAND
		rename
			parent_window as Project_tool
		end;
	SHARED_ACCELERATOR
	FOCUSABLE

feature {NONE} -- Implementation

	init (a_composite: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize a command with the `symbol' icon,
			-- in the composite `a_composite'.
			-- `a_text_window' is passed as argument to the activation action
		require
			a_text_window_not_void: a_text_window /= Void
		do
			pict_create (new_name, a_composite);
			set_symbol (symbol);
			initialize_focus;
			add_activate_action (Current, a_text_window);
			text_window := a_text_window
		ensure
			parent = a_composite
		end;
	
feature -- Access

	focus_source: WIDGET is
			-- Widget representing
			-- Current on the screen
		do
			Result := Current;
		end;

	focus_string: STRING is
			-- String to be associated
			-- with Current when it is
			-- in focus
		do
			Result := name;
		end;

feature -- Status Setting

	darken (b: BOOLEAN) is
			-- Darken the symbol of current button if `b', lighten it otherwize
		do
			if b then
				set_symbol (dark_symbol)
			else
				set_symbol (symbol)
			end
		end;

feature -- Properties

	text_window: TEXT_WINDOW;
			-- Text window which staus tells if we want to execute 
			-- or not, and usually the target of the command

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

feature {TEXT_WINDOW} -- Restricted Properties

	name: STRING is
			-- Name of the command.
		deferred
		end;

feature -- Execute

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into
			-- watch shape.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			execute_licenced (argument)
		end;
	
feature {NONE} -- Implementation

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

invariant

	text_window_not_void: text_window /= Void

end -- class ICONED_COMMAND
