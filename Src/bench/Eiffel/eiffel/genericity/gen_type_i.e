-- Generic type class

class GEN_TYPE_I

inherit
	CL_TYPE_I
		redefine
			meta_generic,
			true_generics,
			same_as, is_equal,
			is_valid,
			is_explicit,
			has_formal,
			instantiation_in,
			dump,
			append_signature,
			type_a,
			gen_type_string,
			make_gen_type_byte_code
		end

feature

	meta_generic: META_GENERIC
			-- Meta generic description of the type class

	set_meta_generic (m: META_GENERIC) is
			-- Assign `m' to `meta_generic'.
		do
			if m = Void then
				-- TUPLE without generic parameters
				!!meta_generic.make (0)
			else
				meta_generic := m
			end
		end

	true_generics : ARRAY [TYPE_I]
			-- True generic types.

	set_true_generics (tgen: ARRAY [TYPE_I]) is
			-- Assign `tgen' to `true_generics'.
		do
			if tgen = Void then
				-- TUPLE without generic parameters
				!!true_generics.make (1,0)
			else
				true_generics := tgen
			end
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
			-- NOTE: we do not compare `true_generics'!
		local
			gen_type_i: GEN_TYPE_I
		do
			gen_type_i ?= other
			if gen_type_i /= Void then
				Result := equal (base_id, gen_type_i.base_id)
						and then is_expanded = gen_type_i.is_expanded
						and then is_separate = gen_type_i.is_separate
						and then meta_generic.same_as (gen_type_i.meta_generic)
			end
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := equal (base_id, other.base_id)
					and then is_expanded = other.is_expanded
					and then is_separate = other.is_separate
					and then meta_generic.same_as (other.meta_generic)
		end

	is_valid: BOOLEAN is
			-- Are all the base classes still in the system ?
		do
			Result := base_class /= Void and then meta_generic.is_valid
		end

	duplicate: like Current is
			-- Duplication
		do
			Result := clone (Current)
			Result.set_meta_generic (clone (meta_generic))
			Result.set_true_generics (clone (true_generics))
		end

	instantiation_in (other: like Current): like Current is
			-- Instantiation of Current in context of `other'
		local
			i, count, meta_position: INTEGER
			formal: FORMAL_I
			meta_gen: like meta_generic
			true_gen: like true_generics
		do
			from
				Result := duplicate
				meta_gen := Result.meta_generic
				true_gen := Result.true_generics
				i := 1
				count := meta_generic.count
			until
				i > count
			loop
				meta_gen.put
					(meta_generic.item (i).instantiation_in (other), i)
				true_gen.put
					(true_generics.item (i).complete_instantiation_in (other), i)
				i := i + 1
			end
		end

	is_explicit: BOOLEAN is

		local
			i, count: INTEGER
		do
			Result := (cr_info = Void)

			from
				i := 1
				count := true_generics.count
			until
				i > count or else not Result
			loop
				Result := true_generics.item (i).is_explicit
				i := i + 1
			end
		end

	has_formal: BOOLEAN is
			-- Are some meta formals present in `meta_generic' ?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := meta_generic.count
			until
				i > count or else Result
			loop
				Result := meta_generic.item (i).has_formal
				i := i + 1
			end
		end

	dump (file: FILE) is
		local
			i, count, meta_type: INTEGER
			s: STRING
		do
			from
				if is_expanded then
					file.putstring ("expanded ")
				end
				s := clone (base_class.name)
				s.to_upper
				file.putstring (s)
				file.putstring (" [")
				i := 1
				count := meta_generic.count
			until
				i > count
			loop
				meta_generic.item (i).dump (file)
				if i < count then
					file.putstring (", ")
				end
				i := i + 1
			end
			file.putchar (']')
		end

	append_signature (st: STRUCTURED_TEXT) is
		local
			i, count, meta_type: INTEGER
		do
			from
				if is_expanded then
					st.add_string ("expanded ")
				end
				base_class.append_name (st)
				st.add_string (" [")
				i := 1
				count := meta_generic.count
			until
				i > count
			loop
				meta_generic.item (i).append_signature (st)
				if i < count then
					st.add_string (", ")
				end
				i := i + 1
			end
			st.add_char (']')
		end

	type_a: GEN_TYPE_A is
		local
			i: INTEGER
			array: ARRAY [TYPE_A]
		do
			!!Result
			Result.set_base_class_id (base_id)
			Result.set_is_expanded (is_expanded)
			from
				i := meta_generic.count
				!!array.make (1, i)
				Result.set_generics (array)
			until
				i = 0
			loop
				array.put (meta_generic.item (i).type_a, i)
				i := i - 1
			end
		end

feature -- Generic conformance

	gen_type_string (final_mode, use_info : BOOLEAN) : STRING is

		local
			i, up : INTEGER
		do
			!!Result.make (0)

			if use_info and then (cr_info /= Void) then
				-- It's an ancored type 
				Result.append (cr_info.gen_type_string(final_mode))
			end

			Result.append_integer (generated_id (final_mode))
			Result.append (", ")

			from
				i  := true_generics.lower
				up := true_generics.upper
			until
				i > up
			loop
				Result.append (true_generics.item (i).gen_type_string (
																final_mode,
																use_info
																	  ))
				i := i + 1
			end
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is

		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type 
				cr_info.make_gen_type_byte_code (ba)
			end

			ba.append_short_integer (generated_id (False))

			from
				i  := true_generics.lower
				up := true_generics.upper
			until
				i > up
			loop
				true_generics.item (i).make_gen_type_byte_code (ba, use_info)
				i := i + 1
			end
		end

end -- class GEN_TYPE_I
