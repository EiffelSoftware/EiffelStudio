indexing
	description: "Define Variable of type DATE_TIME"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_define_date_time.e $"

class
	OCI_DEFINE_DATE_TIME

inherit
	OCI_DEFINE

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_variable (Sqlt_dat, Date_bytes)
		end

feature -- Access

	Date_bytes: INTEGER is 7

	value: DATE_TIME is
			-- Current value of define variable
		local
			c, y, mo, d, h, mi, s: INTEGER_8
		do
			check
				correct_data_size: data_size = Date_bytes
			end
				-- century
			($c).memory_copy (buffer + 0, 1)
			c := c - 100
				-- year
			($y).memory_copy (buffer + 1, 1)
			y := y - 100
				-- month
			($mo).memory_copy (buffer + 2, 1)
				-- day
			($d).memory_copy (buffer + 3, 1)
				-- hour
			($h).memory_copy (buffer + 4, 1)
			h := h - 1
				-- minute
			($mi).memory_copy (buffer + 5, 1)
			mi := mi - 1
				-- second
			($s).memory_copy (buffer + 6, 1)
			s := s - 1
			create Result.make (c.to_integer_32 * 100 + y, mo, d, h, mi, s)
		end
	
	valid_data_type_and_size (type: INTEGER_16; size: INTEGER): BOOLEAN is
			-- Are `type' and `size' valid values for `data_type' and `data_size' ?
		do
			Result := type = Sqlt_dat and size = Date_bytes
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




end -- class OCI_DEFINE_DATE_TIME
