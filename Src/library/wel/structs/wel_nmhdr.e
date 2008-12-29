note
	description: "Contains information about a notification %
		%message (Wm_notify)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NMHDR

inherit
	WEL_STRUCTURE

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer

feature -- Access

	window_from: WEL_WINDOW
			-- Control sending message
		local
			l_hwnd, l_null: POINTER
		do
			l_hwnd := cwel_nmhdr_get_hwndfrom (item)
			if l_hwnd /= l_null then
				Result := window_of_item (l_hwnd)
			end
		end

	id_from: INTEGER
			-- Identifier of control sending message
		do
			Result := cwel_nmhdr_get_idfrom (item)
		end

	code: INTEGER
			-- Notification code
		do
			Result := cwel_nmhdr_get_code (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nmhdr
		end

feature {NONE} -- Externals

	c_size_of_nmhdr: INTEGER
		external
			"C [macro <nmhdr.h>]"
		alias
			"sizeof (NMHDR)"
		end

	cwel_nmhdr_get_hwndfrom (ptr: POINTER): POINTER
		external
			"C [macro <nmhdr.h>] (NMHDR*): EIF_POINTER"
		end

	cwel_nmhdr_get_idfrom (ptr: POINTER): INTEGER
		external
			"C [macro <nmhdr.h>]"
		end

	cwel_nmhdr_get_code (ptr: POINTER): INTEGER
		external
			"C [macro <nmhdr.h>]"
		end

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

end
