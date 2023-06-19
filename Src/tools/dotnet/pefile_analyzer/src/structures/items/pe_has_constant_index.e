class
	PE_HAS_CONSTANT_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_has_constant_index (label, Current)
		end

feature -- Constants

	field: NATURAL_32 = 0
	param: NATURAL_32 = 1
	property: NATURAL_32 = 2

	tagbit: INTEGER = 2

end
