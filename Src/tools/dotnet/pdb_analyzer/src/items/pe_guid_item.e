note
	description: "Summary description for {PE_GUID_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GUID_ITEM

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
	value: {READABLE_STRING_8}

feature {NONE} -- Initialization

	make (a_decl_address, a_start_index, a_end_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		require
			a_end_index - a_start_index = mp.count.to_natural_32
			mp.count \\ 16 = 0
		do
			make_item (a_decl_address, a_start_index, a_end_index, mp, lab)
		end

feature -- Access

	value: STRING
		local
			i, n: INTEGER
			n8: NATURAL_8
		do
			-- f77279b4-a0e9-4ec3-a5ca-f1bbe35ce4b1
			-- 8-4-4-4-12
			create Result.make (32 + 4)
			from
				i := 1
				n := 16
			until
				i > n
			loop
				n8 := pointer.read_natural_8 (i - 1)
				if
					i = 5
					or i = 7
					or i = 9
					or i = 11
				then
					Result.extend ('-')
				end
				Result.append (n8.to_hex_string.as_lower)
				i := i + 1
			end
		end

	binary_byte_size: NATURAL_32 = 16

feature -- Status report

	to_string: STRING_32
		do
			Result := value.to_string_32
		end

	debug_output: READABLE_STRING_GENERAL
		do
			Result := Precursor + {STRING_32} "end[" + value_end_address.to_hex_string + "]"
		end


end
