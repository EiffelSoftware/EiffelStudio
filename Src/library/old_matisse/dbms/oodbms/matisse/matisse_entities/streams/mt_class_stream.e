class MT_CLASS_STREAM 

inherit 

	MT_STREAM

	MT_CLASS_STREAM_EXTERNAL

Creation {MT_CLASS,DB_PROC_MAT} 

	make

feature {NONE} -- Implementation

	make(class_id : INTEGER) is
		-- Open Stream
		do
			sid := c_open_class_stream(class_id)
		end -- make

feature -- Access

	next_object : MT_OBJECT is
		local
			noid : INTEGER
		do
			noid := c_next_object(sid) 
			!!Result.make(noid)
		end -- next object

end -- class MT_CLASS_STREAM


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

