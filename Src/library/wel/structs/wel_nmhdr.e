indexing
	description: "Contains information about a notification %
		%message (Wm_notify)."
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

end -- class WEL_NMHDR

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

