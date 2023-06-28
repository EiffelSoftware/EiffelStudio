note
	description: "[
			Blob heap item
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_BLOB_ITEM

inherit
	PE_BYTES_ITEM

create
	make,
	make_sub

convert
	dump: {READABLE_STRING_8, STRING_8}

feature -- Access

	sub_item_at (pos: NATURAL_32; lab: like label): PE_BLOB_ITEM
		local
			mp: MANAGED_POINTER
			p: POINTER
			d: NATURAL_32
		do
			d := pos - (value_begin_address - declaration_address)
			p := pointer.item + d.to_integer_32
			create mp.make_from_pointer (p, (size - d).to_integer_32)
			create Result.make_sub (declaration_address + pos, value_begin_address + pos, value_end_address, mp, lab)
		end


end
