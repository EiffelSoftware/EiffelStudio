indexing
	description: "This class stores information deliverd%
					 %with notifactions to header controls"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	WEL_HD_NOTIFY

inherit
	WEL_STRUCTURE
	WEL_BIT_OPERATIONS

creation
	make,
	make_by_pointer,
	make_by_nmhdr

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR) is
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	nmhdr: WEL_NMHDR is
			-- Specifies a NMHDR structure. 
			-- The code member of this object identifies the notification 
			-- message being sent.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_hd_notify_get_hdr (item))
		end

	item_index: INTEGER is
			-- Specifies the index of item associated with notification. 			
		require
			exists: exists
		do
			Result := cwel_hd_notify_get_i_item (item)
		end
	button_index: INTEGER is
			-- Specifies the index of the mouse button involved in 
			-- generating the notification message. 
			-- This member can be one of these values: 
			--
			-- Value			Meaning 
			-- 0				Left button 
			-- 1				Right button 
			-- 2				Middle button 
		require
			exists: exists
		do
			Result := cwel_hd_notify_get_i_button (item)
		end

	header_item: WEL_HD_ITEM is
			-- a WEL_HD_ITEM object that contains information about 
			-- the header item associated with the notification message. 
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_hd_notify_get_p_item (item))
		end
		
feature -- Element change

	set_item_index (value: INTEGER) is
			-- Sets the index of item associated with notification. 			
			-- (Usually set by the OS)
		require
			exists: exists
		do
			cwel_hd_notify_set_i_item (item, value)
		end

	set_button_index (value: INTEGER) is
			-- Sets the index of the mouse button involved in 
			-- generating the notification message. 
			-- This member can be one of these values: 
			--
			-- Value			Meaning 
			-- 0				Left button 
			-- 1				Right button 
			-- 2				Middle button 
			-- (Usually set by the OS)
		require
			exists: exists
			good_value: value >= 0 and value <= 2
		do
			cwel_hd_notify_set_i_button (item, value)
		end

	set_header_item (hd_item: WEL_HD_ITEM) is
			-- Sets the WEL_HD_ITEM object that contains information about 
			-- the header item associated with the notification message. 
			-- (Usually set by the OS)
		require
			exists: exists
			hd_item_exists: hd_item /= Void and then hd_item.exists
		do
			cwel_hd_notify_set_p_item (item, hd_item.item)
		end
				
		
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_hd_notify
		end

feature {NONE} -- Externals

	c_size_of_hd_notify: INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (HD_NOTIFY)"
		end

	cwel_hd_notify_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*): EIF_POINTER"
		end

	cwel_hd_notify_get_i_item (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*): EIF_INTEGER"
		end

	cwel_hd_notify_set_i_item (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*, int)"
		end

	cwel_hd_notify_get_i_button (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*): EIF_INTEGER"
		end

	cwel_hd_notify_set_i_button (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*, UINT)"
		end

	cwel_hd_notify_get_p_item (ptr: POINTER): POINTER is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*): EIF_INTEGER"
		end

	cwel_hd_notify_set_p_item (ptr: POINTER; value: POINTER) is
		external
			"C [macro %"hd_notify.h%"] (HD_NOTIFY*, HD_ITEM FAR*)"
		end

end -- class WEL_HD_NOTIFY


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

