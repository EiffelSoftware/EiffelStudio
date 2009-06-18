note
	description: "Summary description for {ZERO_OR_MORE}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_ONE_OR_MORE

inherit
	PEG_SINGLE_CHILD

create
	make

feature -- Implementation

	parse (a_string: STRING): PEG_PARSER_RESULT
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
						Result.append_results (temp.internal_result)
						l_list := Result.internal_result
						Result := temp
						Result.set_result (l_list)
					end
				end
				Result := build_result (Result)
			else
				create Result.make (a_string, False, a_string)
			end
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "(" + child.serialize + ")+"
		end
end
