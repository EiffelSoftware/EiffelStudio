class
	PE_METHOD_DEF_OR_MEMBER_REF_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_method_def_or_member_ref_index (label, Current)
		end

feature -- Constants

	methoddef: NATURAL_32 = 0
	memberref: NATURAL_32 = 1

	tagbit: INTEGER = 1

end
