indexing
	description: "Expanded description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXPANDED_DESC 

inherit
	ATTR_DESC
		rename
			Expanded_level as level
		redefine
			is_expanded, same_as
		end
	
feature -- Access

	class_type: CLASS_TYPE is
			-- Associated CLASS_TYPE of `cl_type_i'.
		do
			Result := cl_type_i.associated_class_type
		end
		
	cl_type_i: CL_TYPE_I
			-- Class type of the expanded attribute

	type_i: TYPE_I
			-- Type of attribute

	type_id: INTEGER is
			-- Type id of the expanded type of the attribute
		require
			cl_type_i_exists: cl_type_i /= Void
		do
			Result := cl_type_i.type_id
		end

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_exp | (type_id - 1)
		end

feature -- Status report

	is_expanded: BOOLEAN is True
			-- Is the attribute an expanded one ?

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_exp: EXPANDED_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				other_exp ?= other
					-- Before calling `other_exp.type_id' we have to make sure that
					-- this call is permissible in current context. It could be that
					-- `other_exp' stands for "A [X]" while now we have generic class
					-- "A [G, G]" and therefore cannot find associated CLASS_TYPE for
					-- `other.cl_type_i'.
				Result := (other_exp /= Void) and then other_exp.cl_type_i.has_associated_class_type and then
					(other_exp.type_id = type_id) and then identical_types (other_exp.type_i)
			end
		end

	identical_types (otype : TYPE_I) : BOOLEAN is
			-- Are `type_i' and `otype' identical?
		do
			if type_i = Void then
				Result := (otype = Void)
			else
				if otype /= Void then
					Result := type_i.is_identical (otype) and then otype.is_identical (type_i)
				end
			end
		end

feature -- Settings

	set_cl_type_i (i: like cl_type_i) is
			-- Assign `i' to `cl_type_i'.
		do
			cl_type_i := i
		ensure
			cl_type_i_set: cl_type_i = i
		end

	set_type_i (t : TYPE_I) is
			-- Assign `t' to `type_i'.
		require
			exists: t /= Void
		do
			type_i := t
		ensure
			set: type_i = t
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ("SK_EXP + ")
			buffer.put_type_id (type_id)
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY) is
			-- Generate full type array byte code
		require
			ba /= Void
		local
			gen_type : GEN_TYPE_I
		do
			ba.append_short_integer (0)
			gen_type ?= type_i

			if gen_type /= Void then
				gen_type.make_gen_type_byte_code (ba, False)
			end
			ba.append_short_integer (-1)
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[EXPANDED ")
			io.error.put_string (class_type.associated_class.name)
			io.error.put_string ("]")
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
