note
	description: "Summary description for {CONSUMED_GENERIC_PARAMETERS_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_GENERIC_PARAMETERS_INFO

create
	make

feature	{NONE} -- Initialization

	make (a_generic_parameters: ARRAY [READABLE_STRING_32]; args_count: INTEGER; with_return_type: BOOLEAN)
		do
			generic_parameters := a_generic_parameters
			arguments_count := args_count
			create internal_data.make (0, args_count)
		end

feature -- Status report

	has_generic: BOOLEAN
		do
			Result := generic_return_type_info /= Void or generic_arguments_count > 0
		end

	is_generic_argument (i: INTEGER): BOOLEAN
		do
			Result := internal_data [i] /= Void
		end

feature -- Access / arguments

	generic_parameters: ARRAY [READABLE_STRING_32]

	arguments_count: INTEGER

	generic_arguments_count: INTEGER

feature -- Access / return type	

	generic_return_type_info: like generic_argument_info
		do
			Result := generic_argument_info (0)
		end

	generic_argument_info (a_index: INTEGER): detachable TUPLE [typename, formal_typename: READABLE_STRING_8; formal_position: INTEGER]
			-- Info related to argument at `a_index`.
			-- if `a_index` is 0, then return info about the return type parameter.
		do
			Result := internal_data [a_index]
		end

feature -- Element change

	set_generic_return_type (a_type_name: READABLE_STRING_8; a_formal_type_name: READABLE_STRING_8; a_formal_position: INTEGER)
		do
			internal_data [0] := [a_type_name, a_formal_type_name, a_formal_position]
		end

	set_generic_argument_type (a_type_name: READABLE_STRING_8; a_formal_type_name: READABLE_STRING_8; a_formal_position: INTEGER; a_arg_index: INTEGER)
		do
			if internal_data [a_arg_index] = Void then
				generic_arguments_count := generic_arguments_count + 1
			end
			internal_data [a_arg_index] := [a_type_name, a_formal_type_name, a_formal_position]
		end

feature {NONE} -- Internal		

	internal_data: ARRAY [like generic_argument_info]

invariant
	internal_data /= Void

end
