indexing
	description: "Command called when a launched application encounters a breakpoint, or another exception."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_APPLICATION_QUIT_CMD

inherit
	E_CMD
	
	SHARED_APPLICATION_EXECUTION

create
	make

feature -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current' and associate it with `a_manager'.
		do
			debugger_manager := a_manager
		end

feature -- Access

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager that takes care of all debugging operations.

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
			-- Execute `Current'.
		do
			if Application /= Void and then Application.is_running then
				debugger_manager.on_application_quit
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class EB_APPLICATION_QUIT_CMD

