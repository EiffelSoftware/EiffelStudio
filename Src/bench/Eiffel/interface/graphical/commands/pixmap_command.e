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
	SHARED_PIXMAPS;
	LICENCED_COMMAND
		rename
			parent_window as Project_tool
		end;
	SHARED_ACCELERATOR

feature {NONE} -- Implementation

	init (a_text_window: TEXT_WINDOW) is
			-- Initialize a command with the `symbol' icon,
			-- `a_text_window' is passed as argument to the activation action.
		require
			a_text_window_not_void: a_text_window /= Void
		do
			text_window := a_text_window
		ensure
			text_window_set: equal (text_window, a_text_window)
		end;

feature -- Callbacks

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
		do
		end;

feature -- Properties

	text_window: TEXT_WINDOW;
			-- Text window which staus tells if we want to execute 
			-- or not, and usually the target of the command

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

	dark_symbol: PIXMAP is
			-- Darkened version of `symbol'.
		do
			Result := symbol
		end;

	full_symbol: PIXMAP is
			-- Symbol representing a targeted tool.
		do
			Result := symbol
		end;

	icon_symbol: PIXMAP is	
			-- Symbol used for an iconified tool window.
		do
			Result := symbol
		end;

	holder: HOLDER;
			-- Holder of Current.

	name: STRING is
			-- Name of the command.
		deferred
		end;

	is_sensitive: BOOLEAN is
			-- Can Current be executed?
		do
			Result := holder.is_sensitive
		end;

feature -- Execute

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into
			-- watch shape.
		do
			if is_sensitive then
				if last_warner /= Void then
					last_warner.popdown
				end;
				execute_licenced (argument)
			end
		end;
	
feature -- Setting

	set_holder (fh: like holder) is
			-- Assign `fh' to `holder'.
		do
			holder := fh
		end;

	set_empty_symbol is
		do
			if holder.associated_button.pixmap /= symbol then
				holder.associated_button.set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if holder.associated_button.pixmap /= full_symbol then
				holder.associated_button.set_symbol (full_symbol)
			end
		end

invariant

	text_window_not_void: text_window /= Void

end -- class ICONED_COMMAND
