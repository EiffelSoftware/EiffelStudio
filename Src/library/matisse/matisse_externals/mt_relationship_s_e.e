indexing
	description: "External methods for class MT_RELATIONSHIP_STREAM."
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MT_RELATIONSHIP_STREAM_EXTERNAL

feature {NONE}

	c_open_successors_stream (oid, rid: INTEGER): INTEGER is
		external
			"C"
		end

	c_open_successors_stream_by_name (oid: INTEGER; rel_name: POINTER): INTEGER is
		external
			"C"
		end
	
end -- class MT_RELATIONSHIP_STREAM_EXTERNAL
