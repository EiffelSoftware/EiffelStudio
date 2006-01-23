indexing
	description: "Different formats of the database"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DB_FORMAT

inherit

	HANDLE_USE

create -- Creation procedure

	make

feature -- Initialization

	make is
			-- Create an interface object to format data.
		do
			implementation := handle.database.db_format
		end

feature -- Conversion

	boolean_format (object: BOOLEAN): STRING is
			-- Converted string of `object' according to the database format
		do
			Result := implementation.boolean_format (object)
		end

	date_format (object: DATE_TIME): STRING is
			-- Converted string of `object' according to the database format.
		require
			argument_not_void: object /= Void
		do
			Result := implementation.date_format (object)
		end

	string_format (object: STRING): STRING is
			-- Converted string of `object' according to the database format.
		require
			argument_not_void: object /= Void
		do
			Result := implementation.string_format (object)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_FORMAT [DATABASE];

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




end -- class DB_FORMAT



