indexing
	description: "Contains information about a message filter %
					 %notification message (for Rich Edit Controls)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MSG_FILTER

inherit
	WEL_STRUCTURE

creation
	make,
	make_from_nmhdr,
	make_by_pointer

feature -- Initialisation

	make_from_nmhdr (nmhdr: WEL_NMHDR) is
		require
			nmhdr_exists: nmhdr /= Void and then nmhdr.exists
		do
			make_by_pointer (nmhdr.item)
		ensure
			exists: exists
		end

feature -- Access

	msg: INTEGER is
			-- Specifies the keyboard or mouse message identifier. 
		require
			exists: exists
		do
			Result := cwel_msg_filter_get_msg (item)
		end
		
	wparam: INTEGER is
				-- Specifies the wParam parameter of the message. 
		require
			exists: exists
		do
			Result := cwel_msg_filter_get_wparam (item)
		end

	lparam: INTEGER is
			-- Specifies the lParam parameter of the message. 
		require
			exists: exists
		do
			Result := cwel_msg_filter_get_lparam (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_msgfilter
		end

feature {NONE} -- Externals

	c_size_of_msgfilter: INTEGER is
		external
			"C [macro <msgfilter.h>]"
		alias
			"sizeof (MSGFILTER)"
		end

	cwel_msg_filter_get_msg (ptr: POINTER): INTEGER is
		external
			"C [macro <msgfilter.h>] (MSGFILTER*): EIF_INTEGER"
		end

	cwel_msg_filter_get_wparam (ptr: POINTER): INTEGER is
		external
			"C [macro <msgfilter.h>] (MSGFILTER*): EIF_INTEGER"
		end

	cwel_msg_filter_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro <msgfilter.h>] (MSGFILTER*): EIF_INTEGER"
		end

end -- class WEL_MSG_FILTER


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

