note
	description: "Expanded description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXPANDED_DESC

inherit
	ATTR_DESC
		redefine
			is_expanded, same_as, instantiation_in, default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			internal_flags := {SHARED_LEVEL}.expanded_level
		end

feature -- Access

	class_type: CLASS_TYPE
			-- Class type of the expanded attribute.

	cl_type_i: TYPE_A
			-- Class type of the expanded attribute
			-- The attribute is only set when instantiating the GENERIC_SKELETON into SKELETON.

	type_i: TYPE_A
			-- Type of attribute

	type_id: INTEGER
			-- Type id of the expanded type of the attribute
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end

	sk_value: NATURAL_32
			-- Sk value
		do
			Result := {SK_CONST}.Sk_exp | (type_id - 1).to_natural_32
		end

feature -- Status report

	is_expanded: BOOLEAN = True
			-- Is the attribute an expanded one ?

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN
			-- Is `other' equal to Current ?
		do
			if Precursor (other) and then attached {EXPANDED_DESC} other as l_other_exp then
					-- We have to make sure that they represent the same expanded
					-- class type and that they have the same types.
				Result := l_other_exp.type_id = type_id and then identical_types (l_other_exp.type_i)
			end
		end

	identical_types (otype : TYPE_A) : BOOLEAN
			-- Are `type_i' and `otype' identical?
		do
			if type_i = Void then
				Result := (otype = Void)
			elseif otype /= Void then
				Result := type_i.same_as (otype)
			end
		end

feature -- Settings

	set_cl_type_i (i: like cl_type_i)
			-- Assign `i' to `cl_type_i'.
		do
			cl_type_i := i
		ensure
			cl_type_i_set: cl_type_i = i
		end

	set_class_type (a_class_type: like class_type)
			-- Set `class_type' with `a_class_type'.
		require
			a_class_type_not_void: a_class_type /= Void
		do
			class_type := a_class_type
		ensure
			class_type_set: class_type = a_class_type
		end

	set_type_i (t : TYPE_A)
			-- Assign `t' to `type_i'.
		require
			exists: t /= Void
		do
			type_i := t
		ensure
			set: type_i = t
		end

	instantiation_in (a_class_type: CLASS_TYPE): EXPANDED_DESC
		local
			l_type: TYPE_A
		do
			Result := twin
			l_type := type_i.adapted_in (a_class_type)
			Result.set_cl_type_i (l_type)
			Result.set_class_type (l_type.associated_class_type (a_class_type.type))
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER)
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ({SK_CONST}.sk_exp_string)
			buffer.put_three_character (' ', '+', ' ')
			buffer.put_type_id (type_id)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
