class TEST1 [G]

create
	make

feature -- Initialization

	make (f: G)
		do
			formal := f
			g (Current, 5.0, f)
			g (Void, 5.0, f)
			g (object, real, f)

			g2 ("s", real, f)
		end

	formal: G
	real: REAL_64
	object: detachable ANY
	obj2: detachable ANY

	g (arg_any: detachable ANY; arg_real: REAL_64; arg_formal: G)
		local
			a: detachable ANY
			r: REAL_64
			l_g: G
			l_ptr: POINTER
		do
			l_g := arg_formal

			f_real (0.0)
			f_real (25.0 + 43.0)
			f_real (r * r)
			f_real (real)
			f_real (r)
			f_real (arg_real)

			f_any (Void)
			f_any (arg_any)
			f_any (object)
			if attached object as l_object then
				f_any (l_object)
				f_any (l_object.twin)
			end

			f_formal (l_g)
			f_formal (arg_formal)
			f_formal (formal)

			ref_real (0.0)
			ref_real (25.0 + 43.0)
			ref_real (r * r)
			ref_real (real)
			ref_real (r)
			ref_real (arg_real)

			ref_any (Void)
			ref_any (arg_any)
			ref_any (object)
			if attached object as l_object then
				ref_any (l_object)
				ref_any (l_object.twin)
			end

			ref_formal (l_g)
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
			if attached object as l_object then
				external_routine ($l_object)
			end

			my_print ($arg_formal)
			my_print ($arg_real)
			my_print ($arg_any)
			my_print ($formal)
			my_print ($real)
			my_print ($object)
			my_print ($a)
			my_print ($r)
			my_print ($l_g)
			if attached object as l_object then
				my_print ($l_object)
			end

			my_inlined_print ($arg_formal)
			my_inlined_print ($arg_real)
			my_inlined_print ($arg_any)
			my_inlined_print ($formal)
			my_inlined_print ($real)
			my_inlined_print ($object)
			my_inlined_print ($a)
			my_inlined_print ($r)
			my_inlined_print ($l_g)
			if attached object as l_object then
				my_inlined_print ($l_object)
			end
		end

	g2 (arg_any: detachable ANY; arg_real: REAL_64; arg_formal: G)
		local
			a: detachable ANY
			r: REAL_64
			l_g: G
		do
			obj2 := "s"
			a := "s"
			if object = obj2 then
				io.put_string ("object = obj2!!!%N")
			end
			if arg_any = object then
				io.put_string ("arg_any = object!!!%N")
			end
			if a = object then
				io.put_string ("a = object!!!%N")
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
			if is_same_object ($a, $object) then
				io.put_string ("Not OK%N")
			end
			if is_same_object ($object, $a) then
				io.put_string ("Not OK%N")
			end
		end

	f_real (r: REAL_64)
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
