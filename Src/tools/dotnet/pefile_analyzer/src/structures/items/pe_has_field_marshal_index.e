class
	PE_HAS_FIELD_MARSHAL_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_has_field_marshal_index (label, Current)
		end

feature -- Constants

	field: NATURAL_32 = 0
	param: NATURAL_32 = 1

	tagbit: INTEGER = 1

end
