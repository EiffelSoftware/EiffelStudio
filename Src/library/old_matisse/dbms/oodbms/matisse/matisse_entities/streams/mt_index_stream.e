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
