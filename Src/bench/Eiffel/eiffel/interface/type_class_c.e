indexing
	description: "Representation for TYPE [G] class"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CLASS_C 

inherit
	CLASS_C
		redefine
			check_validity
		end
		
	SPECIAL_CONST
		export
			{NONE} all
		end

create
	make
	
feature 

	check_validity is
			-- Check validity of class TYPE
		local
			special_error: SPECIAL_ERROR
		do
				-- First check if current class has one formal generic parameter
			if (generics = Void) or else generics.count /= 1 then
				create special_error.make (array_case_1, Current)
				Error_handler.insert_error (special_error)
			end
		end

end
