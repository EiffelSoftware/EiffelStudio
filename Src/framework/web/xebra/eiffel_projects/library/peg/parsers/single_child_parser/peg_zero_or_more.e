note
	description: "Summary description for {ZERO_OR_MORE}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_ZERO_OR_MORE

inherit
	PEG_SINGLE_CHILD

create
	make

feature -- Implementation

	parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			temp: PEG_PARSER_RESULT
		do
			create temp.make (a_string, True)
			from
				create Result.make (a_string, True)
			until
				not temp.success
			loop
				temp := child.parse (temp.left_to_parse)
				if (temp.success) then
					Result.left_to_parse := temp.left_to_parse
					Result.append_results (temp.internal_result)
				end
			end
			Result := build_result (Result)
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
			-- <Precursor>
		do
			if not already_serialized (a_already_visited, Current) then
				Result := "(" + child.internal_serialize (a_already_visited) + ")*"
			else
				Result := "recursion"
			end
		end
end
