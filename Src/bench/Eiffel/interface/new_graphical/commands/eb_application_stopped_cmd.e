indexing
	description: "Command called when a launched application encounters a breakpoint or an exception."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_APPLICATION_STOPPED_CMD

inherit
	E_CMD

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
			debugger_manager.on_application_just_stopped
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class EB_APPLICATION_STOPPED_CMD
