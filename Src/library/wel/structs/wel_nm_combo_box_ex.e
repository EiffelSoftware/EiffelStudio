indexing
	description: "Contains information about a combo-box-ex%
			% notification message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_COMBO_BOX_EX

inherit
	WEL_STRUCTURE

create
	make,
	make_by_nmhdr,
	make_by_pointer

feature -- Initialization

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
			create Result.make_by_pointer (cwel_nm_comboboxex_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	comboboxex_item: WEL_COMBO_BOX_EX_ITEM is
			-- Information about the notification-specific action flag.
			-- See class WEL_TVAF_CONSTANTS for the meaning of this parameter.
		local
			combo: WEL_COMBO_BOX_EX
		do
			create Result.make_by_pointer (cwel_nm_comboboxex_get_ceitem (item))
			combo ?= hdr.window_from
			if combo /= Void then
				Result := combo.get_item_info (Result.index)
			end
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_comboboxex
		end

feature {NONE} -- Externals

	c_size_of_nm_comboboxex: INTEGER is
		external
			"C [macro %"nmcomboboxex.h%"]"
		alias
			"sizeof (NMCOMBOBOXEX)"
		end

	cwel_nm_comboboxex_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"nmcomboboxex.h%"] (NMCOMBOBOXEX*): EIF_POINTER"
		end

	cwel_nm_comboboxex_get_ceitem (ptr: POINTER): POINTER is
		external
			"C [macro %"nmcomboboxex.h%"] (NMCOMBOBOXEX*): EIF_POINTER"
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




end -- class WEL_NM_COMBO_BOX_EX

