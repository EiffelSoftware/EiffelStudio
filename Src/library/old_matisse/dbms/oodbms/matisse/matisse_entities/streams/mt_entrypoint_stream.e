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
