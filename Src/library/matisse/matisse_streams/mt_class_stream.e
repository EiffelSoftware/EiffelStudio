indexing
	description: "MATISSE-Eiffel Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_CLASS_STREAM 

inherit 
	MT_STREAM

	MT_CLASS_STREAM_EXTERNAL
	
creation {MT_CLASS, DB_PROC_MAT} 
	make

feature {NONE} -- Implementation

	make (class_id: INTEGER) is
			-- Open Stream.
		do
			c_stream := c_open_instances_stream (class_id)
		end -- make


end -- class MT_CLASS_STREAM

