indexing
	description: 
		"EiffelVision horizontal box. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_HORIZONTAL_BOX_I
	
inherit
	EV_BOX_I
		redefine
			interface
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	pointer_offset: INTEGER is
			-- Offset of mouse pointer coordinate matching orientation, into `Current'.
		do
			Result := internal_screen.pointer_position.x - screen_x		
		end
		
	docking_dimension_of_current_item: INTEGER is
			-- Dimension of `interface.item' matching orientation of `Current'.
		do
			Result := interface.item.width
		end
		
	docking_dimension_of_current: INTEGER is
			-- Dimension of `Current' matching orientation of `Current'
		do
			Result := width
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_BOX;

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




end -- class EV_HORIZONTAL_BOX_I

