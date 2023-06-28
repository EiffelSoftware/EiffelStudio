class
	PE_RESOLUTION_SCOPE_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_INDEX_ITEM
		do
			Result := pe.read_resolution_scope_index (label, Current)
		end

feature -- Constants

	module: NATURAL_32 = 0
	moduleref: NATURAL_32 = 1
	assemblyref: NATURAL_32 = 2
	typeref: NATURAL_32 = 3

	tagbit: INTEGER = 2

end
