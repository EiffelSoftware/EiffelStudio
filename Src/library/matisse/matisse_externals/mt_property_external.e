indexing
	description: "external methods for class MT_PROPERTY."

class 
	MT_PROPERTY_EXTERNAL 

feature {NONE} -- Implementation MT_PROPERTY

    c_check_property (pid, oid: INTEGER): BOOLEAN is
      	  -- Use MtCheckProperty.
		external
			"C"
		end

end -- class MT_PROPERTY_EXTERNAL
