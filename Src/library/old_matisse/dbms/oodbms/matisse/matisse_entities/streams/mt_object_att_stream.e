class MT_OBJECT_ATT_STREAM

inherit 

	MT_STREAM

	MT_OBJECT_ATT_STREAM_EXTERNAL

Creation 

	make

feature -- Access

	next_object : MT_ATTRIBUTE is
		-- Get Next object in stream
		local
			noid : INTEGER
		do
			noid := c_next_property(sid) 
			!!Result.make_from_id(noid)
		end -- next object

feature {RELATIONSHIP} -- Implementation

	make(one_object : MT_OBJECT) is
		-- Open Stream
		do
			sid := c_open_object_att_stream(one_object.oid)
		end -- make

end -- class MT_OBJECT_ATT_STREAM
