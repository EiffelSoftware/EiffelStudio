class MT_ENTRYPOINT_STREAM 

inherit 

	MT_STREAM

	MT_ENTRYPOINT_STREAM_EXTERNAL

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
		end -- next_object

feature {MT_ENTRYPOINT} -- Implementation

	make(ep_name : STRING;one_attribute : MT_ATTRIBUTE;one_class : MT_CLASS) is
		-- Open Stream
		require
			ep_name_not_void : ep_name /= Void
			ep_name_not_empty : not ep_name.empty
		local
			c_ep_name : ANY
		do
			c_ep_name := ep_name.to_c
			sid := c_open_ep_stream($c_ep_name,one_attribute.aid,one_class.cid)
		end -- make

end -- class MT_ENTRYPOINT_STREAM

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

