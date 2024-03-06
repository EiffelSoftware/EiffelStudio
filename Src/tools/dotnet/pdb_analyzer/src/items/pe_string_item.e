note
	description: "Summary description for {PE_STRING_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_STRING_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		redefine
			debug_output
		end

create
	make

convert
	value: {READABLE_STRING_8},
	string_32: {STRING_32}

feature {NONE} -- Initialization

	make (a_decl_address, a_start_index, a_end_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		require
			a_end_index - a_start_index = mp.count.to_natural_32
		do
			binary_byte_size := mp.count.to_natural_32
			make_item (a_decl_address, a_start_index, a_end_index, mp, lab)
		end

feature -- Access

	value: STRING
		do
			create Result.make_from_c_byte_array (pointer.item, size.to_integer_32)
		end

	binary_byte_size: NATURAL_32

	string_32: STRING_32
		do
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (value)
		end

	sub_item_at (pos: NATURAL_32; lab: like label): PE_STRING_ITEM
		local
			mp: MANAGED_POINTER
			p: POINTER
			d: NATURAL_32
		do
			d := pos - (value_begin_address - declaration_address)
			p := pointer.item + d.to_integer_32
			create mp.make_from_pointer (p, (size - d).to_integer_32)
			create Result.make (declaration_address + pos, value_begin_address + pos, value_end_address, mp, lab)
		end

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := size = 0 or else string_32.is_empty
		end

	to_string: STRING_32
		do
			Result := string_32
		end

	debug_output: READABLE_STRING_GENERAL
		do
			Result := Precursor + {STRING_32} "end[" + value_end_address.to_hex_string + "]"
		end


end
