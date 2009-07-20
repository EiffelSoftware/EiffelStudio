note
	description: "Summary description for {CHOICE}."
	legal: "See notice at end of class."
	status: "Pre-release"
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

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			parse_result : PEG_PARSER_RESULT
			l_i: INTEGER
		do
			from
				parse_result := children.first.parse (a_string)
				l_i := 2
			until
				l_i > children.count or parse_result.success
			loop
				parse_result := children [l_i].parse (a_string)
				l_i := l_i + 1
			end

			if parse_result.success then
				Result := build_result (parse_result)
			else
				Result := fix_result (parse_result)
			end
		end

	add_choice alias "|" (a_other: PEG_ABSTRACT_PEG): PEG_CHOICE
			-- <Precursor>
		do
			if fixated then
				Result := Precursor (a_other)
			else
				children.extend(a_other)
				Result := Current
			end
		end

	serialization_separator: STRING
			-- <Precursor>
		do
			Result := " | "
		end

end
