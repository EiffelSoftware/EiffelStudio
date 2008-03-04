indexing
	description: "Description of a TUPLE type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_TYPE_A

inherit
	GEN_TYPE_A
		redefine
			good_generics, error_generics, check_constraints,
			is_tuple, conform_to, process, valid_generic, generate_cid,
			generate_cid_array, generate_cid_init, make_gen_type_byte_code,
			il_type_name, generate_gen_type_instance, same_generic_derivation_as,
			generic_derivation
		end

create
	make

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_tuple_type_a (Current)
		end

feature -- Properties

	is_tuple: BOOLEAN is True

	is_basic_uniform: BOOLEAN is
			-- Are all types in Current basic?
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				l_generics := generics
				i := l_generics.lower
				nb := l_generics.upper
				Result := True
			until
				i > nb
			loop
				if not l_generics.item (i).is_basic then
					Result := False
					i := nb + 1
				else
					i := i + 1
				end
			end
		end

feature -- Access

	generic_derivation: TUPLE_TYPE_A is
		do
				-- Since the generic derivation for a TUPLE does not has actual generic parameter
				-- we simply create a copy of current without actuals.
			create Result.make (class_id, create {ARRAY [TYPE_A]}.make (1, 0))
			Result.set_mark (declaration_mark)
		end

feature -- Comparison

	same_generic_derivation_as (current_type, other: TYPE_A): BOOLEAN is
		do
				-- For TUPLE, it is just enough that they are
				-- either both reference or both expanded.
			if {t: !TUPLE_TYPE_A} other then
				Result := is_expanded = t.is_expanded
			end
		end

feature -- Generic conformance

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A) is
		do
			buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.tuple_type)
			buffer.put_character (',')
			buffer.put_integer (generics.count)
			buffer.put_character (',')

			Precursor (buffer, final_mode, use_info, a_context_type)
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A) is
		local
			dummy: INTEGER
		do
			buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.tuple_type)
			buffer.put_character (',')
			buffer.put_integer (generics.count)
			buffer.put_character (',')

				-- Increment counter by an additional 2 (mark for tuple type and count)
			dummy := idx_cnt.next
			dummy := idx_cnt.next

			Precursor (buffer, final_mode, use_info, idx_cnt, a_context_type)
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL) is
		local
			dummy: INTEGER
		do
				-- Increment counter by an additional 2 (mark for tuple type and count)
			dummy := idx_cnt.next
			dummy := idx_cnt.next

			Precursor (buffer, final_mode, use_info, idx_cnt, a_level)
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN; a_context_type: TYPE_A) is
		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.tuple_type)
			ba.append_short_integer (generics.count)
			Precursor (ba, use_info, a_context_type)
		end

	generate_gen_type_instance (il_generator: IL_CODE_GENERATOR; n: INTEGER) is
			-- Generic runtime instance for Current
		do
			il_generator.generate_tuple_type_instance (n)
		end

feature -- IL code generation

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING is
			-- Class name of current type.
		local
			l_class_c: like associated_class
			l_is_precompiled: BOOLEAN
			l_cl_type: like associated_class_type
		do
			l_class_c := associated_class
			l_is_precompiled := l_class_c.is_precompiled
			if l_is_precompiled then
				l_cl_type := associated_class_type (a_context_type)
				l_is_precompiled := l_cl_type.is_precompiled
				if l_is_precompiled then
					Result := l_cl_type.il_type_name (a_prefix)
				end
			end
			if not l_is_precompiled then
				Result := internal_il_type_name (l_class_c.name.twin, a_prefix)
			end
		end

feature {COMPILER_EXPORTER} -- Primitives

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Check generic parameters
		local
			i, nb: INTEGER
			l_tuple: TUPLE_TYPE_A
			l_tuple_generics: like generics
		do
			l_tuple ?= type
			if l_tuple /= Void then
				from
					i := 1
					l_tuple_generics := l_tuple.generics
					nb := generics.count
					Result := nb <= l_tuple_generics.count
				until
					i > nb or else not Result
				loop
					Result := l_tuple_generics.item (i).conform_to (generics.item (i))
					i := i + 1
				end
			else
				Result := Precursor {GEN_TYPE_A} (type)
			end
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			tuple_type: TUPLE_TYPE_A
			i, count, other_count: INTEGER
			other_generics: ARRAY [TYPE_A]
		do
			tuple_type ?= other

			if tuple_type /= Void then
					-- Conformance TUPLE -> TUPLE
				other_generics := tuple_type.generics
				from
					i := 1
					count := generics.count
					other_count := other_generics.count
					Result := count >= other_count and then is_attachable_to (tuple_type)
				until
					(i > other_count) or else (not Result)
				loop
					Result := generics.item (i).conform_to (
						other_generics.item (i))
					i := i + 1
				end
			else
					-- Conformance TUPLE -> other classtypes
				Result := Precursor {GEN_TYPE_A} (other)
			end
		end

	good_generics: BOOLEAN is

		local
			i, count: INTEGER
		do
			-- Any number of generic parameters is allowed.
			-- Therefore we only check the gen. parameters.
			from
				Result := True
				count := generics.count
				i := 1
			until
				i > count or else not Result
			loop
				Result := generics.item (i).good_generics
				i := i + 1
			end
		end

	error_generics: VTUG is

		local
			i, count: INTEGER
		do
			-- Any number of generic parameters is allowed.
			-- Therefore we only check the gen. parameters.
			from
				count := generics.count
				i := 1
			until
				i > count or else (Result /= Void)
			loop
				if not generics.item (i).good_generics then
					Result := generics.item (i).error_generics
				end
				i := i + 1
			end
		end

	check_constraints (context_class: CLASS_C; a_context_feature: FEATURE_I;  a_check_creation_readiness: BOOLEAN) is
			-- Check the constrained genericity validity rule
		local
			i, count: INTEGER
			gen_param: TYPE_A
		do
				-- There are no constraints in a TUPLE type.
				-- Therefore we only check the gen. parameters.
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				gen_param := generics.item (i)
					-- Creation readiness check is set to false because:
					--  * one cannot inherit from TUPLE
					--  * there is no expanded entity
				gen_param.check_constraints (context_class, a_context_feature, False)
				i := i + 1
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class TUPLE_TYPE_A

