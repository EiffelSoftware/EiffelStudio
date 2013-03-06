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
		end

	formal: G
	real: REAL_64
	object: detachable ANY

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

			print ($arg_formal)
			print ($arg_real)
			print ($arg_any)
			print ($formal)
			print ($real)
			print ($object)
			print ($a)
			print ($r)
			print ($l_g)
			if attached object as l_object then
				print ($l_object)
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

end
