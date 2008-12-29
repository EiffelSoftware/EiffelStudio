note
	description: "Objects that provide access to Windows CDDS%
		%constants used with custom draw."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CDDS_CONSTANTS

feature -- Access

	cdds_prepaint: INTEGER = 1
		-- Declared in Windows as CDDS_PREPAINT
		
	cdds_postpaint: INTEGER = 2
		-- Declared in Windows as CDDS_POSTPAINT
		
	cdds_preerase: INTEGER = 3
		-- Declared in Windows as CDDS_PREERASE
		
	cdds_posterase: INTEGER = 4
		-- Declared in Windows as CDDS_POSTERASE
		
	cdds_item: INTEGER = 65536
		-- Declared in Windows as CDDS_ITEM
		
	cdds_itemprepaint: INTEGER = 65537
		-- Declared in Windows as CDDS_ITEMPREPAINT
		
	cdds_itempostpaint: INTEGER = 65638
		-- Declared in Windows as CDDS_ITEMPOSTPAINT
		
	cdds_itempreerase: INTEGER = 65639
		-- Declared in Windows as CDDS_ITEMPREERASE
		
	cdds_item_posterase: INTEGER = 65640
		-- Declared in Windows as CDDS_ITEMPOSTERASE
		
	cdds_subitem: INTEGER = 131072;
		-- Declared in Windows as CDDS_SUBITEM
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CDDS_CONSTANTS

