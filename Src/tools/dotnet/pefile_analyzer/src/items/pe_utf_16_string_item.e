note
	description: "Summary description for {PE_UTF_16_STRING_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_UTF_16_STRING_ITEM

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
	string_32: {READABLE_STRING_32}

feature {NONE} -- Initialization

	make (a_decl_address, a_start_index, a_end_index: NATURAL_32; mp: MANAGED_POINTER; nb: NATURAL_32; lab: like label)
		require
			a_end_index - a_start_index = mp.count.to_natural_32
		do
			make_item (a_decl_address, a_start_index, a_end_index, mp, lab)
		end

feature -- Access

	string_32: STRING_32
		do
			if size >= {NATURAL_32} 2 then
				Result := {UTF_CONVERTER}.utf_16_0_pointer_to_string_32 (pointer)
			else
				create Result.make_empty
			end
		end

feature -- Status report

	to_string: STRING_32
		do
			Result := string_32
		end

	debug_output: READABLE_STRING_GENERAL
		do
			Result := Precursor + {STRING_32} "end[" + value_end_address.to_hex_string + "]"
		end


end
