indexing
	description: "Objects that provide global access to the updating of the projects modified status."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GLOBAL_STATUS
	
inherit
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end

feature -- Access

	is_blocked: BOOLEAN is
			-- Is `Current' blocked? If so, all further calls to `mark_project_as_modified' or
			-- `unmark_project_as_modified' have no effect.
		do
			Result := blocked_cell.item
		end

feature -- Status setting

	block is
			-- Block all further changes to status until `resume' is called.
		do
			blocked_cell.put (True)
		ensure
			is_blocked: is_blocked
		end
		
	resume is
			-- Resume changes to status (undo a call to `block')
		do
			blocked_cell.put (False)
		ensure
			not_is_blocked: not is_blocked
		end

	mark_as_dirty is
			-- If not `is_blocked' then mark project as modified.
		do
			if not is_blocked then
				system_status.enable_project_modified
				command_handler.update	
				main_window.update_title
			end
		end
		
	mark_as_clean is
			-- If not `is_blocked' then mark project as unmodified.
		do
			if not is_blocked then
				system_status.disable_project_modified
				command_handler.update	
				main_window.update_title
			end
		end

feature {NONE} -- Implementation

	blocked_cell: CELL [BOOLEAN] is
			-- Internal once implementation for `is_blocked'.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

end -- class GB_GLOBAL_STATUS
