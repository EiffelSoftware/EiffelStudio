indexing
	description: "MATISSE-Eiffel Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_RELATIONSHIP_STREAM 

inherit 
	MT_STREAM

	MT_RELATIONSHIP_STREAM_EXTERNAL

Creation 
    make, make_from_name

feature  -- Implementation

	make (an_object: MT_OBJECT; a_relationship: MT_RELATIONSHIP) is
			-- Open Stream.
		do
			c_stream := c_open_successors_stream (an_object.oid, a_relationship.rid)
		end

	make_from_name (an_object: MT_OBJECT; relationship_name: STRING) is
		local
			c_name: ANY
		do
			c_name := relationship_name.to_c
			c_stream := c_open_successors_stream_by_name (an_object.oid, $c_name)
		end
	
feature {NONE} -- Implementation

	next_oid: INTEGER
	
end -- class MT_RELATIONSHIP_STREAM
