indexing
	description:
		"Locally extended version of FORMAT_INTEGER"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTENDED_FORMAT_INTEGER inherit

	FORMAT_INTEGER

create

	make, make_from_integer

feature {NONE} -- Initialization

	make_from_integer (n: INTEGER) is
			-- Create formatter whose width equals to the digits of `n'.
		do
			make (digits (n))
		ensure
			width_set: width = digits (n)
		end

feature {NONE} -- Implementation

	digits (n: INTEGER): INTEGER is
			-- Number of digits in `n'
		local
			d: INTEGER
		do
			from
				d := n
			until
				d = 0 or d = 1 or d = -1
			loop
				Result := Result + 1
				d := d // 10
			end
			if n <= 1 then Result := Result + 1 end
		ensure
			positive_result: Result > 0
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




end -- class EXTENDED_FORMAT_INTEGER

