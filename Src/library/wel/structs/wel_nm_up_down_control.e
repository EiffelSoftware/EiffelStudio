indexing
	description: "Contains information about an up-down control notification %
		%message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_UP_DOWN_CONTROL

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
			-- Information about the Wm_notify message
		do
			create Result.make_by_pointer (cwel_nm_updown_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	position: INTEGER is
			-- Current position of the up-down control
		do
			Result := cwel_nm_updown_get_ipos (item)
		end

	delta: INTEGER is
			-- Proposed change in the position of the up-down
			-- control
		do
			Result := cwel_nm_updown_get_idelta (item)
		end

feature -- Element change

	set_position (a_position: INTEGER) is
			-- Set `position' with `a_position'.
		do
			cwel_nm_updown_set_ipos (item, a_position)
		ensure
			position_set: position = a_position
		end

	set_delta (a_delta: INTEGER) is
			-- Set `delta' with `a_delta'.
		do
			cwel_nm_updown_set_idelta (item, a_delta)
		ensure
			delta_set: delta = a_delta
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_updown
		end

feature {NONE} -- Externals

	c_size_of_nm_updown: INTEGER is
		external
			"C [macro <nmupdown.h>]"
		alias
			"sizeof (NM_UPDOWN)"
		end

	cwel_nm_updown_set_ipos (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <nmupdown.h>]"
		end

	cwel_nm_updown_set_idelta (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <nmupdown.h>]"
		end

	cwel_nm_updown_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro <nmupdown.h>] (NM_UPDOWN*): EIF_POINTER"
		end

	cwel_nm_updown_get_ipos (ptr: POINTER): INTEGER is
		external
			"C [macro <nmupdown.h>] (NM_UPDOWN*): EIF_POINTER"
		end

	cwel_nm_updown_get_idelta (ptr: POINTER): INTEGER is
		external
			"C [macro <nmupdown.h>] (NM_UPDOWN*): EIF_POINTER"
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




end -- class WEL_NM_UP_DOWN_CONTROL

