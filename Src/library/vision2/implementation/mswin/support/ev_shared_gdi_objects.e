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

