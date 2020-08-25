class TEST

create
	default_create, make

feature {NONE} -- Creation

	make
		local
			l_int: INTERNAL
			i: INTEGER
			t: TEST1 [STRING]
			t_test: TEST1 [attached TEST]
			t_tuple: TEST1 [attached TUPLE]
			t2: TEST2 [STRING, STRING]
		do
			create t_test
			create t_tuple
			create l_int
			
			check_dtype (l_int.dynamic_type_from_string ("XXXX"), -1)
			check_dtype (l_int.dynamic_type_from_string ("A_T"), l_int.dynamic_type (create {A_T}))
			check_dtype (l_int.dynamic_type_from_string ("TEST"), l_int.dynamic_type (create {TEST}))

			check_dtype (l_int.dynamic_type_from_string ("!TEST"), l_int.generic_dynamic_type (t_test, 1))
			check_dtype (l_int.dynamic_type_from_string ("?TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  ?TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  ?  TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  !TEST"), l_int.generic_dynamic_type (t_test, 1))
			check_dtype (l_int.dynamic_type_from_string ("  !  TEST"), l_int.generic_dynamic_type (t_test, 1))

			check_dtype (l_int.dynamic_type_from_string ("!TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))
			check_dtype (l_int.dynamic_type_from_string ("?TUPLE"), ({TUPLE}).type_id)
			check_dtype (l_int.dynamic_type_from_string ("  ?TUPLE"), ({TUPLE}).type_id)
			check_dtype (l_int.dynamic_type_from_string ("  ?  TUPLE"), ({TUPLE}).type_id)
			check_dtype (l_int.dynamic_type_from_string ("  !TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))
			check_dtype (l_int.dynamic_type_from_string ("  !  TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!STRING]"), l_int.dynamic_type (create {TEST1 [attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  STRING]"), l_int.dynamic_type (create {TEST1 [attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   TUPLE [!STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   TUPLE [!STRING, !INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [!STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[attached STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [?STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [  !  STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[attached STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [  ?   STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST2 [STRING, STRING]"), l_int.dynamic_type (create {TEST2 [STRING, STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ? STRING, ? STRING]"), l_int.dynamic_type (create {TEST2 [STRING, STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ! STRING, ! STRING]"), l_int.dynamic_type (create {TEST2 [attached STRING, attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ? STRING, ! STRING]"), l_int.dynamic_type (create {TEST2 [STRING, attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ ! STRING, ? STRING]"), l_int.dynamic_type (create {TEST2 [attached STRING, STRING]}))


				-- New syntax
			check_dtype (l_int.dynamic_type_from_string ("attached TEST"), l_int.generic_dynamic_type (t_test, 1))
			check_dtype (l_int.dynamic_type_from_string ("detachable TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  detachable TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  detachable   TEST"), l_int.dynamic_type (create {TEST}))
			check_dtype (l_int.dynamic_type_from_string ("  attached TEST"), l_int.generic_dynamic_type (t_test, 1))
			check_dtype (l_int.dynamic_type_from_string ("  attached   TEST"), l_int.generic_dynamic_type (t_test, 1))

			check_dtype (l_int.dynamic_type_from_string ("attached TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))
			check_dtype (l_int.dynamic_type_from_string ("detachable TUPLE"), ({TUPLE}).type_id)
			check_dtype (l_int.dynamic_type_from_string ("  detachable TUPLE"), ({TUPLE}).type_id)
			check_dtype (l_int.dynamic_type_from_string ("  detachable   TUPLE"), ({TUPLE}).type_id)
			check_dtype (l_int.dynamic_type_from_string ("  attached TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))
			check_dtype (l_int.dynamic_type_from_string ("  attached   TUPLE"), l_int.generic_dynamic_type (t_tuple, 1))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [attached STRING]"), l_int.dynamic_type (create {TEST1 [attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [detachable STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  attached   STRING]"), l_int.dynamic_type (create {TEST1 [attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  detachable    STRING]"), l_int.dynamic_type (create {TEST1 [STRING]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [attached TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [detachable TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  attached   TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [STRING, INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  detachable    TUPLE [STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [STRING, INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [attached STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [attached TUPLE [attached STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [detachable TUPLE [attached STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  attached   TUPLE [attached STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  detachable    TUPLE [attached STRING, INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TUPLE [attached STRING, attached INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [attached TUPLE [attached STRING, attached INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [detachable TUPLE [attached STRING, attached INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  attached   TUPLE [attached STRING, attached INTEGER]]"), l_int.dynamic_type (create {TEST1 [attached TUPLE [a: attached STRING; b: INTEGER]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  detachable    TUPLE [attached STRING, attached INTEGER]]"), l_int.dynamic_type (create {TEST1 [TUPLE [a: attached STRING; b: INTEGER]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [attached STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[attached STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [detachable STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [  attached   STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[attached STRING]]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [TEST1 [  detachable    STRING]]"), l_int.dynamic_type (create {TEST1 [TEST1[STRING]]}))

			check_dtype (l_int.dynamic_type_from_string ("TEST2 [STRING, STRING]"), l_int.dynamic_type (create {TEST2 [STRING, STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ detachable  STRING, detachable  STRING]"), l_int.dynamic_type (create {TEST2 [STRING, STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ attached  STRING, attached  STRING]"), l_int.dynamic_type (create {TEST2 [attached STRING, attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ detachable  STRING, attached  STRING]"), l_int.dynamic_type (create {TEST2 [STRING, attached STRING]}))
			check_dtype (l_int.dynamic_type_from_string ("TEST2 [ attached  STRING, detachable  STRING]"), l_int.dynamic_type (create {TEST2 [attached STRING, STRING]}))

		end

	check_dtype (i, j: INTEGER)
		do
			if i /= j then
				io.put_string ("Not OK")
				io.put_new_line
			end
		end

end
