indexing
	description: "External methods for class MT_CREATE_OBJECT."

class 
	MT_CREATE_OBJECT_EXTERNAL 

feature {NONE} -- Implementation

    c_create_object (name: POINTER): INTEGER is
		external
			"C"
		end

end -- class MT_CREATE_OBJECT_EXTERNAL
