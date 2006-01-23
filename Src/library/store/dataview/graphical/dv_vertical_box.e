indexing
	description: "Vertical box for display elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature {EV_ANY, EV_ANY_I} -- Implementation
 	
	implementation: EV_VERTICAL_BOX_I;
			-- Responsible for interaction with the native graphics toolkit.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_VERTICAL_BOX



