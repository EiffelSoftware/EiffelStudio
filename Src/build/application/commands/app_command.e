indexing
	description: "Application editor undoable commands."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class APP_COMMAND 

inherit
	EB_UNDOABLE_COMMAND
	
feature -- Access

	redo is
			-- Redo a command
		do
			do_specific_work
		end

	set_for_macro is
		do
			failed := True
		end

feature {NONE} -- Implementation

	failed: BOOLEAN

	application_editor: APP_EDITOR is
			-- Associated application editor
		do
			Result := app_editor
		end

	do_specific_work is
			-- Do work more specific for the command executed.
		deferred
		end

	perform_update_display is
			-- Update the display if the command is not
			-- a macro
		do
			if not failed then
				update_display
			end
		end

	update_display is
			-- Updates the display of the application_editor. 
		deferred
		end

end -- class APP_COMMAND

