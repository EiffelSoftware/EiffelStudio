indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class DB_FORMAT_I

feature -- Conversion

	boolean_format (object: BOOLEAN): STRING is
			-- Converted string of `object' according to handle format	
		deferred
		end

	date_format (object: ABSOLUTE_DATE): STRING is
			-- Converted string of `object' according to handle format	
		require
			object_not_void: object /= Void
		deferred
		end

	string_format (object: STRING): STRING is
			-- Converted string of `object' according to handle format	
		require
			object_not_void: object /= Void
		deferred
		end

end -- class DB_FORMAT_I


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
