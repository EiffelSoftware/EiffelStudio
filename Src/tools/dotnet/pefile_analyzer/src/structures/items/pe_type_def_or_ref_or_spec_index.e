class
	PE_TYPE_DEF_OR_REF_OR_SPEC_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_INDEX_ITEM
		do
			Result := pe.read_type_def_or_ref_or_spec_index (label, Current)
		end

feature -- Constants

	typedef: NATURAL_32 = 0
	typeref: NATURAL_32 = 1
	typespec: NATURAL_32 = 2

	tagbit: INTEGER = 2

end
