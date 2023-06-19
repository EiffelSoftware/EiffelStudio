class
	PE_MEMBER_REF_PARENT_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_member_ref_parent_index (label, Current)
		end

feature -- Constants

	typedef: NATURAL_32 = 0
	typeref: NATURAL_32 = 1
	moduleref: NATURAL_32 = 2
	methoddef: NATURAL_32 = 3
	typespec: NATURAL_32 = 4

	tagbit: INTEGER = 3

end
