note
	description: "Summary description for {C2EIFFEL_INTEGER_ARRAY}."
	date: "$Date$"
	revision: "$Revision$"

class
	C2EIFFEL_ARRAY

feature -- Arrays

feature -- C

	c_int_array (a_count: INTEGER): POINTER
		external
			"C inline use <c2eiffel.h>"
		alias
			"[
				return getIntArray($a_count);
			]"
		end


	c_double_array (a_count: POINTER): POINTER
		external
			"C inline use <c2eiffel.h>"
		alias
			"[
				return getDoubleArray($a_count);
			]"
		end

	c_structure_person_array (a_count: POINTER): POINTER
		external
			"C inline use <c2eiffel.h>"
		alias
			"[
				return getPersonsArray($a_count);
			]"
		end



end
