indexing
	description: "Objects that provide access to Windows CDDS%
		%constants used with custom draw."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CDDS_CONSTANTS

feature -- Access

	cdds_prepaint: INTEGER is 1
		-- Declared in Windows as CDDS_PREPAINT
		
	cdds_postpaint: INTEGER is 2
		-- Declared in Windows as CDDS_POSTPAINT
		
	cdds_preerase: INTEGER is 3
		-- Declared in Windows as CDDS_PREERASE
		
	cdds_posterase: INTEGER is 4
		-- Declared in Windows as CDDS_POSTERASE
		
	cdds_item: INTEGER is 65536
		-- Declared in Windows as CDDS_ITEM
		
	cdds_itemprepaint: INTEGER is 65537
		-- Declared in Windows as CDDS_ITEMPREPAINT
		
	cdds_itempostpaint: INTEGER is 65638
		-- Declared in Windows as CDDS_ITEMPOSTPAINT
		
	cdds_itempreerase: INTEGER is 65639
		-- Declared in Windows as CDDS_ITEMPREERASE
		
	cdds_item_posterase: INTEGER is 65640
		-- Declared in Windows as CDDS_ITEMPOSTERASE
		
	cdds_subitem: INTEGER is 131072
		-- Declared in Windows as CDDS_SUBITEM
	
end -- class WEL_CDDS_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
