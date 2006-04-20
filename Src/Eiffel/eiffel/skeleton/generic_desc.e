indexing
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

	type_i: TYPE_I
		-- Type having some generic parameters	

	sk_value: INTEGER is
			-- Sk value
		do
			check False end
		end

	level: INTEGER is
			-- Sort level
		do
			Result := Formal_level
		end

feature -- Settings

	set_type_i (t: TYPE_I) is
			-- Assign `t' to `type_i'.
		require
			t_not_void: t /= Void
		do
			type_i := t
		ensure
			type_i_set: type_i = t
		end

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_generic: GENERIC_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				other_generic ?= other
				Result := (other_generic /= Void) and then identical_types (other_generic.type_i)
			end
		end

	identical_types (otype : TYPE_I) : BOOLEAN is
			-- Are `type_i' and `otype' identical?
		do
			if type_i = Void then
				Result := (otype = Void)
			else
				if otype /= Void then
					Result := type_i.is_identical (otype) and then
							  otype.is_identical (type_i)
				end
			end
		end

feature -- Status report

	has_formal: BOOLEAN is True
			-- Has the current description a formal generic one ?

feature -- Instantiation

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC is
			-- Instantiation of the current description in		
			-- `class_type'.
		local
			l_type: TYPE_I
			l_ref: REFERENCE_DESC
			l_exp: EXPANDED_DESC
		do
			l_type := type_i.instantiation_in (class_type)
			Result := l_type.instantiated_description
			l_ref ?= Result
			if l_ref /= Void then
					-- Override type in case we handle an attribute
					-- which is a formal generic parameter instantiated
					-- as a reference type, in that case we need to preserve
					-- the fact that it is a formal.
				if type_i.is_formal then
					l_ref.set_type_i (type_i)
				end
			else
				l_exp ?= Result
				if l_exp /= Void then
						-- Override type in case we handle an attribute
						-- which is a formal generic parameter instantiated
						-- as an expanded in `class_type', we preserve the
						-- fact it is a formal.
					if type_i.is_formal then
						if l_type.is_true_expanded then
							l_exp.set_type_i (type_i)
						end
					end
				end
			end

			Result.set_feature_id (feature_id)
			Result.set_attribute_name_id (attribute_name_id)
			Result.set_rout_id (rout_id)
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Useless
		do
			check False end
		end

feature -- Debug

	trace is
			-- Debug purpose
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("Generic desc: ")
			type_i.trace
		end

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

end
