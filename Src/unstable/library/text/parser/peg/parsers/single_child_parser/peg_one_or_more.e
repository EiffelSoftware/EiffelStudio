note
	description: "[
		The PEG parser which parses with its child one or more time. Also known as '*'.
		It can be created with the prefix operator '+'.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_ONE_OR_MORE

inherit
	PEG_SINGLE_CHILD

create
	make

feature -- Implementation

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			temp: PEG_PARSER_RESULT
			l_list: LIST [ANY]
		do
			temp := child.parse (a_string)
			if temp.success then
				from
					Result := temp
				until
					not temp.success
				loop
					temp := child.parse (temp.left_to_parse)
					if (temp.success) then
						Result.left_to_parse := temp.left_to_parse
						Result.append_results (temp)
					end
				end
				Result := build_result (Result)
			else
				create Result.make (a_string, False)
				Result := fix_result (Result)
			end
		end

	default_parse_info: READABLE_STRING_8
			-- <Precursor>	
		do
			Result := "one_or_more (" + child.short_debug_info + ")"
		end

	short_debug_info: READABLE_STRING_8
			-- <Precursor>		
		do
			Result := "one_or_more"
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): READABLE_STRING_8
			-- <Precursor>
		do
			if not already_serialized (a_already_visited, Current) then
				Result := "(" + child.internal_serialize (a_already_visited) + ")+"
			else
				Result := "recursion"
			end
		end
end
