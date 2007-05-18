indexing
	description: "Contains information about a tab control%
				% keydown notification message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TC_KEYDOWN

inherit
	WEL_STRUCTURE

create
	make,
	make_by_nmhdr,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR) is
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	hdr: WEL_NMHDR is
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_tc_keydown_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	virtual_key: INTEGER is
			-- Virtual key number.
		do
			Result := cwel_tc_keydown_get_wvkey (item)
		end

	key_data: INTEGER is
			-- Data associated with the way to press the key
		do
			Result := cwel_tc_keydown_get_flags (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tc_keydown
		end

feature {NONE} -- Externals

	c_size_of_tc_keydown: INTEGER is
		external
			"C [macro %"tckeydown.h%"]"
		alias
			"sizeof (TC_KEYDOWN)"
		end

	cwel_tc_keydown_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"tckeydown.h%"] (TC_KEYDOWN*): EIF_POINTER"
		end

	cwel_tc_keydown_get_wvkey (ptr: POINTER): INTEGER is
		external
			"C [macro %"tckeydown.h%"]"
		end

	cwel_tc_keydown_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro %"tckeydown.h%"]"
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

end
