indexing
	description: "Description of a TUPLE type."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_TYPE_I

inherit
	GEN_TYPE_I
		redefine
			same_as,
			type_a,
			generate_cid,
			make_gen_type_byte_code,
			generate_cid_array,
			generate_cid_init,
			il_type_name
		end

feature

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
			-- NOTE: any two TUPLES are considered to be 
			-- the same except for `expandednessï.
		local
			tuple_type_i: TUPLE_TYPE_I
		do
			tuple_type_i ?= other
			if tuple_type_i /= Void then
				Result := (is_true_expanded = tuple_type_i.is_true_expanded)
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

			create Result.make (array)
			Result.set_base_class_id (base_id)
			Result.set_is_true_expanded (is_true_expanded)
		end

	il_type_name: STRING is
			-- Class name of current type.
		do
			Result := clone (base_class.external_class_name)
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
			buffer.putint (Tuple_type)
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

			ba.append_short_integer (Tuple_type)
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

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			i, up, dummy : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an anchored type 
				cr_info.generate_cid_array (buffer, final_mode, idx_cnt)
			end
			buffer.putint (Tuple_type)
			buffer.putstring (", ")
			buffer.putint (0)
			buffer.putstring (", ")
			buffer.putint (true_generics.count)
			buffer.putstring (", ")
			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")

			-- Increment counter by 4
			dummy := idx_cnt.next
			dummy := idx_cnt.next
			dummy := idx_cnt.next
			dummy := idx_cnt.next

			from
				i  := true_generics.lower
				up := true_generics.upper
			until
				i > up
			loop
				true_generics.item (i).generate_cid_array (buffer, 
												final_mode, use_info, idx_cnt)
				i := i + 1
			end
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			i, up, dummy : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an anchored type 
				cr_info.generate_cid_init (buffer, final_mode, idx_cnt)
			end

			-- Increment counter by 4
			dummy := idx_cnt.next
			dummy := idx_cnt.next
			dummy := idx_cnt.next
			dummy := idx_cnt.next

			from
				i  := true_generics.lower
				up := true_generics.upper
			until
				i > up
			loop
				true_generics.item (i).generate_cid_init (buffer, 
												final_mode, use_info, idx_cnt)
				i := i + 1
			end
		end

end -- class TUPLE_TYPE_I

