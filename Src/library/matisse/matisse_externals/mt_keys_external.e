indexing
	description: "External methods for class MT_KEYS."

class 
	MT_KEYS_EXTERNAL 

feature {NONE} -- Implementation Keys management

    c_keys_count: INTEGER is
		external 
			"C"
		end

    c_ith_key (i:INTEGER): INTEGER is
		external 
			"C"
		end

    c_free_keys is
		external 
			"C"
		end

end -- class MT_KEYS_EXTERNAL
