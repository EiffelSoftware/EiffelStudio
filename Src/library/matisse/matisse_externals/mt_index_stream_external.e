indexing
	description: "external methods for class MT_INDEX_STREAM"

class 
	MT_INDEX_STREAM_EXTERNAL 

feature {NONE} -- Implementation

	c_open_index_entries_stream_by_name(index_name, class_name: POINTER; direction: INTEGER; 
				c_cit_start_array, c_crit_end_array:POINTER; nb_obj_per_call: INTEGER): INTEGER is
			-- Use Mt_OpenIndexStream.
		external
			"C"
		end
	
	c_open_index_entries_stream(index_oid, class_oid, direction, count: INTEGER; 
				c_cit_start_array, c_crit_end_array: POINTER; nb_obj_per_call: INTEGER): INTEGER is
		external
			"C"
		end

end -- class MT_INDEX_STREAM_EXTERNAL
