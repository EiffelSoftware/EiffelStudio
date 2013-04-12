class TEST

inherit
	SERIALIZATION_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Run test.
		local
			list: LIST [ANY]
			l_obj: ANY
			l_objects: like retrieved_objects
			typed_pointer_any_default: TYPED_POINTER [ANY]
			typed_pointer_real_32_default: TYPED_POINTER [REAL_32]
			x: X
		do
				-- Fill a list with expanded objects.
			create {ARRAYED_LIST [ANY]} list.make_filled (17)
			list [1] := True
			list [2] := {CHARACTER_8} 'A'
			list [3] := {CHARACTER_32} 'B'
			list [4] := {INTEGER_8} -8
			list [5] := {INTEGER_16} -16
			list [6] := {INTEGER_32} -32
			list [7] := {INTEGER_64} -64
			list [8] := {NATURAL_8} 8
			list [9] := {NATURAL_16} 16
			list [10] := {NATURAL_32} 32
			list [11] := {NATURAL_64} 64
			list [12] := default_pointer
			list [13] := {REAL_32} 1.0e32
			list [14] := {REAL_64} 1.0e64
			list [15] := typed_pointer_any_default
			list [16] := typed_pointer_real_32_default
			x.set
			list [17] := x

			set_is_pointer_value_stored (True)
			store_object (list, "stored")
			l_objects := retrieved_objects ("stored")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			else
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
					if attached {ARRAYED_LIST [ANY]} l_item.item as l_list then
						check_list (l_list)
					else
						io.put_string ("Unable to retrieve the items%N")
					end
					io.put_new_line
				end
			end
		end

	check_list (a_list: ARRAYED_LIST [ANY])
		local
			boolean: BOOLEAN
			character_8: CHARACTER_8
			character_32: CHARACTER_32
			integer_8: INTEGER_8
			integer_16: INTEGER_16
			integer_32: INTEGER_32
			integer_64: INTEGER_64
			natural_8: NATURAL_8
			natural_16: NATURAL_16
			natural_32: NATURAL_32
			natural_64: NATURAL_64
			pointer: POINTER
			real_32: REAL_32
			real_64: REAL_64
			typed_pointer_any_default: TYPED_POINTER [ANY]
			typed_pointer_any: TYPED_POINTER [ANY]
			typed_pointer_real_32_default: TYPED_POINTER [REAL_32]
			typed_pointer_real_32: TYPED_POINTER [REAL_32]
			x: X
			y: X
		do
				-- Verify list items.
			boolean ?= a_list [1]
			verify (boolean, boolean = True)
			character_8 ?= a_list [2]
			verify (character_8, character_8 = {CHARACTER_8} 'A')
			character_32 ?= a_list [3]
			verify (character_32, character_32 = {CHARACTER_32} 'B')
			integer_8 ?= a_list [4]
			verify (integer_8, integer_8 = {INTEGER_8} -8)
			integer_16 ?= a_list [5]
			verify (integer_16, integer_16 = {INTEGER_16} -16)
			integer_32 ?= a_list [6]
			verify (integer_32, integer_32 = {INTEGER_32} -32)
			integer_64 ?= a_list [7]
			verify (integer_64, integer_64 = {INTEGER_64} -64)
			natural_8 ?= a_list [8]
			verify (natural_8, natural_8 = {NATURAL_8} 8)
			natural_16 ?= a_list [9]
			verify (natural_16, natural_16 = {NATURAL_16} 16)
			natural_32 ?= a_list [10]
			verify (natural_32, natural_32 = {NATURAL_32} 32)
			natural_64 ?= a_list [11]
			verify (natural_64, natural_64 = {NATURAL_64} 64)
			pointer ?= a_list [12]
			verify (pointer, pointer = default_pointer)
			real_32 ?= a_list [13]
			verify (real_32, real_32 = {REAL_32} 1.0e32)
			real_64 ?= a_list [14]
			verify (real_64, real_64 = {REAL_64} 1.0e64)
			typed_pointer_any ?= a_list [15]
			verify (typed_pointer_any, typed_pointer_any = typed_pointer_any_default)
			typed_pointer_real_32 ?= a_list [16]
			verify (typed_pointer_real_32, typed_pointer_real_32 = typed_pointer_real_32_default)
			y ?= a_list [17]
			x.set
			verify (y, y = x)
		end

feature {NONE} -- Output

	verify (object: ANY; is_expected: BOOLEAN)
			-- Verify for `object' that its value `is_expected'
			-- and output the corresponding message.
		do
			io.put_string (object.generating_type)
			if is_expected then
				io.put_string (": OK")
			else
				io.put_string (": Failed with value '")
				io.put_string (object.out)
				io.put_character ('%'')
			end
			io.put_new_line
		end

end
