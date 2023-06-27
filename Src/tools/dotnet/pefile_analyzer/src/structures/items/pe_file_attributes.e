class
	PE_FILE_ATTRIBUTES

inherit
	PE_FLAGS_32
		redefine
			read
		end

create
	make

feature -- Read

	read (pe: PE_FILE): PE_FILE_ATTRIBUTES_ITEM
		local
			i: PE_INTEGER_32_ITEM
		do
			i := pe.read_flags_32 (label)
			create Result.make_from_item (i)
			check Result.value = i.value end
		end

end
