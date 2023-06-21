class
	PE_METHOD_ATTRIBUTES

inherit
	PE_FLAGS_16
		redefine
			read
		end

create
	make

feature -- Read

	read (pe: PE_FILE): PE_METHOD_ATTRIBUTES_ITEM
		local
			i: PE_INTEGER_16_ITEM
		do
			i := pe.read_flags_16 (label)
			create Result.make_from_item (i)
			check Result.value = i.value end
		end

end
