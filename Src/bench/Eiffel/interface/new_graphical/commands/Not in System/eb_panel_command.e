indexing
	description: "Command associated with a panel"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_PANEL_COMMAND

inherit
	EV_COMMAND

feature -- Initialization

	make (a_panel: EB_ENTRY_PANEL) is
			-- Initialize

		require
			a_panel_not_void: a_panel /= Void
		do
			panel := a_panel
		ensure
			panel exists: panel /= Void
		end

feature -- Access

	panel: EB_ENTRY_PANEL
			-- The associated panel

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class EB_PANEL_COMMAND
