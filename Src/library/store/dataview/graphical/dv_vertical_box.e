indexing
	description: "Vertical box for display elements"
	date: "$Date$"
	revision: "$Revision$"

class
	DV_VERTICAL_BOX

inherit
	EV_VERTICAL_BOX
		undefine
			extend
		redefine
			implementation
		end

	DV_BOX
		redefine
			implementation
		end

create
	make,
	make_without_borders

feature -- Basic operations

	extend_separator is
			-- Add a non-expandable separator to end
			-- of structure.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			create sep
			extend (sep)
			disable_item_expand (sep)
		end

feature {EV_ANY_I} -- Implementation
 	
	implementation: EV_VERTICAL_BOX_I;
			-- Responsible for interaction with the native graphics toolkit.

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_VERTICAL_BOX

