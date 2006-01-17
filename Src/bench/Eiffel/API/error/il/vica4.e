indexing
	description: "Errors when a named argument appears more than once."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VICA4

inherit
	VICA
		redefine
			build_explain, subcode
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like context_class; a_feature: FEATURE_I; a_creation_type: like creation_type; a_name: like named_argument) is
			-- Create new error because incorrect custom attribute creation
			-- of type `a_creation_type' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
			a_creation_type: a_creation_type /= Void
			a_name_not_void: a_name /= Void
		do
			context_class := a_class
			creation_type := a_creation_type
			named_argument := a_name
			set_feature (a_feature)
		ensure
			context_class_set: context_class = a_class
			creatiion_type_set: creation_type = a_creation_type
			named_argument_set: named_argument = a_name
		end

feature -- Access

	creation_type: CL_TYPE_A
			-- Type of custom attribute.

	named_argument: STRING
			-- Name of not found `named_argument'.

feature -- Properties

	subcode: INTEGER is 4
			-- Subcode of error.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Type of custom attribute being created: ")
			st.add_class (creation_type.associated_class.lace_class)
			st.add_new_line
			st.add_string ("Named argument appearing more than once: ") 
			st.add_string (named_argument)
			st.add_new_line
		end

invariant
	creation_type_not_void: creation_type /= Void
	named_argument_not_void: named_argument /= Void

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
