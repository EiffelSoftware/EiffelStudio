indexing
	description: "MATISSE-Eiffel Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_INFO 

inherit
    MT_INFO_EXTERNAL
		
feature -- Status Report

	max_buffered_objects: INTEGER is
			-- The maximum number of objects that can be passed as a parameter
			-- to the C functions Mt(_)CreateNumObjects, MtLoad(Num)Objects, MtLock(Num)Objects.
		do
			Result := c_max_buffered_objects
		end

    max_index_criteria_number: INTEGER is
        	-- The maximum number of criteria that can define an index.
    	do
   		     Result := c_max_index_criteria_number
		end

   	 max_index_key_length: INTEGER is
			-- The maximum size of an index key to be returned.
		do
    		    Result := c_max_index_key_length
		end

	total_read_bytes: INTEGER is
			-- Number of bytes read since beginning of transaction.
		do
			Result := c_get_num_data_bytes_received
		end

	total_write_bytes: INTEGER is
			-- Number of bytes written since beginning of transaction.
		do
			Result := c_get_num_data_bytes_sent
		end

end -- class MT_INFO
