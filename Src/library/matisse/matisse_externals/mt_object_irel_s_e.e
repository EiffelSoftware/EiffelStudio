indexing
	description: "External methods for class MT_OBJECT_IREL_STREAM."

class 
	MT_OBJECT_IREL_STREAM_EXTERNAL

feature {NONE}

	c_open_inverse_relationships_stream (oid: INTEGER): POINTER is
		external
			"C"
		end

end -- class MT_OBJECT_IREL_STREAM_EXTERNAL
