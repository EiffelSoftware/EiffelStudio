indexing
	description: "external methods for class MT_STREAM."
	date: "$Date$"
	revision: "$Revision$"

class 
	MT_STREAM_EXTERNAL 

feature {NONE} -- Implementation

	c_next_object (sid: INTEGER): INTEGER is
	        -- Use MtNextObject.
		external
			"C"
		end

	c_next_property (sid: INTEGER): INTEGER is
       	 -- Use MtNextProperty.
		external
			"C"
		end

	c_close_stream (sid: INTEGER) is
	        -- Use MtNextObject.
		external
			"C"
		end

end -- class MT_STREAM_EXTERNAL
