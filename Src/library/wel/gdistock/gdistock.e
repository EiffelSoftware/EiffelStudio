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

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
