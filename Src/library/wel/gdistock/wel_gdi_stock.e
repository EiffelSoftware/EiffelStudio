indexing
	description: "System-predefined GDI object."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_GDI_STOCK

inherit
	WEL_GDI_ANY

	WEL_STOCK_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Make a gdi stock object identified by `stock_id'.
		do
			item := cwin_get_stock_object (stock_id)
			shared := True
			debug ("GDI_COUNT")
				increase_gdi_objects_count
			end
		ensure
			exists: exists
			shared: shared
		end

feature {NONE} -- Implementation

	stock_id: INTEGER is
			-- GDI stock object identifier
		deferred
		end

feature {NONE} -- Externals

	cwin_get_stock_object (index: INTEGER): POINTER is
			-- SDK GetStockObject
		external
			"C [macro <wel.h>] (int): EIF_POINTER"
		alias
			"GetStockObject"
		end

end -- class WEL_GDI_STOCK

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

