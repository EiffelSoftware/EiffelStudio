class MT_INFO 

inherit

	    MT_INFO_EXTERNAL
		
feature -- Status Report

	max_buffered_objects : INTEGER is
		-- The maximum number of objects that can be passed as a parameter
		-- to the C functions Mt(_)CreateNumObjects, MtLoad(Num)Objects, MtLock(Num)Objects
		do
			Result := c_max_buffered_objects
		end -- max_buffered_objects

    	max_index_criteria_number : INTEGER is
        	-- The maximum number of criteria that can define an index
    		do
   		     Result := c_max_index_criteria_number
		end -- max_index_criteria_number

   	 max_index_key_length : INTEGER is
		-- The maximum size of an index key to be returned
		do
    		    Result := c_max_index_key_length
		end -- max_index_key_length

	total_read_bytes : INTEGER is
		-- Number of bytes read since beginning of transaction
		do
			Result := c_get_total_read_bytes
		end -- total_read_bytes

	total_write_bytes : INTEGER is
		-- Number of bytes written since beginning of transaction
		do
			Result := c_get_total_write_bytes
		end -- total_write_bytes

	wait_time : INTEGER is
		-- Wait time for transactions
		do
			Result := c_get_wait_time
		end -- wait_time

end -- class MT_INFO

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

