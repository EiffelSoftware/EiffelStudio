indexing
	description: "Records GDI objects used in system to limit their number"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_GDI_OBJECTS

feature

	allocated_pens: EV_GDI_ALLOCATED_PENS is
		once
			create Result
		end

	allocated_brushes: EV_GDI_ALLOCATED_BRUSHES is
		once
			create Result
		end

end -- class EV_SHARED_GDI_OBJECTS

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

