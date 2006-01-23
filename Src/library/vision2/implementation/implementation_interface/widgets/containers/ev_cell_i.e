indexing
	description: 
		"EiffelVision cell. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CELL_I

inherit
	EV_CONTAINER_I
		redefine
			interface
		end
	
	EV_DOCKABLE_TARGET_I
		redefine
			interface
		end

feature -- Element change

	extend (an_item: like item) is
			-- Ensure that structure includes `an_item'.
		do	
			replace (an_item)
		end
		
feature {EV_ANY_I} -- Implementation

	interface: EV_CELL;

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




end -- class EV_CELL

