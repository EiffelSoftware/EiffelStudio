indexing
	description: "Representation of a compiled formal parameter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_I

inherit
	TYPE_I
		redefine
			is_formal, same_as, has_true_formal, has_formal, instantiation_in,
			complete_instantiation_in,
			generated_id, is_explicit, generate_gen_type_il,
			generate_cid, generate_cid_array, generate_cid_init,
			make_gen_type_byte_code, is_reference, is_expanded, is_standalone
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (is_ref: like is_reference; is_exp: like is_expanded; i: like position) is
			-- Assign `i' to `position'.
		require
			valid_position: i > 0
		do
			is_reference := is_ref
			is_expanded := is_exp
			position := i
		ensure
			is_reference_set: is_reference = is_ref
			is_expanded_set: is_expanded = is_exp
			position_set: position = i
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Formal element type.
		do
				-- Before we said that we should not be called, but now there is one case
				-- where we are called, it is when we try to create a NATIVE_ARRAY [G] where
				-- G is a formal generic parameter. In this case we actually considered that
				-- we have for the type system a NATIVE_ARRAY [SYSTEM_OBJECT].
			Result := {MD_SIGNATURE_CONSTANTS}.element_type_object
		end

	tuple_code: INTEGER_8 is
			-- Formal tuple code. Should not be called.
		do
			check
				False
			end
		end

feature -- Access

	position: INTEGER
			-- Position of the formal in declarations

	is_reference: BOOLEAN
			-- Is current constrained to be always a reference?

	is_expanded: BOOLEAN
			-- Is current constrained to be always an expanded?

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + position
		end

	description: GENERIC_DESC is
			-- Descritpion of type for skeletons.
		do
			create Result
			Result.set_type_i (Current)
		end

feature -- Status report

	is_formal: BOOLEAN is True
			-- Is the type a formal type ?

	is_explicit: BOOLEAN is False

	is_standalone: BOOLEAN is False
			-- Is type standalone, i.e. does not depend on formal generic or acnhored type?

	has_true_formal, has_formal: BOOLEAN is True
			-- Has the type formal in its structure ?

	instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantiation of Current in context of `other'
		do
			Result := other.type.meta_generic.item (position)
		end

	complete_instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantiation of Current in context of `other'.
		do
			Result := other.type.true_generics.item (position)
		end

	name: STRING is
			-- Name of current type.
		do
			create Result.make (3)
			Result.append ("G#")
			Result.append_integer (position)
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		do
			Result := name
		end

	type_a: FORMAL_A is
			-- Associated FORMAL_A object.
		do
			create Result.make (is_reference, is_expanded, position)
		end

feature -- Comparison

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_formal: FORMAL_I
		do
			other_formal ?= other
			Result := other_formal /= Void and then other_formal.position = position and then
				is_reference = other.is_reference and then is_expanded = other.is_expanded
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN): INTEGER is
			-- Id of a generic formal parameter.
		do
			Result := Formal_type
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN) is
		do
			buffer.put_integer (Formal_type)
			buffer.put_character (',')
			buffer.put_integer (position)
			buffer.put_character (',')
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN) is
		do
			ba.append_short_integer (formal_type)
			ba.append_short_integer (position)
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER) is
		local
			dummy: INTEGER
		do
			buffer.put_integer (Formal_type)
			buffer.put_character (',')
			buffer.put_integer (position)
			buffer.put_character (',')
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER) is
		local
			dummy : INTEGER
		do
				-- Increment counter
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
				-- We must be in a generic class otherwise having a formal creation
				-- does not make sense.
			check
				generic_class: context.current_type.base_class.is_generic
			end

				-- Generate call to feature, defined in every descendant of
				-- the current generic class, that will
				-- create the corresponding runtime type associated with formal
				-- in descendant class.
			il_generator.generate_type_feature_call (context.current_type.base_class.formal_at_position (position))
		end

feature {NONE} -- Code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
		do
		ensure then
			False
		end

feature {NONE} -- Not applicable

	c_type: TYPE_C is
			-- Associated C type.
		do
				-- FIXME: we should not call it, but in case we have decided that it
				-- will always return a reference type
			Result := Reference_c_type
		end

	sk_value: INTEGER is
		do
		ensure then
			False
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FORMAL_I
