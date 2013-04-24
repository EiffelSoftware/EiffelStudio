note
	description: "Bit operations on integer (or, and not)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BIT_OPERATIONS

feature -- Basic operations

	set_flag (flags, mask: INTEGER): INTEGER
			-- Set the `mask' in `flags'
		do
			Result := flags | mask
		ensure
			flag_set: flag_set (Result, mask)
		end

	clear_flag (flags, mask: INTEGER): INTEGER
			-- Clear the `mask' in `flags'
		do
			Result := flags & mask.bit_not
		ensure
			flag_unset: not flag_set (Result, mask)
		end

feature -- Status report

	flag_set (flags, mask: INTEGER): BOOLEAN
			-- Is `mask' set in `flags'?
		do
			Result := (flags & mask) = mask
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_BIT_OPERATIONS

