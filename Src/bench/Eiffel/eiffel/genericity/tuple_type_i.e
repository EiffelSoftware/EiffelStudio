-- TUPLE type class

class TUPLE_TYPE_I

inherit
	GEN_TYPE_I
		redefine
			same_as, is_equal,
			duplicate,
			dump,
			append_signature,
			type_a,
			generate_cid,
			make_gen_type_byte_code
		end

feature

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
			-- NOTE: any two TUPLES are considered to
			-- be the same except for `expandednessï.
		local
			tuple_type_i: TUPLE_TYPE_I
		do
			tuple_type_i ?= other
			if tuple_type_i /= Void then
				Result := (is_expanded = tuple_type_i.is_expanded)
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

	duplicate: like Current is
			-- Duplication
		do
			Result := clone (Current)
			Result.set_meta_generic (clone (meta_generic))
			Result.set_true_generics (clone (true_generics))
		end

	dump (file: FILE) is

		local
			i, count, meta_type: INTEGER
			s: STRING
		do
			if is_expanded then
				file.putstring ("expanded ")
			end
			s := clone (base_class.name)
			s.to_upper
			file.putstring (s)

			count := meta_generic.count

			if count /= 0 then
				file.putstring (" [")
				from
					i := 1
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
		end

	append_signature (st: STRUCTURED_TEXT) is
		local
			i, count, meta_type: INTEGER
		do
			if is_expanded then
				st.add_string ("expanded ")
			end
			base_class.append_name (st)

			count := meta_generic.count
			if count /= 0 then
				from
					st.add_string (" [")
					i := 1
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
		end

	type_a: TUPLE_TYPE_A is

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

	generate_cid (f : INDENT_FILE; final_mode, use_info : BOOLEAN) is

		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type 
				cr_info.generate_cid (f, final_mode)
			end
			f.putint (-15)
			f.putstring (", ")
			f.putint (true_generics.count)
			f.putstring (", ")
			f.putint (generated_id (final_mode))
			f.putstring (", ")

			from
				i  := true_generics.lower
				up := true_generics.upper
			until
				i > up
			loop
				true_generics.item (i).generate_cid (f, final_mode, use_info)
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

			ba.append_short_integer (-15)
			ba.append_short_integer (true_generics.count)
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

end -- class TUPLE_TYPE_I

