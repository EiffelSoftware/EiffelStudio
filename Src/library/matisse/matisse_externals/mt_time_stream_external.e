indexing
	description: "External methods for class MT_TIME_STREAM"
	date: "$Date$"
	revision: "$Revision$"

class 
	MT_TIME_STREAM_EXTERNAL 

feature {NONE} -- Implementation

	c_open_version_stream: INTEGER is
		external
			"C"
		end

	c_next_version (sid: INTEGER) is
			-- Use MtNextTime.
		external
			"C"
		end

	
end -- class MT_TIME_STREAM_EXTERNAL
