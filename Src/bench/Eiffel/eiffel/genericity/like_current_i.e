indexing
	description: "Representation of a compiled `like Current' type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LIKE_CURRENT_I

inherit
	TYPE_I
		rename
			anchor_instantiation_in as instantiation_in
		redefine
			description,
			generate_gen_type_il,
			generated_id,
			has_formal,
			has_true_formal,
			instantiated_description,
			instantiation_in,
			is_anchored,
			is_explicit,
			is_formal,
			is_standalone,
			same_as
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Type of current element. Should not be called.
		do
			check
				not_reached: False
			end
		end

	tuple_code: INTEGER_8 is
			-- Formal tuple code. Should not be called.
		do
			check
				False
			end
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code
		end

	description: GENERIC_DESC is
			-- Descritpion of type for skeletons
		do
			create Result
			Result.set_type_i (Current)
		end

	instantiated_description: ATTR_DESC is
			-- Descritpion of type for skeletons without any formal generics
		do
			check
				false
			end
		ensure then
			false
		end

feature -- Status report

	is_formal: BOOLEAN is False
			-- Is the type a formal type ?

	is_explicit: BOOLEAN is False
			-- Is type fixed at compile time without anchors or formals?

	is_standalone: BOOLEAN is False
			-- Is type standalone, i.e. does not depend on formal generic or acnhored type?

	is_anchored: BOOLEAN is True
			-- Does type contain anchored type?

	has_true_formal, has_formal: BOOLEAN is False
			-- Has the type formal in its structure?

	instantiation_in (other: CLASS_TYPE): CL_TYPE_I is
			-- Instantiation of Current in context of `other'.
		do
			Result := other.type
				-- "like Current" creation info should be already set.
			check
				cr_info_set: Result.is_expanded or else Result.cr_info /= Void
				cr_info_is_like_current: Result.is_expanded or else Result.cr_info.same_type (create_info)
			end
		end

	name: STRING is
			-- Name of current type.
		do
			Result := "like Current"
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		do
			Result := name
		end

	type_a: LIKE_CURRENT is
			-- Associated LIKE_CURRENT object.
		do
			create Result
		end

feature -- Comparison

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_like_current: LIKE_CURRENT_I
		do
			other_like_current ?= other
			Result := other_like_current /= Void
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN): INTEGER is
			-- Id of a "like Current" parameter.
		do
			Result := Like_current_type
		end

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			il_generator.generate_current
			il_generator.load_type
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
			check
				not_reached: False
			end
		ensure then
			False
		end

	sk_value: INTEGER is
		do
		ensure then
			False
		end

feature {NONE} -- Implementation

	create_info: CREATE_CURRENT is
			-- Byte code information for entity type creation.
		once
			create Result
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

end
