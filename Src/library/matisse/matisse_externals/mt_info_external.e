indexing
	description: "External methods for class MT_INFO."

class 
	MT_INFO_EXTERNAL 

feature {NONE} -- Implementation MT_INFO

	c_max_buffered_objects: INTEGER is
			-- Use GetConfigurationInfo.
		external 
			"C"
		end
	
	c_max_index_criteria_number: INTEGER is
			-- Use GetConfigurationInfo.
		external 
			"C"
		end

	c_max_index_key_length: INTEGER is
			-- Use GetConfigurationInfo.
		external 
			"C"
		end

	c_get_num_data_bytes_received: INTEGER is
			-- Use GetTotalReadBytes.
		external 
			"C"
		end

	c_get_num_data_bytes_sent: INTEGER is
			-- Use GetTotalWriteBytes.
		external 
			"C"
		end

end -- class MT_INFO_EXTERNAL
