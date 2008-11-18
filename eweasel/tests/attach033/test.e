class TEST

create
	default_create, make

feature {NONE} -- Creation

	make is
		local
			l_int: INTERNAL
			i: INTEGER
			t: TEST1 [STRING]
			t_test: TEST1 [!TEST]
			t_tuple: TEST1 [!TUPLE]
			t2: TEST2 [STRING, STRING]
		do
			create t_test
			create t_tuple
			create l_int
			check_dtype (l_int.dynamic_type_from_string ("TEST"), l_int.dynamic_type (create {TEST}))

			check_dtype (l_int.dynamic_type_from_string ("!TEST"), l_int.generic_dynamic_type (t_test, 1))
			check_dtype (l_int.dynamic_type_from_string ("?TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  ?TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  ?  TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  !TEST"), l_int.generic_dynamic_type (t_test, 1))
			check_dtype (l_int.dynamic_type_from_string ("  !  TEST"), l_int.generic_dynamic_type (t_test, 1))

			check_dtype (l_int.dynamic_type_from_string ("!TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))
			check_dtype (l_int.dynamic_type_from_string ("?TUPLE"), l_int.dynamic_type (create {TUPLE}))
			check_dtype (l_int.dynamic_type_from_string ("  ?TUPLE"), l_int.dynamic_type (create {TUPLE}))
			check_dtype (l_int.dynamic_type_from_string ("  ?  TUPLE"), l_int.dynamic_type (create {TUPLE}))
			check_dtype (l_int.dynamic_type_from_string ("  !TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))
			check_dtype (l_int.dynamic_type_from_string ("  !  TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!STRING]"), l_int.dynamic_type (create {TEST1 [!STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  STRING]"), l_int.dynamic_type (create {TEST1 [!STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [!TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [!TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [!TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [!TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: !STRING; b: INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [!TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [!TUPLE [a: !STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: !STRING; b: INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [!STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[!STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [?STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [  !  STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[!STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [  ?   STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST2 [STRING, STRING]"), l_int.dynamic_type (create {TEST2 [STRING, STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ? STRING, ? STRING]"), l_int.dynamic_type (create {TEST2 [STRING, STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ! STRING, ! STRING]"), l_int.dynamic_type (create {TEST2 [!STRING, !STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ? STRING, ! STRING]"), l_int.dynamic_type (create {TEST2 [STRING, !STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ! STRING, ? STRING]"), l_int.dynamic_type (create {TEST2 [!STRING, STRING]}))

		end

	check_dtype (i, j: INTEGER) is
		do
			if i /= j then
				io.put_string ("Not OK")
				io.put_new_line
			end
		end

end
