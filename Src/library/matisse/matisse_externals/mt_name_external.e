indexing
	description: "External methods for class MT_NAME."

class 
	MT_NAME_EXTERNAL 

feature {NONE} -- Implementation

	c_object_mt_name (oid: INTEGER): POINTER is
			-- Get a string of attribute "Mt Name" for the object oid.
		external 
			"C"
		end

end -- class MT_NAME_EXTERNAL
