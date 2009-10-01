note
	description: "Attribute description of generic type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class GENERIC_DESC

inherit
	ATTR_DESC
		redefine
			has_formal, instantiation_in, same_as
		end

feature -- Access

	type_i: TYPE_A
		-- Type having some generic parameters	

	sk_value: INTEGER
			-- Sk value
		do
			Result := {SK_CONST}.sk_ref
		end

	level: INTEGER
			-- Sort level
		do
			Result := reference_level
		end

feature -- Settings

	set_type_i (t: like type_i)
			-- Assign `t' to `type_i'.
		require
			t_not_void: t /= Void
		do
			type_i := t
		ensure
			type_i_set: type_i = t
		end

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN
			-- Is `other' equal to Current ?
		local
			other_generic: GENERIC_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				other_generic ?= other
				Result := (other_generic /= Void) and then identical_types (other_generic.type_i)
			end
		end

	identical_types (otype : TYPE_A) : BOOLEAN
			-- Are `type_i' and `otype' identical?
		do
			if type_i = Void then
				Result := (otype = Void)
			else
				if otype /= Void then
					Result := type_i.same_as (otype) and then
							  otype.same_as (type_i)
				end
			end
		end

feature -- Status report

	has_formal: BOOLEAN = True
			-- Has the current description a formal generic one ?

feature -- Instantiation

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC
			-- Instantiation of the current description in		
			-- `class_type'.
		local
			l_type, l_generic_type: TYPE_A
			l_exp: EXPANDED_DESC
			l_has_formal: BOOLEAN
		do
				-- Instantiate the type.
			l_type := type_i.skeleton_adapted_in (class_type)

				-- If type is a formal and in `class_type' this formal is actually expanded,
				-- we use the expanded type instead.
			if attached {FORMAL_A} l_type as l_formal then
				l_has_formal := True
				l_generic_type := class_type.type.generics.item (l_formal.position)
				if l_generic_type.is_expanded then
					l_type := l_generic_type
				end
			end
				-- If after the instantiation the resulting type is a reference or
				-- an expanded, we need to store the original type `type_i' as part
				-- of the description since `l_type' has been adapted to the current
				-- context and does not hold the correct generic information.
				-- For example:
				-- 1) In generic derivation for ARRAY [expanded X [ANY]], the `area'
				--    attribute should be created as SPECIAL [G], not as SPECIAL [expanded X [ANY]]
				--    which is incorrect. See eweasel test#storable013 which shows that if things
				--    are not done properly here it fails.
				-- 2) In a class, we have `like Current' and if `like Current' is now part of
				--    an expanded class, then we still need to remember that we create a `like Current'
				--    and not the expanded type we get from `skeleton_adapted_in'.
			Result := l_type.instantiated_description
			if l_has_formal or type_i.is_like_current then
				update_description (Result, type_i)
			end

				-- In order to properly handle expanded type, we need to record its associated
				-- class type. Note that {EXPANDED_DESC}.instantiation_in uses `adapted_in' and
				-- not `skeleton_adapted_in' but at this stage I don't have a good explanation
				-- just the fact that `skeleton_adapted_in' is just for backward compatibility
				-- for storable on `type_i' but `cl_type_i' is only used for checking VLEC, not
				-- for code generation, so using `adapted_in' seems more correct.
			l_exp ?= Result
			if l_exp /= Void then
				Result := l_exp.instantiation_in (class_type)
			end

			Result.set_feature_id (feature_id)
			Result.set_attribute_name_id (attribute_name_id)
			Result.set_rout_id (rout_id)
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER)
			-- Useless
		do
			buffer.put_string ({SK_CONST}.sk_ref_string);
		end

feature -- Helper

	update_description (a: ATTR_DESC; a_type: TYPE_A)
			-- Update the `type_i' from `a' with `a_type' if `a' is
			-- either an expanded or a reference.
		require
			a_not_void: a /= Void
			a_type_not_void: a_type /= Void
		local
			l_exp: EXPANDED_DESC
			l_ref: REFERENCE_DESC
		do
			l_exp ?= a
			if l_exp /= Void then
				l_exp.set_type_i (a_type)
			else
				l_ref ?= a
				if l_ref /= Void then
					l_ref.set_type_i (a_type)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
