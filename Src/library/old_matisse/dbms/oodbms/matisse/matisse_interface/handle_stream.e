class HANDLE_STREAM 

feature -- Implementation

	Last_stream : CELL[MT_STREAM] is
		-- Current opened stream
		once 
			!!Result.put(Void)
		end -- Last_stream

	Last_object : CELL[DB_DATA] is
		-- Last object read
		once 
			!!Result.put(Void)
		end -- Last_object

end -- class HANDLE_STREAM

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

