indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLE_SPLIT_AREA_DOCKABLE_DIALOG
	
inherit
	EV_DOCKABLE_DIALOG

feature -- Access

	enable_closeable is
			--
		do
			implementation.enable_closeable
		end
		

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

end -- class MULTIPLE_SPLIT_AREA_DOCKABLE_DIALOG
