class
	PE_CUSTOM_ATTRIBUTE_TYPE_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_custom_attribute_type_index (label, Current)
		end

feature -- Constants

	methoddef: NATURAL_32 = 2
	memberref: NATURAL_32 = 3

	tagbit: INTEGER = 3


end
