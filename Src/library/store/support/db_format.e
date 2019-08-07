note
	description: "Different formats of the database"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DB_FORMAT

inherit

	HANDLE_USE

create
	make

feature {NONE} -- Initialization

	make
			-- Create an interface object to format data.
		require
			database_set: is_database_set
		do
			implementation := handle.database.db_format
		end

feature -- Conversion

	boolean_format (object: BOOLEAN): STRING
			-- Converted string of `object' according to the database format
		do
			Result := implementation.boolean_format (object)
		end

	date_format (object: DATE_TIME): STRING
			-- Converted string of `object' according to the database format.
		require
			argument_not_void: object /= Void
		do
			Result := implementation.date_format (object)
		end

	string_format (object: STRING): STRING
			-- Converted string of `object' according to the database format.
		obsolete
			"Use `string_format_32' instead [2017-05-31]."
		require
			argument_not_void: object /= Void
		do
			Result := string_format_32 (object.as_string_8).as_string_8
		end

	string_format_32 (object: READABLE_STRING_GENERAL): STRING_32
			-- Converted string of `object' according to the database format.
		require
			argument_not_void: object /= Void
		do
			Result := implementation.string_format_32 (object)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_FORMAT [DATABASE];

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_FORMAT



