indexing

	description:	
		"Command with an associated icon.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ICONED_COMMAND

inherit

	TOOL_COMMAND
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

feature -- Callbacks

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
		do
		end;

feature -- Properties

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

	dark_symbol: PIXMAP is
			-- Darkened version of `symbol'.
		do
			Result := symbol
		end;

	grey_symbol: PIXMAP is
			-- Insensitive version of `symbol'.
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

	holder: EB_HOLDER;
			-- Holder of Current.

	is_sensitive: BOOLEAN is
			-- Can Current be executed?
		do
			Result := holder.is_sensitive
		end;

feature -- Execute

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into
			-- watch shape.
		local
			f: FOCUSABLE
		do
			if is_sensitive then
				if holder /= Void then
					f ?= holder.associated_button
				end;
				if f /= Void then
					f.popdown
				end;
				if last_warner /= Void and then
						not last_warner.destroyed then
					last_warner.popdown
				end;
				execute_licenced (argument);
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
