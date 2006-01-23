indexing
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

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer

feature -- Access

	window_from: WEL_WINDOW is
			-- Control sending message
		do
			Result := window_of_item (cwel_nmhdr_get_hwndfrom (item))
		end

	id_from: INTEGER is
			-- Identifier of control sending message
		do
			Result := cwel_nmhdr_get_idfrom (item)
		end

	code: INTEGER is
			-- Notification code
		do
			Result := cwel_nmhdr_get_code (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nmhdr
		end

feature {NONE} -- Externals

	c_size_of_nmhdr: INTEGER is
		external
			"C [macro <nmhdr.h>]"
		alias
			"sizeof (NMHDR)"
		end

	cwel_nmhdr_get_hwndfrom (ptr: POINTER): POINTER is
		external
			"C [macro <nmhdr.h>] (NMHDR*): EIF_POINTER"
		end

	cwel_nmhdr_get_idfrom (ptr: POINTER): INTEGER is
		external
			"C [macro <nmhdr.h>]"
		end

	cwel_nmhdr_get_code (ptr: POINTER): INTEGER is
		external
			"C [macro <nmhdr.h>]"
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




end -- class WEL_NMHDR

