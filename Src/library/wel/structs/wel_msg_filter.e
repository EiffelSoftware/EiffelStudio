indexing
	description: "Contains information about a message filter %
					 %notification message (for Rich Edit Controls)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MSG_FILTER

inherit
	WEL_STRUCTURE

create
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




end -- class WEL_MSG_FILTER

