deferred class 
	MT_IRELATIONSHIP_STREAM 

inherit 
	MT_STREAM

	MT_IRELATIONSHIP_STREAM_EXTERNAL

feature {RELATIONSHIP} -- Implementation

	make (one_object: MT_OBJECT; one_relationship: MT_RELATIONSHIP) is
			-- Open Stream.
		do
			c_stream := c_open_predecessors_stream (one_object.oid, one_relationship.rid)
		end -- make

end -- class MT_IRELATIONSHIP_STREAM
