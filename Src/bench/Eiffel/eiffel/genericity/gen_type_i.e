indexing
	description: "Descritpion of an actual generical type."
	date: "$Date$"
	revision: "$Revision$"

class
	GEN_TYPE_I

inherit
	CL_TYPE_I
		redefine
			meta_generic,
			true_generics,
			same_as, is_equal,
			is_identical,
			is_valid,
			is_explicit,
			has_formal,
			has_true_formal,
			instantiation_in,
			creation_instantiation_in,
			dump,
			il_type_name,
			append_signature,
			type_a,
			generate_cid,
			make_gen_type_byte_code,
			generate_cid_array,
			generate_cid_init,
			generate_gen_type_il
		end

feature -- Access

	meta_generic: META_GENERIC
			-- Meta generic description of the type class

	set_meta_generic (m: META_GENERIC) is
			-- Assign `m' to `meta_generic'.
		do
			if m = Void then
				-- TUPLE without generic parameters
				create meta_generic.make (0)
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
				create true_generics.make (1,0)
			else
				true_generics := tgen
			end
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
			i		: INTEGER
			count	: INTEGER
			l_meta, meta_gen: like meta_generic
			l_true, true_gen: like true_generics
		do
			from
				Result := duplicate
				l_meta := meta_generic
				l_true := true_generics
				meta_gen := Result.meta_generic
				true_gen := Result.true_generics
				i := 1
				count := l_meta.count
			until
				i > count
			loop
				meta_gen.put (l_meta.item (i).instantiation_in (other), i)
				true_gen.put (l_true.item (i).complete_instantiation_in (other), i)
				i := i + 1
			end
		end

	creation_instantiation_in (other: like Current): like Current is
			-- Instantiation of Current in context of `other'
		local
			i		: INTEGER
			count	: INTEGER
			l_meta, meta_gen: like meta_generic
			l_true, true_gen: like true_generics
		do
			from
				Result := duplicate
				l_meta := meta_generic
				l_true := true_generics
				meta_gen := Result.meta_generic
				true_gen := Result.true_generics
				i := 1
				count := l_meta.count
			until
				i > count
			loop
				meta_gen.put (l_meta.item (i).instantiation_in (other), i)
				true_gen.put (l_true.item (i).creation_instantiation_in (other), i)
				i := i + 1
			end
		end

	is_explicit: BOOLEAN is

		local
			i, count: INTEGER
			l_true: like true_generics
		do
			Result := (cr_info = Void)

			from
				i := 1
				l_true := true_generics
				count := l_true.count
			until
				i > count or else not Result
			loop
				Result := l_true.item (i).is_explicit
				i := i + 1
			end
		end

	has_formal: BOOLEAN is
			-- Are some meta formals present in `meta_generic' ?
		local
			i, count: INTEGER
			l_meta: like meta_generic
		do
			from
				i := 1
				l_meta := meta_generic
				count := l_meta.count
			until
				i > count or else Result
			loop
				Result := l_meta.item (i).has_formal
				i := i + 1
			end
		end

	has_true_formal: BOOLEAN is
			-- Are some formals present in `true_generic' ?
		local
			i, count: INTEGER
			l_true: like true_generics
		do
			from
				i := 1
				l_true := true_generics
				count := l_true.count
			until
				i > count or else Result
			loop
				Result := l_true.item (i).has_true_formal
				i := i + 1
			end
		end

	dump (buffer: GENERATION_BUFFER) is
		local
			i, count: INTEGER
			s: STRING
			l_meta: like meta_generic
		do
			if is_true_expanded then
				buffer.putstring ("expanded ")
			end
			s := clone (base_class.name)
			s.to_upper
			buffer.putstring (s)
			l_meta := meta_generic
			count := l_meta.count

			if count > 0 then
				from
					buffer.putstring (" [")
					i := 1
				until
					i > count
				loop
					l_meta.item (i).dump (buffer)

					if i < count then
						buffer.putstring (", ")
					end
					i := i + 1
				end
				buffer.putchar (']')
			end
		end

	il_type_name: STRING is
			-- Name of current class
		local
			i, count: INTEGER
			sep, tmp: STRING
			l_meta: like meta_generic
		do
			Result := Precursor {CL_TYPE_I}

			l_meta := meta_generic

				-- Append generic information.
			count := l_meta.count
			if count > 0 then
				from
					i := 1
					sep := "_"
				until
					i > count
				loop
					Result.append (sep)
					tmp := clone (l_meta.item (i).il_type_name)
					tmp.remove_head (tmp.last_index_of ('.', tmp.count))
					Result.append (tmp)
					i := i + 1
				end
			end
		end

	append_signature (st: STRUCTURED_TEXT) is
		local
			i, count: INTEGER
			l_meta: like meta_generic
		do
			l_meta := meta_generic

			if is_true_expanded then
				st.add_string ("expanded ")
			end
			base_class.append_name (st)
			count := l_meta.count

			if count > 0 then
				from
					st.add_string (" [")
					i := 1
				until
					i > count
				loop
					l_meta.item (i).append_signature (st)
					if i < count then
						st.add_string (", ")
					end
					i := i + 1
				end
				st.add_char (']')
			end
		end

	type_a: GEN_TYPE_A is
		local
			i: INTEGER
			array: ARRAY [TYPE_A]
			l_meta: like meta_generic
		do
			from
				l_meta := meta_generic
				i := l_meta.count
				create array.make (1, i)
			until
				i = 0
			loop
				array.put (l_meta.item (i).type_a, i)
				i := i - 1
			end
			create Result.make (array)
			Result.set_base_class_id (base_id)
			Result.set_is_true_expanded (is_true_expanded)
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

			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")

			-- Increment counter
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

			-- Increment counter
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

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info : BOOLEAN) is
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		local
			i, up : INTEGER
		do
			il_generator.generate_generic_type_instance (true_generics.count)
			
			from
				i  := true_generics.lower
				check
					i_start_at_one: i = 1
				end
				up := true_generics.upper
			until
				i > up
			loop
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (i - 1)
				true_generics.item (i).generate_gen_type_il (il_generator, use_info)
				il_generator.generate_array_write (feature {IL_CONST}.il_ref)
				i := i + 1
			end
			
			il_generator.generate_generic_type_settings (Current)
		end

feature {NONE} -- Implementation: generic conformance

	generate_gen_type_il_array_init (il_generator: IL_CODE_GENERATOR; cnt: INTEGER) is
			-- Generate new array type containing info of `cnt' about Current
		require
			il_generator_not_void: il_generator /= Void
			cnt_not_void: cnt /= Void
		do
				-- duplicate newly created object
			il_generator.duplicate_top

				-- Create array that will hold values to create appropriate
				-- type in case of an instance of a generic type.
			il_generator.put_integer_32_constant (cnt)
			il_generator.generate_array_creation (il_generator.type_id)
		end
		
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := base_id = other.base_id
					and then is_true_expanded = other.is_true_expanded
					and then is_separate = other.is_separate
					and then meta_generic.same_as (other.meta_generic)
		end

	is_identical (other: TYPE_I): BOOLEAN is
			-- Is `other' identical to Current ?
			-- Also compare `true_generics'!
		local
			i, count: INTEGER
			local_copy: like true_generics
			other_gen: like true_generics
			gen_type_i: GEN_TYPE_I
		do
			gen_type_i ?= other
			if gen_type_i /= Void then
				Result := base_id = gen_type_i.base_id
						and then is_true_expanded = gen_type_i.is_true_expanded
						and then is_separate = gen_type_i.is_separate
						and then meta_generic.same_as (gen_type_i.meta_generic)
				from
					i := 1
					local_copy := true_generics
					count := local_copy.count
					other_gen := gen_type_i.true_generics
				until
					i > count or else not Result
				loop
					Result := local_copy.item (i).is_identical (other_gen.item (i))
					i := i + 1
				end
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
				Result := base_id = gen_type_i.base_id
						and then is_true_expanded = gen_type_i.is_true_expanded
						and then is_separate = gen_type_i.is_separate
						and then meta_generic.same_as (gen_type_i.meta_generic)
			end
		end

end -- class GEN_TYPE_I
