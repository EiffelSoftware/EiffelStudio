note
	description: "[
		{XEL_CONSTANTS_CLASS_ELEMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_CONSTANTS_CLASS_ELEMENT

inherit
	XEL_CLASS_ELEMENT

create
	make_constant

feature -- Initialization

	make_constant
			--
		do
			make ("G_SERVLET_CONSTANTS")
			create constants_table.make (10)
		ensure then
			constants_attached: attached constants_table
		end

feature -- Access

	constants_table: HASH_TABLE [STRING, STRING]
			-- [String, Variable_name]

feature -- Basic Functionality

	compute_var (a_string: STRING): STRING
			-- Cached generation of variables for constant strings
		do
			if attached constants_table [a_string] as l_constant then
				Result := l_constant
			else
				Result := get_unique_identifier
				constants_table.put (Result, a_string)
				add_const_variable_by_name_type (Result, "STRING", "%"" + a_string + "%"")
			end
		ensure
			result_attached: attached Result
		end

end
