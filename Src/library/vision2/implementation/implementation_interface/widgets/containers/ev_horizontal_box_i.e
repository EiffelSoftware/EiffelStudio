indexing
	description: 
		"EiffelVision horizontal box. Implementation interface."
	status: "See notice at end of class"
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

	interface: EV_HORIZONTAL_BOX

end -- class EV_HORIZONTAL_BOX_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

