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

	date_format (object: DATE_TIME): STRING is
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
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
