class MT_INDEX_STREAM 

inherit 

	MT_STREAM
		export {ANY} mtdirect,mtreverse
		end

	MT_INDEX_STREAM_EXTERNAL

Creation 

	make

feature -- Access

	next_object : MT_OBJECT is
		-- Get Next object in stream
		local
			noid : INTEGER
		do
			noid := c_next_object(sid) 
			!!Result.make(noid)
		end -- next object

feature {MT_ENTRYPOINT} -- Implementation

	make(index_name : STRING;one_class : MT_CLASS;direction : INTEGER) is
		-- Open Stream
		require
			index_name_not_void : index_name /= Void
			index_name_not_empty : not index_name.empty
			direction_is_direct_or_reverse : direction = MTDIRECT or else direction = MTREVERSE
		local
			c_index_name,c_class_name : ANY
		do
			c_index_name := index_name.to_c
			c_class_name := one_class.name.to_c
			sid := c_open_index_stream($c_index_name,$c_class_name,direction)
		end -- make

end -- class MT_INDEX_STREAM

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

