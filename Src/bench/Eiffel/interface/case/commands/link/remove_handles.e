indexing

	description: 
		"Command that removes handles of edited relation.";
	date: "$Date$";
	revision: "$Revision $"

class 
	REMOVE_HANDLES

inherit

	--EC_LICENCED_COMMAND
	--	select
	--		execute_licensed
	--	end

	--EDITOR_WINDOW_COM
	--	undefine
	--		work

	EC_EDITOR_WINDOW_COM
		redefine
			editor_window
		end;

creation
	make

feature -- Properties

	editor_window: EC_RELATION_WINDOW;
			-- Associated relation window

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		once
			Result := Pixmaps.remove_handles_pixmap
		end;

feature -- Exection

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Remove handles from relation being edited
			-- editor_window.
		local
			remove_handles: REMOVE_HANDLES_U
		do
			if editor_window.entity /= Void then
				!! remove_handles.make (editor_window.entity)
			end
		end

end -- class REMOVE_HANDLES
