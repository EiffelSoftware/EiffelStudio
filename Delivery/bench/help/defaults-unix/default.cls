indexing
	description: "Objects that ..."
	author: ""
	date: "$Date: $"
	revision: "$Revision: $"

class
	$classname

inherit
	ENTER_CLASS_HERE_IF_NEEDED
		rename
		export
		undefine
		redefine
		select
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize
		do
			-- Your instructions here
		ensure
			postcondition_clause: -- Your postcondition here
		end

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class $classname
