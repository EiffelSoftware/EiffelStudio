indexing
	description: "External methods for class MT_OBJECT_REL_STREAM."

class 
	MT_OBJECT_REL_STREAM_EXTERNAL

feature {NONE}

	c_open_relationships_stream (sid: INTEGER): POINTER is
		external 
			"C"
		end

end -- class MT_OBJECT_REL_STREAM_EXTERNAL
