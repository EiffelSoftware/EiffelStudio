indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNDO_COMMAND

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end


feature -- Initialization

feature -- Access

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

	undo	is
		deferred
		end

	redo is
		deferred
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class UNDO_COMMAND
