indexing
	description: "Interface for editor related cursors"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
    EDITOR_CURSORS

feature -- Cursor

	cur_cut_selection: EV_CURSOR is
			-- Editor cut cursor icon
		deferred
		ensure
			result_not_void: Result /= Void
		end

	cur_copy_selection: EV_CURSOR is
			-- Editor copy cursor icon
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
end -- class EDITOR_CURSORS
