indexing
	description: "Different formats of the database"
	date: "$Date$"
	revision: "$Revision$"

class DB_FORMAT

inherit

	HANDLE_USE

creation -- Creation procedure

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

	implementation: DATABASE_FORMAT [DATABASE]

end -- class DB_FORMAT


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

