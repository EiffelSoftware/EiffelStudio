note
	description: "[
		{COMPOSITE_PARSER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PEG_COMPOSITE

inherit
	PEG_ABSTRACT_PEG

feature -- Initialization

	make
		do
			create {ARRAYED_LIST [PEG_ABSTRACT_PEG]} children.make (2)
		end

feature {NONE} -- Access

	children: LIST [PEG_ABSTRACT_PEG]
		-- Children parsers

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
			-- <Precursor>
		local
			separator: STRING
		do
			if not already_serialized (a_already_visited, Current) then
				from
					Result := "("
					separator := ""
					children.start
				until
					children.after
				loop
					Result.append (separator)
					Result.append (children.item.internal_serialize (a_already_visited))
					separator := serialization_separator
					children.forth
				end
				Result.append (")")
			else
				Result := "recursion"
			end
		end

	default_parse_info: STRING
			-- <Precursor>
		local
			l_i: INTEGER
			l_sep: STRING
		do
			from
				l_i := 1
				Result := "("
				l_sep := ""
			until
				l_i > children.count
			loop
				Result := Result + l_sep +  children [l_i].short_debug_info
				l_sep := serialization_separator
				l_i := l_i + 1
			end
			Result := Result + ")"
		end

	short_debug_info: STRING
			-- <Precursor>		
		do
			Result := "(" + serialization_separator + ")"
		end

feature {PEG_COMPOSITE} -- Serialization

	serialization_separator: STRING
		-- The separator string for serialization
		deferred
		end

end
