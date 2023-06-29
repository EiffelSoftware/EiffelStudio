class
	PE_MEMBER_FORWARDED_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_INDEX_ITEM
		do
			Result := pe.read_member_forwarded_index (label, Current)
		end

feature -- Constants

	field: NATURAL_32 = 0
	methoddef: NATURAL_32 = 1

	tagbit: INTEGER = 1

end
