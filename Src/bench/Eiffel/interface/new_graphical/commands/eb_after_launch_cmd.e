indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_AFTER_LAUNCH_CMD

inherit
	E_CMD

create
	make

feature {NONE} -- Initialization

	make (a_dbg_manager: like debug_manager) is
			-- Initialize `Current' and link it with `a_dbg_manager'.
		do
			debug_manager := a_dbg_manager
		end

feature -- Access

	debug_manager: EB_DEBUGGER_MANAGER
			-- Shared debugging facilities.

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	execute is
			-- Command execution.
		do
			debug_manager.on_application_launched
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class EB_AFTER_LAUNCH_CMD
