-- TUPLE type class

class TUPLE_TYPE_I

inherit
	GEN_TYPE_I
		redefine
			same_as,
			type_a,
			generate_cid,
			make_gen_type_byte_code
		end

feature

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
			-- NOTE: any two TUPLES are considered to be 
			-- the same except for `expandedness�.
		local
			tuple_type_i: TUPLE_TYPE_I
		do
			tuple_type_i ?= other
			if tuple_type_i /= Void then
				Result := (is_expanded = tuple_type_i.is_expanded)
			end
		end

	type_a: TUPLE_TYPE_A is

		local
			i: INTEGER
			array: ARRAY [TYPE_A]
		do
			from
				i := meta_generic.count
				!!array.make (1, i)
			until
				i = 0
			loop
				array.put (meta_generic.item (i).type_a, i)
				i := i - 1
			end

			!!Result
			Result.set_base_class_id (base_id)
			Result.set_is_expanded (is_expanded)
			Result.set_generics (array)
		end

feature -- Generic conformance

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN) is

		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type 
				cr_info.generate_cid (buffer, final_mode)
			end
			buffer.putint (-15)
			buffer.putstring (", ")
			buffer.putint (0)
			buffer.putstring (", ")
			buffer.putint (true_generics.count)
			buffer.putstring (", ")
			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")

			from
				i  := true_generics.lower
				up := true_generics.upper
			until
				i > up
			loop
				true_generics.item (i).generate_cid (buffer, final_mode, use_info)
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
			ba.append_short_integer (0)
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

