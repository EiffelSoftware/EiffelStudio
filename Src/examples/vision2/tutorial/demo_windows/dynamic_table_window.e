indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DYNAMIC_TABLE_WINDOW

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
	invariant_clause: -- Your invariant here

end -- class DYNAMIC_TABLE_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

