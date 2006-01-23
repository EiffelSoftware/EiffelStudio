indexing
	description:
		"Facility to access a standard output medium"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	STANDARD_OUTPUT_FACILITY

feature -- Status report

	has_standard_output: BOOLEAN is
			-- Has a standard output been set?
		do
			Result := (standard_output /= Void)
		end
		
feature -- Status setting

	set_standard_output (o: IO_MEDIUM) is
			-- Set standard output to `o'.
		do
			standard_output := o
		ensure
			medium_set: standard_output = o
		end
		
feature {NONE} -- Implementation

	standard_output: IO_MEDIUM;
			-- Standard output medium

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




end -- class STANDARD_OUTPUT_FACILITY

