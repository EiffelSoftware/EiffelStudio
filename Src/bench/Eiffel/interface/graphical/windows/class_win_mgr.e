indexing

	description:	
		"Window manager for class tools.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_WIN_MGR 

inherit

	EDITOR_MGR
		rename
			make as mgr_make
		redefine
			editor_type
		end;
	EDITOR_MGR
		redefine
			editor_type, make
		select
			make
		end;
	EB_CONSTANTS

creation

	make

feature -- Initialization

	make (a_screen: SCREEN; i: INTEGER) is
			-- Initialize Current.
		do
			mgr_make (a_screen, i);
			Class_tool_resources.add_user (Current)
		end

feature -- Access

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			c: CURSOR
		do
			from
				c := active_editors.cursor
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise_shell_popup;
				active_editors.forth
			end
			active_editors.go_to (c)
		end;

feature {NONE} -- Properties

	editor_type: CLASS_W;

end -- class CLASS_WIN_MGR
