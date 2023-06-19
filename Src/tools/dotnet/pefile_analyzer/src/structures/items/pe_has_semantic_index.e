class
	PE_HAS_SEMANTIC_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_has_semantic_index (label, Current)
		end

feature -- Constants

	event: NATURAL_32 = 0
	property: NATURAL_32 = 1

	tagbit: INTEGER = 1

end
