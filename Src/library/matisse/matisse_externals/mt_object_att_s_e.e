indexing
	description: "External methods for class MT_OBJECT_ATT_STREAM."

class 
	MT_OBJECT_ATT_STREAM_EXTERNAL

feature {NONE}

	c_open_attributes_stream (sid: INTEGER): POINTER is
		external
			"C"
		end

end -- class MT_OBJECT_ATT_STREAM_EXTERNAL
