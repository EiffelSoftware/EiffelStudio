indexing
	description: 
		"EiffelVision vertical box. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_VERTICAL_BOX_I
	
inherit
	EV_BOX_I
		redefine
			interface
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	pointer_offset: INTEGER is
			-- Offset of mouse pointer coordinate matching orientation, into `Current'.
		do
			Result := internal_screen.pointer_position.y - screen_y		
		end

	docking_dimension_of_current_item: INTEGER is
			-- Dimension of `interface.item' matching orientation of `Current'.
		do
			Result := interface.item.height
		end
		
	docking_dimension_of_current: INTEGER is
			-- Dimension of `Current' matching orientation of `Current'
		do
			Result := height
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_BOX;

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




end -- class EV_VERTICAL_BOX_I

