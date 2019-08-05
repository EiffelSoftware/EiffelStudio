note
	status: "See notice at end of class."
	Date: "$Date: 2011-05-17 02:16:17 +0200 (Tue, 17 May 2011) $"
	Revision: "$Revision: 86464 $"
	Product: EiffelStore
	Database: "All_Bases (At least ODBC)"

deferred class
	PARAMETER_HDL

inherit
	STRING_HDL

feature -- Status report

	is_prepared: BOOLEAN
			-- Is the statement has been prepared ?

	is_executed: BOOLEAN
			-- Is the statement has been executed ?

feature -- Settings

	set_prepared (b: BOOLEAN)
			-- Set `is_prepared' with `b'.
		do
			is_prepared := b
		ensure
			is_prepared_set: is_prepared = b
		end

	set_executed (b: BOOLEAN)
			-- Set `is_executed' with `b'.
		do
			is_executed := b
		ensure
			is_executed_set: is_executed = b
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
