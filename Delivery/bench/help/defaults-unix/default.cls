indexing
	description: "Objects that ..."
	author: ""
	date: "$Date: 1999/09/07 03:00:42 $"
	revision: "$Revision: 1.4 $"

class
	$classname

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

-- The following Creation_clause can be removed if you need no other
-- procedure than `default_create':

create
	default_create

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
	invariant_clause: True -- Your invariant here

end -- class $classname
