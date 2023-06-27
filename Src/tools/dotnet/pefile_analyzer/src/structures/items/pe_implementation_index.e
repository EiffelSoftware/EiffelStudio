class
	PE_IMPLEMENTATION_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_implementation_index (label, Current)
		end

feature -- Constants

	file: NATURAL_32 = 0
	assemblyref: NATURAL_32 = 1
	exportedtype: NATURAL_32 = 2

	tagbit: INTEGER = 2

end
