indexing
	description: "Descritpion of an actual generical type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GEN_TYPE_I

inherit
	CL_TYPE_I
		rename
			make as old_make
		redefine
			anchor_instantiation_in,
			description,
			dump,
			duplicate,
			generate_cid_array,
			generate_cid_init,
			generate_gen_type_il,
			internal_generic_derivation,
			generic_il_type_name,
			generate_cid,
			has_actual,
			has_formal,
			has_true_formal,
			il_type_name,
			instantiation_in,
			is_anchored,
			is_equal,
			is_explicit,
			is_identical,
			is_standalone,
			is_consistent,
			is_valid,
			make_full_type_byte_code_parameters,
			make_gen_type_byte_code,
			meta_generic,
			name,
			same_as,
			true_generics,
			type_a
		end

create
	make

feature {NONE} -- Initialization

	make (an_id: like class_id; a_mgen: like meta_generic; a_tgen: like true_generics) is
			-- New instance of a type based on a class of id `an_id'
			-- and with `a_tgen' as generic paramters.
		require
			an_id_positive: an_id > 0
			a_mgen_not_void: a_mgen /= Void
			a_tgen_not_void: a_tgen /= Void
		do
			old_make (an_id)
			meta_generic := a_mgen
			true_generics := a_tgen
		ensure
			class_id_set: class_id = an_id
			meta_generic_set: meta_generic = a_mgen
			true_generics_set: true_generics = a_tgen
		end

feature -- Access

	meta_generic: META_GENERIC
			-- Meta generic description of the type class

	true_generics : ARRAY [TYPE_I]
			-- True generic types.

	description: ATTR_DESC is
			-- Descritpion of type for skeletons.
		local
			gen_desc: GENERIC_DESC
		do
			if has_formal or else is_anchored then
				create gen_desc
				gen_desc.set_type_i (Current)
				Result := gen_desc
			else
				Result := Precursor
			end
		end

feature {GEN_TYPE_I} -- Settings

	set_meta_generic (m: META_GENERIC) is
			-- Assign `m' to `meta_generic'.
		require
			m_not_void: m /= Void
		do
			meta_generic := m
		ensure
			meta_generic_set: meta_generic = m
		end

	set_true_generics (tgen: ARRAY [TYPE_I]) is
			-- Assign `tgen' to `true_generics'.
		require
			tgen_not_void: tgen /= Void
		do
			true_generics := tgen
		ensure
			true_generics_set: true_generics = tgen
		end

feature -- Status Report

	is_consistent: BOOLEAN is
			-- Are all the base classes still in the system ?
		local
			l_base_class: like base_class
			g: TYPE_I
			h: TYPE_I
			i: INTEGER
			m: like meta_generic
			t: like true_generics
		do
			l_base_class := base_class
			Result := l_base_class /= Void and then
				(l_base_class.generics /= Void and then
					l_base_class.generics.count = meta_generic.count) and then
				meta_generic.is_consistent
			if Result then
					-- Ensure that `true_generics' are consistent and
					-- the reattachment semantics for `meta_generics' and `true_generics' matches
				from
					m := meta_generic
					t := true_generics
					i := t.count
				until
					i <= 0
				loop
					g := t.item (i)
					h := m.item (i)
					if
						not g.is_consistent or else
						h.is_expanded and then g.is_reference or else
						g.is_expanded and then h.is_reference
					then
						Result := False
						i := 1
					end
					i := i - 1
				end
			end
		end

	is_valid (a_class: CLASS_C): BOOLEAN is
			-- Is Current consistent and valid for `a_class'?
		do
			Result := base_class /= Void and then
				(base_class.generics /= Void and then
					base_class.generics.count = meta_generic.count) and then
				meta_generic.is_valid (a_class)
		end

	duplicate: like Current is
			-- Duplication
		do
			Result := twin
			Result.set_meta_generic (meta_generic.twin)
			Result.set_true_generics (true_generics.twin)
		end

	instantiation_in (other: CLASS_TYPE): like Current is
			-- Instantiation of Current in context of `other'
		local
			i, count: INTEGER
			l_meta, meta_gen: like meta_generic
			l_true, true_gen: like true_generics
			old_meta_gen, new_meta_gen: TYPE_I
			old_true_gen, new_true_gen: TYPE_I
		do
			from
				l_meta := meta_generic
				l_true := true_generics
				i := 1
				count := l_meta.count
			until
				i > count
			loop
				old_meta_gen := l_meta.item (i)
				new_meta_gen := old_meta_gen.instantiation_in (other)
				old_true_gen := l_true.item (i)
				new_true_gen := old_true_gen.complete_instantiation_in (other)
				if old_meta_gen /= new_meta_gen or else old_true_gen /= new_true_gen then
					if Result = Void then
						Result := duplicate
						meta_gen := Result.meta_generic
						true_gen := Result.true_generics
					end
					meta_gen.put (new_meta_gen, i)
					true_gen.put (new_true_gen, i)
				end
				i := i + 1
			end
			if Result = Void then
				Result := Current
			end
		end

	anchor_instantiation_in (other: CLASS_TYPE): CL_TYPE_I is
			-- Instantation of `like Current' parts of Current in `other'
		local
			i, count: INTEGER
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
				meta_gen.put (l_meta.item (i).anchor_instantiation_in (other), i)
				true_gen.put (l_true.item (i).anchor_instantiation_in (other), i)
				i := i + 1
			end
		end

	is_anchored: BOOLEAN is
			-- Does type contain anchored type?
		local
			i: INTEGER
			l_true: like true_generics
		do
			from
				l_true := true_generics
				i := l_true.count
			until
				i <= 0 or else Result
			loop
				Result := l_true.item (i).is_anchored
				i := i - 1
			end
		end

	is_explicit: BOOLEAN is
			-- Is Current type fixed at compile time?
		local
			i, count: INTEGER
			l_true: like true_generics
		do
			if cr_info /= Void then
				Result := cr_info.is_explicit
			else
				from
					Result := True
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
		end

	is_standalone: BOOLEAN is
			-- Is type standalone, i.e. does not depend on formal generic or acnhored type?
		local
			i: INTEGER
			l_true: like true_generics
		do
			Result := True
			from
				l_true := true_generics
				i := l_true.count
			until
				i <= 0 or else not Result
			loop
				Result := l_true.item (i).is_standalone
				i := i - 1
			end
		end

	has_formal: BOOLEAN is
			-- Are some meta formals present in `meta_generic'?
		local
			i, count: INTEGER
			l_meta: like meta_generic
			l_true: like true_generics
			l_type: TYPE_I
		do
			from
				i := 1
				l_meta := meta_generic
				l_true := true_generics
				count := l_meta.count
			until
				i > count or else Result
			loop
				Result := l_meta.item (i).has_formal
				if not Result then
						-- Let's check that each entry in `true_generics' does not
						-- have a formal. If the entry is a formal generic parameter,
						-- then it does not count since `meta_generics' tell us it is not
						-- a formal already, i.e. it has already been instantiated properly.
						-- The idea here is to ensure that the `meta_generic' part of the
						-- `true_generics' items does not have a formal.
					l_type := l_true.item (i)
					Result := not l_type.is_formal and then l_type.has_formal
				end
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

	name: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		local
			i, nb: INTEGER
			l_true: like true_generics
		do
			Result := Precursor {CL_TYPE_I}
			from
				i := 1
				l_true := true_generics
				nb := l_true.count
				if nb > 0 then
					Result.append_string (" [")
				end
			until
				i > nb
			loop
				Result.append (l_true.item (i).name)
				if i < nb then
					Result.append_character (',')
					Result.append_character (' ')
				end
				i := i + 1
			end
			if nb > 0 then
				Result.append_character (']')
			end
		end

	dump (buffer: GENERATION_BUFFER) is
			-- String that should be displayed in debugger to represent `Current'.
		local
			i, nb: INTEGER
			l_meta: like meta_generic
		do
			buffer.put_string (base_name)
			from
				i := 1
				l_meta := meta_generic
				nb := l_meta.count
				if nb > 0 then
					buffer.put_string (" [")
				end
			until
				i > nb
			loop
				l_meta.item (i).dump (buffer)
				if i < nb then
					buffer.put_character (',')
					buffer.put_character (' ')
				end
				i := i + 1
			end
			if nb > 0 then
				buffer.put_character (']')
			end
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class
		local
			i, count: INTEGER
			sep, tmp: STRING
			l_meta: like meta_generic
			l_class_c: like base_class
			l_is_precompiled: BOOLEAN
			l_cl_type: like associated_class_type
		do
			l_class_c := base_class
			l_is_precompiled := l_class_c.is_precompiled
			if l_is_precompiled then
				l_cl_type := associated_class_type
				l_is_precompiled := l_cl_type.is_precompiled
				if l_is_precompiled then
					Result := associated_class_type.il_type_name (a_prefix)
				end
			end
			if not l_is_precompiled then
				Result := l_class_c.name.twin

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
						tmp := l_meta.item (i).generic_il_type_name.twin
						tmp.remove_head (tmp.last_index_of ('.', tmp.count))
						Result.append (tmp)
						i := i + 1
					end
				end

				Result := internal_il_type_name (Result, a_prefix)
			end
		end

	generic_il_type_name: STRING is
			-- Associated name to for naming in generic derivation.
		do
			Result := il_type_name (Void)
		end

	internal_generic_derivation (a_level: INTEGER): like Current is
			-- Precise generic derivation of current type.
		local
			c: like cr_info
			i, count: INTEGER
			l_meta, meta_gen: like meta_generic
			l_true, true_gen: like true_generics
			l_type: TYPE_I
		do
			from
					-- Remove creation information.
				c := cr_info
				cr_info := Void
				Result := duplicate
				cr_info := c
				l_meta := meta_generic
				l_true := true_generics
				meta_gen := Result.meta_generic
				true_gen := Result.true_generics
				i := 1
				count := l_meta.count
			until
				i > count
			loop
				l_type := l_meta.item (i)
				if l_type.is_reference then
					meta_gen.put (reference_c_type, i)
				else
					meta_gen.put (l_type.internal_generic_derivation (a_level + 1), i)
				end

				l_type := l_true.item (i)
				if l_type.is_reference then
					true_gen.put (create {FORMAL_I}.make (True, False, i), i)
				else
						-- We have an expanded type
					if l_type.is_true_expanded and then not system.il_generation then
						true_gen.put (create {FORMAL_I}.make (False, False, i), i)
					else
							-- We have a basic type, as an optimization, we
							-- store the basic type data, rather than a formal
							-- generic paramter to save some time at run-time
							-- when computing the dynamic type.
						true_gen.put (l_type.internal_generic_derivation (a_level + 1), i)
					end
				end
				i := i + 1
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
			create Result.make (class_id, array)
			Result.set_mark (declaration_mark)
		end

feature {NONE} -- Generic conformance

	make_full_type_byte_code_parameters (ba: BYTE_ARRAY) is
			-- Generate type information for generic parameters.
		do
			ba.append_short_integer (system.byte_context.current_type.generated_id (False))
			make_gen_type_byte_code (ba, True)
		end

feature {GEN_TYPE_I} -- Generic conformance

	enumerate_interfaces_recursively (processor: PROCEDURE [ANY, TUPLE [CLASS_TYPE]]; n: INTEGER) is
			-- Enumerate all class types for which an object of this type can be attached to
			-- using `n' as an upper bound for generic parameters that can be changed.
		require
			processor_attached: processor /= Void
			valid_n: 1 <= n and n <= meta_generic.count
		local
			gen_type: GEN_TYPE_I
			parameter: TYPE_I
			other_parameter: TYPE_I
			cl_type: CL_TYPE_I
			types: TYPE_LIST
			cursor: ARRAYED_LIST_CURSOR
			i: INTEGER
		do
				-- Enumerate types where expanded parameters are replaced with reference ones.
				-- Take into account only registered generic derivations.
			if n > 4  then
					-- It's faster to scan registered class types rather than to generate conforming ones.
				from
					types := base_class.types
					cursor := types.cursor
					types.start
				until
					types.after
				loop
					cl_type := types.item.type
						-- Check only types that differ from current one.
					if cl_type /= Current then
						gen_type ?= cl_type
						check
							gen_type_attached: gen_type /= Void
						end
							-- Ensure the type is reference.
						if gen_type.is_reference then
							from
								i := meta_generic.count
							until
								i <= 0
							loop
								parameter := meta_generic.item (i)
								other_parameter := gen_type.meta_generic.item (i)
								if
									parameter.same_as (other_parameter) or else
									parameter.is_expanded and then other_parameter.same_as (reference_c_type)
								then
										-- Continue processing.
								else
										-- Types differ. Stop processing.
									i := 0
								end
								i := i - 1
							end
							if i = 0 then
								processor.call ([types.item])
							end
						end
					end
					types.forth
				end
				types.go_to (cursor)
			else
				from
					i := n
				until
					i <= 0
				loop
					parameter := true_generics [i]
					if parameter.is_expanded then
						gen_type := duplicate
						gen_type.set_reference_mark
						cl_type ?= parameter
						check
							cl_type_attached: cl_type /= Void
						end
						gen_type.true_generics [i] := cl_type.reference_type
						gen_type.meta_generic [i] := reference_c_type
						if base_class.types.has_type (gen_type) then
							processor.call ([gen_type.associated_class_type])
						end
						if i > 1 then
							gen_type.enumerate_interfaces_recursively (processor, i - 1)
						end
					end
					i := i - 1
				end
			end
		end

feature -- Generic conformance

	enumerate_interfaces (processor: PROCEDURE [ANY, TUPLE [CLASS_TYPE]]) is
			-- Enumerate all class types for which an object of this type can be attached to.
		require
			processor_attached: processor /= Void
		do
			-- TODO:
			-- 1. Rule out generic types with too many generic parameters to
			-- avoid explosure of artificially introduced types.
			-- 2. Ensure generated code works as expected.
			-- 3. Remove validity rule that prevents reattaching derivations
			-- with expanded parameters to derivations with reference parameters.
			enumerate_interfaces_recursively (processor, meta_generic.count)
		end

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN) is
		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type
				cr_info.generate_cid (buffer, final_mode)
			else
				buffer.put_integer (generated_id (final_mode))
				buffer.put_character (',')

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
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is
		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type
				cr_info.make_gen_type_byte_code (ba)
			else
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
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			i, up, dummy : INTEGER
		do
			if use_info and then (cr_info /= Void) then
					-- It's an anchored type
				cr_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
				buffer.put_integer (generated_id (final_mode))
				buffer.put_character (',')

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
		end

	generate_cid_init (buffer : GENERATION_BUFFER;
					   final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			i, up, dummy : INTEGER
		do
			if use_info and then (cr_info /= Void) then
					-- It's an anchored type
				cr_info.generate_cid_init (buffer, final_mode, idx_cnt)
			else
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
		end

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info : BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		local
			i, up : INTEGER
		do
			if use_info and then cr_info /= Void then
				cr_info.generate_il_type
			else
				generate_gen_type_instance (il_generator, true_generics.count)

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
					il_generator.generate_array_write ({IL_CONST}.il_ref, 0)
					i := i + 1
				end

				il_generator.generate_generic_type_settings (Current)
			end
		end

	generate_gen_type_instance (il_generator: IL_CODE_GENERATOR; n: INTEGER) is
			-- Generic runtime instance for Current
		require
			il_generator_not_void: il_generator /= Void
			n_non_negative: n >= 0
		do
			il_generator.generate_generic_type_instance (n)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := same_as (other)
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
				Result := class_id = gen_type_i.class_id
						and then is_expanded = gen_type_i.is_expanded
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
		do
			if {l_gen_type_i: !GEN_TYPE_I} other then
				Result := class_id = l_gen_type_i.class_id
						-- 'class_id' is the same therefore we can just compare if the marks are set.
					and then declaration_mark /= l_gen_type_i.declaration_mark implies (has_separate_mark = l_gen_type_i.has_separate_mark and then has_expanded_mark = l_gen_type_i.has_expanded_mark)
					and then meta_generic.same_as (l_gen_type_i.meta_generic)
			end
		end

	has_actual (type: CL_TYPE_I): BOOLEAN is
			-- Is `type' an (possibly nested) actual parameter of this type?
		local
			i: INTEGER
			p: ARRAY [TYPE_I]
			cl_type_i: CL_TYPE_I
		do
			from
				p := meta_generic
				i := p.lower
			until
				i > p.upper or else Result
			loop
				cl_type_i ?= p [i]
				if cl_type_i /= Void then
					Result := cl_type_i.same_as (type) or else cl_type_i.has_actual (type)
				end
				i := i + 1
			end
		end

invariant
	meta_generic_not_void: meta_generic /= Void
	true_generics_not_void: true_generics /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class GEN_TYPE_I
