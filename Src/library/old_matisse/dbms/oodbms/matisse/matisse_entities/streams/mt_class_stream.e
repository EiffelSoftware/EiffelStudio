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

