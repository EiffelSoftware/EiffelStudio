class DB_FORMAT

inherit

	HANDLE_USE

creation -- Creation procedure

	make

feature -- Initialization

	make is
			-- Create an interface object to format data.
		do
			implementation := handle.database.db_format_i
		end

feature -- Conversion

	boolean_format (object: BOOLEAN): STRING is
			-- Converted string of `object' according to the database format
		do
			Result := implementation.boolean_format (object)
		end

	date_format (object: ABSOLUTE_DATE): STRING is
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

	implementation: DB_FORMAT_I

end -- class DB_FORMAT


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
