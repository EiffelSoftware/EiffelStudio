indexing
	description: "Default color palette. This palette consists of the %
		%static colors in the system palette."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEFAULT_PALETTE

inherit
	WEL_PALETTE
		rename
			make as palette_make
		end

	WEL_GDI_STOCK

creation
	make

feature {NONE} -- Implementation

	stock_id: INTEGER is
			-- GDI stock object identifier
		once
			Result := Default_palette
		end

end -- class WEL_DEFAULT_PALETTE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
