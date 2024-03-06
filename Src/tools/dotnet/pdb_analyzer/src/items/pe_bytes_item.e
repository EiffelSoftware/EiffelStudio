note
	description: "Summary description for {PE_BYTES_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_BYTES_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		redefine
			debug_output
		end

create
	make,
	make_sub

convert
	dump: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization

	make (a_decl_address, a_start_index, a_end_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		require
			a_end_index - a_start_index = mp.count.to_natural_32
		do
			binary_byte_size := mp.count.to_natural_32
			make_item (a_decl_address, a_start_index, a_end_index, mp, lab)
		end

	make_sub (a_decl_address, a_start_index, a_end_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		require
			a_end_index - a_start_index <= mp.count.to_natural_32
		do
			make_item (a_decl_address, a_start_index, a_end_index, mp, lab)
		end

feature -- Status report

	as_utf8_string: STRING_8
		local
			i, n: INTEGER_32
			mp: MANAGED_POINTER
		do
			mp := pointer
			from
				i := 0
				n := size.to_integer_32
				create Result.make (n)
			until
				i >= n
			loop
				Result.append_code (mp.read_natural_8 (i).to_natural_32)
				i := i + 1
			end
		end

	to_string: STRING_32
		do
			Result := dump.to_string_32
		end

	binary_byte_size: NATURAL_32

	debug_output: READABLE_STRING_GENERAL
		do
			Result := Precursor + {STRING_32} "end[" + value_end_address.to_hex_string + "]"
		end


end
