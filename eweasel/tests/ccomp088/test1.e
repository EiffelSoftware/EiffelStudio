class TEST1 [G]

create
	make

feature -- Initialization

	make (f: G)
		do
			formal := f
			g (Current, 5.0, 5, True, 'x', f).do_nothing
			g (Void, 5.0, 5, True, 'x', f).do_nothing
			g (object, real, int, bool, char, f).do_nothing

			g2 ("s").do_nothing
		end

	formal: G
	real: REAL_64
	bool: BOOLEAN
	char: CHARACTER
	int: INTEGER_64
	object: detachable ANY
	obj2: detachable ANY

	g (arg_any: detachable ANY; arg_real: REAL_64; arg_int: INTEGER_64; arg_bool: BOOLEAN; arg_char: CHARACTER; arg_formal: G): ANY
		local
			l_any: detachable ANY
			l_real: REAL_64
			l_formal: G
			l_ptr: POINTER
			l_bool: BOOLEAN
			l_char: CHARACTER
			l_int: INTEGER_64
		do
			Result := "as"

			l_formal := arg_formal

			f_char ('a')
			f_char ('a' + 2)
			f_char (l_char.next)
			f_char (char)
			f_char (l_char)
			f_char (arg_char)

			f_int (8)
			f_int (8 * 4)
			f_int (l_int + l_int)
			f_int (int)
			f_int (l_int)
			f_int (arg_int)

			f_bool (True)
			f_bool (True and False)
			f_bool (l_bool or l_bool)
			f_bool (bool)
			f_bool (l_bool)
			f_bool (arg_bool)

			f_real (0.0)
			f_real (25.0 + 43.0)
			f_real (l_real * l_real)
			f_real (real)
			f_real (l_real)
			f_real (arg_real)

			f_any (Void)
			f_any (arg_any)
			f_any (object)
			f_any (Current)
			f_any (Result)
			if attached object as l_object then
				f_any (l_object)
				f_any (l_object.twin)
			end

			f_formal (l_formal)
			f_formal (arg_formal)
			f_formal (formal)

			ref_char ('a')
			ref_char ('a' + 2)
			ref_char (l_char.next)
			ref_char (char)
			ref_char (l_char)
			ref_char (arg_char)

			ref_int (8)
			ref_int (8 * 4)
			ref_int (l_int + l_int)
			ref_int (int)
			ref_int (l_int)
			ref_int (arg_int)

			ref_bool (True)
			ref_bool (True and False)
			ref_bool (l_bool or l_bool)
			ref_bool (bool)
			ref_bool (l_bool)
			ref_bool (arg_bool)

			ref_real (0.0)
			ref_real (25.0 + 43.0)
			ref_real (l_real * l_real)
			ref_real (real)
			ref_real (l_real)
			ref_real (arg_real)

			ref_any (Void)
			ref_any (arg_any)
			ref_any (object)
			ref_any (Current)
			ref_any (Result)
			if attached object as l_object then
				ref_any (l_object)
				ref_any (l_object.twin)
			end

			ref_formal (l_formal)
			ref_formal (arg_formal)
			ref_formal (formal)

			external_routine (default_pointer)
			external_routine (l_ptr)
			external_routine ($arg_real)
			external_routine ($arg_any)
			external_routine ($arg_formal)
			external_routine ($real)
			external_routine ($object)
			external_routine ($formal)
			external_routine ($Current)
			external_routine ($Result)
			if attached object as l_object then
				external_routine ($l_object)
			end

			my_print ($arg_formal)
			my_print ($arg_real)
			my_print ($arg_any)
			my_print ($formal)
			my_print ($real)
			my_print ($object)
			my_print ($l_any)
			my_print ($l_real)
			my_print ($l_formal)
			my_print ($Current)
			my_print ($Result)
			if attached object as l_object then
				my_print ($l_object)
			end

			my_inlined_print ($arg_formal)
			my_inlined_print ($arg_real)
			my_inlined_print ($arg_any)
			my_inlined_print ($formal)
			my_inlined_print ($real)
			my_inlined_print ($object)
			my_inlined_print ($l_any)
			my_inlined_print ($l_real)
			my_inlined_print ($l_formal)
			my_inlined_print ($Current)
			my_inlined_print ($Result)
			if attached object as l_object then
				my_inlined_print ($l_object)
			end
		end

	g2 (arg_any: detachable ANY): ANY
		local
			l_any: detachable ANY
		do
			Result := "as"

			obj2 := "s"
			l_any := "s"
			if object = obj2 then
				io.put_string ("object = obj2!!!%N")
			end
			if arg_any = object then
				io.put_string ("arg_any = object!!!%N")
			end
			if l_any = object then
				io.put_string ("l_any = object!!!%N")
			end


			if is_same_object ($object, $obj2) then
				io.put_string ("Not OK%N")
			end
			if is_same_object ($arg_any, $object) then
				io.put_string ("Not OK%N")
			end
			if is_same_object ($object, $arg_any) then
				io.put_string ("Not OK%N")
			end
			if is_same_object ($l_any, $object) then
				io.put_string ("Not OK%N")
			end
			if is_same_object ($object, $l_any) then
				io.put_string ("Not OK%N")
			end

			if is_same_object ($Result, $object) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($object, $Result) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($Result, $obj2) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($obj2, $Result) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($Current, $object) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($object, $Current) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($Current, $obj2) then
				io.put_string ("Not Ok%N")
			end
			if is_same_object ($obj2, $Current) then
				io.put_string ("Not Ok%N")
			end
		end

	f_real (r: REAL_64)
		local
			p: POINTER
		do
			p := $r
		end

	f_bool (r: BOOLEAN)
		local
			p: POINTER
		do
			p := $r
		end

	f_char (r: CHARACTER)
		local
			p: POINTER
		do
			p := $r
		end

	f_int (r: INTEGER_64)
		local
			p: POINTER
		do
			p := $r
		end

	f_any (a: detachable ANY)
		local
			p: POINTER
		do
			p := $a
		end

	f_formal (f: G)
		local
			p: POINTER
		do
			p := $f
		end

	ref_real (r: REAL_64)
		do
			external_routine ($r)
		end

	ref_bool (r: BOOLEAN)
		do
			external_routine ($r)
		end

	ref_int (r: INTEGER_64)
		do
			external_routine ($r)
		end

	ref_char (r: CHARACTER)
		do
			external_routine ($r)
		end

	ref_any (a: detachable ANY)
		do
			external_routine ($a)
		end

	ref_formal (f: G)
		do
			external_routine ($f)
		end

	external_routine (obj: POINTER)
		external
			"C inline"
		alias
			"return;"
		end

	is_same_object (a_obj, a_obj2: POINTER): BOOLEAN
		external
			"C inline"
		alias
			"return $a_obj == $a_obj2;"
		end

	my_print (a: detachable ANY)
		local
			s: STRING_32
		do
			if a /= Void then
				create s.make (512)
			end
		end

	my_inlined_print (a: detachable ANY)
		do
		end

end
