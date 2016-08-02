note
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
			is_tuple, internal_conform_to, process, valid_generic,
			il_type_name, generate_gen_type_instance, same_generic_derivation_as,
			generic_derivation, generate_cid_prefix, make_type_prefix_byte_code
		end

create
	make

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_tuple_type_a (Current)
		end

feature -- Properties

	is_tuple: BOOLEAN = True

	is_basic_uniform: BOOLEAN
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
				if not l_generics.i_th (i).is_basic then
					Result := False
					i := nb + 1
				else
					i := i + 1
				end
			end
		end

feature -- Access

	generic_derivation: TUPLE_TYPE_A
		do
				-- Since the generic derivation for a TUPLE does not have actual generic parameter
				-- we simply create a copy of current without actuals.
			create Result.make (class_id, create {ARRAYED_LIST [TYPE_A]}.make (0))
			Result.set_mark (declaration_mark)
		end

feature -- Comparison

	same_generic_derivation_as (current_type, other: TYPE_A): BOOLEAN
		do
				-- For TUPLE, it is just enough that they are
				-- either both reference or both expanded.
			if attached {TUPLE_TYPE_A} other as t then
				Result := is_expanded = t.is_expanded
			end
		end

feature -- Generic conformance

	generate_gen_type_instance (il_generator: IL_CODE_GENERATOR; n: INTEGER)
			-- Generic runtime instance for Current
		do
			il_generator.generate_tuple_type_instance (n)
		end

feature {NONE} -- Generic conformance

	generate_cid_prefix (buffer: detachable GENERATION_BUFFER; idx_cnt: COUNTER)
			-- <Precursor>
		local
			l_dummy: INTEGER
		do
			Precursor (buffer, idx_cnt)
				-- If `buffer' was provided, outputs tuple specification.
			if buffer /= Void then
				buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.tuple_type)
				buffer.put_character (',')
				buffer.put_integer (generics.count)
				buffer.put_character (',')
			end
				-- If counter was provided, increments it.
			if idx_cnt /= Void then
				l_dummy := idx_cnt.next
				l_dummy := idx_cnt.next
			end
		end

	make_type_prefix_byte_code (ba: BYTE_ARRAY)
			-- <Precursor>
		do
			Precursor (ba)
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.tuple_type)
			ba.append_short_integer (generics.count)
		end

feature -- IL code generation

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING
			-- Class name of current type.
		local
			l_class_c: like base_class
			l_is_precompiled: BOOLEAN
			l_cl_type: like associated_class_type
		do
			l_class_c := base_class
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

	good_generics: BOOLEAN

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
				Result := generics.i_th (i).good_generics
				i := i + 1
			end
		end

	error_generics: VTUG

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
				if not generics.i_th (i).good_generics then
					Result := generics.i_th (i).error_generics
				end
				i := i + 1
			end
		end

	check_constraints (context_class: CLASS_C; a_context_feature: FEATURE_I;  a_check_creation_readiness: BOOLEAN)
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
				gen_param := generics.i_th (i)
					-- Creation readiness check is set to false because:
					--  * one cannot inherit from TUPLE
					--  * there is no expanded entity
				gen_param.check_constraints (context_class, a_context_feature, False)
				i := i + 1
			end
		end

feature {TYPE_A} -- Helpers

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		local
			i, count, other_count: INTEGER
			other_generics: like generics
		do
			if attached {TUPLE_TYPE_A} other as l_other_tuple_type then
					-- Conformance TUPLE -> TUPLE
				other_generics := l_other_tuple_type.generics
				count := generics.count
				other_count := other_generics.count
				if a_in_generic then
					if l_other_tuple_type.is_frozen then
						Result := is_frozen and then count = other_count
					elseif not l_other_tuple_type.is_variant then
						Result := not is_variant and then count = other_count
					else
						check is_variant: l_other_tuple_type.is_variant end
						Result := count >= other_count
					end
				else
					Result := count >= other_count
				end
				if Result then
					from
						i := 1
						Result := (a_context_class.lace_class.is_void_safe_conformance implies is_attachable_to (l_other_tuple_type)) and then
							is_processor_attachable_to (l_other_tuple_type)
					until
						(i > other_count) or else (not Result)
					loop
						Result := generics.i_th (i).internal_conform_to (a_context_class, other_generics.i_th (i), True)
						i := i + 1
					end
				end
			else
					-- Conformance TUPLE -> other classtypes
				Result := Precursor {GEN_TYPE_A} (a_context_class, other, a_in_generic)
			end
		end

	valid_generic (a_context_class: CLASS_C; type: CL_TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- Check generic parameters
		local
			i, nb: INTEGER
			l_tuple_generics: like generics
		do
			if attached {TUPLE_TYPE_A} type as l_tuple then
				from
					i := 1
					l_tuple_generics := l_tuple.generics
					nb := generics.count
					Result := nb <= l_tuple_generics.count
				until
					i > nb or else not Result
				loop
					Result := l_tuple_generics.i_th (i).internal_conform_to (a_context_class, generics.i_th (i), True)
					i := i + 1
				end
			else
				Result := Precursor {GEN_TYPE_A} (a_context_class, type, a_in_generic)
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
