indexing
	description: "Objects that represent the value of a reference coming from the dotnet world ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_REFERENCE_VALUE

inherit
	ABSTRACT_REFERENCE_VALUE


	EIFNET_ABSTRACT_DEBUG_VALUE	
		undefine
			address
		end

feature -- properties

	value_class_token: INTEGER

--	value_module_file_name: STRING

feature -- Access

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		do
		end


	dynamic_class_type: CLASS_TYPE is
		do
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
		end

feature {NONE} -- Output

	type_and_value: STRING is
			-- Return a string representing `Current'.
		do
		end

feature -- Output

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
		end

	once_function_value (a_feat: E_FEATURE): ABSTRACT_DEBUG_VALUE is
		do
		end

end -- class EIFNET_DEBUG_REFERENCE_VALUE

