class
	PE_MEMBER_REF_PARENT_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_INDEX_ITEM
		do
			Result := pe.read_memberref_parent_index (label, Current)
		end

feature -- Access

	typedef: NATURAL_8 = 0
	typeref: NATURAL_8 = 1
	moduleref: NATURAL_8 = 2
	methoddef: NATURAL_8 = 3
	typespec: NATURAL_8 = 4

	tagbit: INTEGER = 3

end
