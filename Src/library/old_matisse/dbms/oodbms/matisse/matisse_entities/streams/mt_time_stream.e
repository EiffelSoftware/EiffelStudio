class MT_TIME_STREAM 

inherit 


	MT_STREAM
		rename next_object as obsolete_next_object    
		export {NONE} obsolete_next_object
		undefine close
		end

	MT_TIME_STREAM_EXTERNAL

Creation {MT_CLASS} 

	make

feature {NONE} -- Implementation

	make is
		-- starts the enumeration of the versions that exist in the database
		do
			sid := c_time_enum_start
		end -- make

	next_time : STRING is
		-- String associated with the next version in the stream
		do
			!!Result.make(255)
			Result.from_c(c_next_time(sid))
		end -- next_time

	close is 
			-- Close the stream of the versions
		do
			c_time_enum_end(sid)
		end -- close

	obsolete_next_object : DB_DATA is
		-- Void object
		do
		end -- obsolete_next_object

end -- class MT_TIME_STREAM

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

