indexing
	description: "External methods for class MT_IRELATIONSHIP_STREAM."
	
class 
	MT_IRELATIONSHIP_STREAM_EXTERNAL 

feature {NONE} -- Implementation

	c_open_predecessors_stream (oid, rid: INTEGER): INTEGER is
			-- Use Mt_OpenIRelStream.
		external 
			"C"
		end

end
