indexing

	description:	
		"Command with an associated icon.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PIXMAP_COMMAND

inherit

	TOOL_COMMAND
		redefine
			execute
		end;
	NAMER;
	LICENCED_COMMAND
		rename
			parent_window as Project_tool
		end;
	SHARED_ACCELERATOR

feature -- Callbacks

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Useless here.
		do
		end

feature -- Properties

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

	grey_symbol: PIXMAP is
			-- Insensitive version of `symbol'.
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
		do
			if is_sensitive then
				focus_label.popdown;
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

invariant

	text_window_not_void: text_window /= Void

end -- class PIXMAP_COMMAND
