indexing
	description: "External methods for class MT_CLASS_STREAM."
	
class 
	MT_CLASS_STREAM_EXTERNAL 

feature {NONE} -- Implementation

	c_open_instances_stream (cid: INTEGER): INTEGER is
       	 -- Use Mt_OpenClassStream.
		external 
			"C"
		end

end -- class MT_CLASS_STREAM_EXTERNAL
