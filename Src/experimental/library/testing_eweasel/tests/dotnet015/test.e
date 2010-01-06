class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			l_int: INTERNAL
			i: INTEGER
			arr: ARRAY [NONE]
			toto: TUPLE [STRING, TUPLE]
			tutu: TUPLE [ANY]
			titi: TUPLE [INTEGER]
			b: BOOLEAN
		do
				-- Check equality is properly checked.
			b := ({LIST [STRING]}).standard_is_equal ({LIST [PATH_NAME]})
			io.put_boolean (b)
			io.put_new_line

			b := ({LIST [STRING]}).standard_is_equal ({LIST [STRING]})
			io.put_boolean (b)
			io.put_new_line

				-- Check equality is properly checked.
			b := ({LIST [STRING]}).is_equal ({LIST [PATH_NAME]})
			io.put_boolean (b)
			io.put_new_line

			b := ({LIST [STRING]}).is_equal ({LIST [STRING]})
			io.put_boolean (b)
			io.put_new_line

				-- Would trigger an exception before fixing bug in INTERNAL/runtime.
			create l_int
			create arr.make (1, 1)
			i := l_int.dynamic_type (arr)

				-- Would trigger an exception before fixing bug in INTERNAL/runtime.
			toto := ["", ["", Void]]

				-- Would yield -1 instead of -2
			io.put_boolean (l_int.dynamic_type_from_string ("NONE") /= -1)
			io.put_new_line

				-- Would yield -1 instead of a valid dynamic type
			io.put_boolean (l_int.dynamic_type_from_string ("TUPLE [NONE]") /= -1)
			io.put_new_line

				-- Following line should be accepted by compiler
			create {TUPLE [NONE]} tutu

				-- Following assignment attempt should succeed at runtime
			tutu := Void
			tutu ?= create {TUPLE [NONE]}
			io.put_boolean (tutu /= Void)
			io.put_new_line

			titi ?= create {TUPLE [NONE]}
			io.put_boolean (titi /= Void)
			io.put_new_line
		end


	test_internal is
			--
		local
			l_int: INTERNAL
			l_type_string: STRING
			i, j: INTEGER
		do
			create l_int
			i := l_int.dynamic_type_from_string ("[]")
			j := -1
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("LINKED_LIST [[]]")
			j := -1
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TUPLE")
			j := l_int.dynamic_type (create {TUPLE})
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TUPLE []")
			j := l_int.dynamic_type (create {TUPLE []})
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TUPLE [INTEGER, INTEGER_8, INTEGER_16, INTEGER_64, NATURAL_8, NATURAL_16, NATURAL_32, NATURAL_64, REAL, DOUBLE, CHARACTER, POINTER, BOOLEAN, STRING]")
			j := l_int.dynamic_type (create {TUPLE [INTEGER, INTEGER_8, INTEGER_16, INTEGER_64, NATURAL_8, NATURAL_16, NATURAL_32, NATURAL_64, REAL, DOUBLE, CHARACTER, POINTER, BOOLEAN, STRING]})
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TUPLE [INTEGER]")
			j := l_int.dynamic_type (create {TUPLE [INTEGER]})
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TUPLE [INTEGER, TUPLE [CHARACTER]]")
			j := l_int.dynamic_type (create {TUPLE [INTEGER, TUPLE [CHARACTER]]})
			check_validity (i, j)

			i := l_int.dynamic_type_from_string (" HASH_TABLE [  CELL [  INTEGER   ],   INTEGER  ]  %T ")
			j := l_int.dynamic_type (create {HASH_TABLE [CELL [INTEGER], INTEGER]}.make (0))
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("HASH_TABLE [CELL [TUPLE [CHARACTER, INTEGER, INTEGER_64]], INTEGER]")
			j := l_int.dynamic_type (create {HASH_TABLE [CELL [TUPLE [CHARACTER, INTEGER, INTEGER_64]], INTEGER]}.make (0))
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("STRING")
			j := l_int.dynamic_type (create {STRING}.make (0))
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("LINKED_LIST [CELL [ARRAYED_LIST [INTEGER]]]")
			j := l_int.dynamic_type (create {LINKED_LIST [CELL [ARRAYED_LIST [INTEGER]]]}.make)
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("HASH_TABLE [INTEGER, STRING]")
			j := l_int.dynamic_type (create {HASH_TABLE [INTEGER, STRING]}.make (0))
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TUPLE [INTEGER, HASH_TABLE [TUPLE [INTEGER, STRING], STRING]]")
			j := l_int.dynamic_type (create {TUPLE [INTEGER, HASH_TABLE [TUPLE [INTEGER, STRING], STRING]]})
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("Unknown_type")
			j := -1
			check_validity (i, j)

			i := l_int.dynamic_type_from_string ("TEST")
			j := l_int.dynamic_type (Current)
			check_validity (i, j)

				-- Ensures that there is no major leak in `dynamic_type_from_string'.
			from
				i := 1
				l_type_string := "HASH_TABLE [CELL [TUPLE [CHARACTER, INTEGER, INTEGER_64]], INTEGER]"
			until
				i = 200
			loop
				j := l_int.dynamic_type_from_string (l_type_string)
				i := i + 1
			end
		end

	check_validity (i, valid_type_id: INTEGER) is
		local
			l_int: INTERNAL
		do
			if i /= valid_type_id then
				create l_int
				io.put_string ("Cannot get type for " + l_int.type_name_of_type (valid_type_id))
				io.put_new_line
			end
		end

end
