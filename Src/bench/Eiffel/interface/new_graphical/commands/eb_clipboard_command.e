indexing
	description	: "Command to perform a clipboard operation (cut, copy or paste)"
	date		: "$Date$"
	revision	: "$Revision $"

deferred class
	EB_CLIPBOARD_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_CLIPBOARD_OBSERVER
		redefine
			on_changed
		end

feature {NONE} -- Implementation

	on_changed is
			-- The undo/redo stack has changed.
		local
			sensitive: BOOLEAN
			operation_possible: BOOLEAN
		do
			sensitive := is_sensitive 
			operation_possible := executable

			if sensitive and (not operation_possible) then
				disable_sensitive
			elseif (not sensitive) and (operation_possible) then
				enable_sensitive
			end
		end

end -- class EB_CLIPBOARD_COMMAND
