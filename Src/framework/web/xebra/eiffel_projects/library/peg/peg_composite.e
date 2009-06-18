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

feature -- Implementation

	serialize: STRING
			-- <Precursor>
		local
			separator: STRING
		do
			from
				Result := "("
				separator := ""
				children.start
			until
				children.after
			loop
				Result.append (separator)
				Result.append (children.item.serialize)
				separator := serialization_separator
				children.forth
			end
			Result.append (")")
		end

	serialization_separator: STRING
		-- The separator string for serialization
		deferred
		end

end
