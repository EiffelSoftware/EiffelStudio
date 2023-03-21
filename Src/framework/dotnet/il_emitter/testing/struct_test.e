note
	description: "Summary description for {STRUCT_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCT_TEST

create
	make


feature {NONE} -- Initialization

	make
		do
			data_size := 1
			hdr_size := 10
			create reserved.make_filled (0, 1, 3)
			reserved [1] := 1
			reserved [2] := 2
			reserved [3] := 3
		end

feature -- Access

	data_size: INTEGER_32

	hdr_size: INTEGER_32

	reserved: ARRAY [INTEGER]



	mp: MANAGED_POINTER
		local
			l_mp: MANAGED_POINTER
			l_pos: INTEGER
		do
			create l_mp.make (20)
			l_mp.put_integer_32_le (data_size, 0)
			l_pos := {PLATFORM}.integer_32_bytes

			l_mp.put_integer_32_le (hdr_size, l_pos )
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

			l_mp.put_integer_32_le (reserved[1], l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

			l_mp.put_integer_32_le (reserved[2], l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

			l_mp.put_integer_32_le (reserved[3], l_pos)

			Result := l_mp
		end



end
