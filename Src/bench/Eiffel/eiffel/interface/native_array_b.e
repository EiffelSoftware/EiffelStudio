indexing
	description: "Compiled class NATIVE_ARRAY"
	date: "$Date$"
	revision: "$Revision$"

class NATIVE_ARRAY_B

inherit
	CLASS_C
		redefine
			check_validity, new_type, is_native_array
		end
		
creation
	make
	
feature

	check_validity is
			-- Check validity of class SPECIAL.
		do
			Precursor {CLASS_C}
		end
		
	new_type (data: CL_TYPE_I): NATIVE_ARRAY_CLASS_TYPE is
			-- New class type for class SPECIAL
		do
			create Result.make (data)
		end

	is_native_array: BOOLEAN is True
			-- Is the class special ?
	
end -- end of NATIVE_ARRAY_B
