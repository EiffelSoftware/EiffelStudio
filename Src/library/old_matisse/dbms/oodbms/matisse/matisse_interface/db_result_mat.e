class DB_RESULT_MAT

inherit

	HANDLE_STREAM
		export {NONE} all
		end

	DB_RESULT_I

	MT_STREAM_EXTERNAL

	DB_STATUS_USE

feature -- Status stetting

	fill_in (descriptor_index: INTEGER) is
		-- Load object from stream
		local
			one_object : MT_OBJECT
		do
			if Last_object.item /= Void then 
				data := Last_object.item 
			else 
				data := Last_stream.item.next_object
			end
		end -- fill_in

	update_map_table (object: ANY) is
		-- Do nothing : map_table not used
		do
		end -- update_map_table

feature -- Access

	data : DB_DATA -- Contains current object in stream

	map_table: ARRAY [INTEGER] is
		-- Void object
		do
 		end -- map_table

end -- class DB_RESULT_MAT

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

