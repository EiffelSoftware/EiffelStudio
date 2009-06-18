note
	description: "Summary description for {CHOICE}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_CHOICE

inherit
	PEG_COMPOSITE
		redefine
			add_choice
		end

create
	make

feature -- Implementation

	parse (a_string: STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			parse_result : PEG_PARSER_RESULT
			l_i: INTEGER
		do
			create parse_result.make (a_string, False)
			from
				l_i := 1
			until
				l_i > children.count or parse_result.success
			loop
				parse_result := children [l_i].parse (a_string)
				l_i := l_i + 1
			end

			if parse_result.success then
				create Result.make (parse_result.left_to_parse, True)
				Result.append_results (parse_result.internal_result)
				Result := build_result (Result)
			else
				create Result.make (a_string, False)
			end
		end

	add_choice alias "|" (a_other: PEG_ABSTRACT_PEG): PEG_CHOICE
		do
			children.extend(a_other)
			Result := Current
		end

	serialization_separator: STRING
			-- <Precursor>
		do
			Result := " | "
		end

end
