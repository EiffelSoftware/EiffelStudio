indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		MSWindows implementation.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_IMP
	
inherit
	
	EV_DRAWING_AREA_IMP
		rename
			set_item as wel_set_item,
			interface as drawing_area_interface
		end
	
	EV_GRID_I
		redefine
			interface
		select
			interface
		end
		
create
	make

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID

end

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
