note
	description: "Summary description for {SEQUENCE}."
	legal: "See notice at end of class."
	status: "Pre-release"
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

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			l_parse_result : PEG_PARSER_RESULT
			l_i: INTEGER
		do
			create Result.make (a_string, True)
			from
				Result := children.first.parse (a_string)
				l_parse_result := Result
				l_i := 2
			until
				l_i > children.count or not l_parse_result.success
			loop
				l_parse_result := children [l_i].parse (l_parse_result.left_to_parse)
				Result.append_results (l_parse_result)
				Result.left_to_parse := l_parse_result.left_to_parse
				l_i := l_i + 1
			end

			if l_parse_result.success then
				Result := build_result (Result)
			else
				Result.set_success (False)
				Result := fix_result (Result)
			end
		end

	add alias "+" (a_other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
		do
			if fixated then
				Result := Precursor (a_other)
			else
				children.extend(a_other)
				Result := Current
			end
		end

	serialization_separator: STRING
		do
			Result := " "
		end
end
