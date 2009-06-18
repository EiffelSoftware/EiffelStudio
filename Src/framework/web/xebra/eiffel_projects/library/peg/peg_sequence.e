note
	description: "Summary description for {SEQUENCE}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_SEQUENCE

inherit
	PEG_COMPOSITE
		redefine
			add
		end

create
	make

feature -- Implementation

	parse (a_string: STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			l_parse_result : PEG_PARSER_RESULT
			l_i: INTEGER
		do
			create Result.make (a_string, True, a_string)
			create l_parse_result.make (a_string, True, a_string)
			from
				l_i := 1
			until
				l_i > children.count or not l_parse_result.success
			loop
				l_parse_result := children [l_i].parse (l_parse_result.left_to_parse)
				Result.append_results (l_parse_result.internal_result)
				Result.left_to_parse := l_parse_result.left_to_parse
				l_i := l_i + 1
			end

			if l_parse_result.success then
				Result := build_result (Result)
			else
				create Result.make (a_string, False, a_string)
			end
		end

	add alias "+" (other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
		do
			children.extend(other)
			Result := Current
		end

	serialization_separator: STRING
		do
			Result := " "
		end
end
