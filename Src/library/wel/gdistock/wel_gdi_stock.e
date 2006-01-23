indexing
	description: "System-predefined GDI object."
	legal: "See notice at end of class."
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
			gdi_make
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




end -- class WEL_GDI_STOCK

