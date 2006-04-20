indexing
	description: "Renaming clause, conforms to feature so that it can be added and%
					%treated as a feature for code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RENAMING_CLAUSE

inherit
	WIZARD_FUNCTION_DESCRIPTOR
		rename
			make as function_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_original_name, a_changed_name: STRING; a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Initialize instance.
		require
			non_void_original_name: a_original_name /= Void
			non_void_changed_name: a_changed_name /= Void
			valid_names: not a_original_name.is_equal (a_changed_name)
		do
			interface_eiffel_name := a_original_name
			is_renaming_clause := True
			create components_eiffel_names.make (5)
			components_eiffel_names.put (a_changed_name, a_component.name)
		ensure
			interface_eiffel_name_set: interface_eiffel_name = a_original_name
		end

invariant
	is_renamed: is_renaming_clause
	non_void_interface_eiffel_name: interface_eiffel_name /= Void
	non_void_components_eiffel_names: components_eiffel_names /= Void
	valid_components_eiffel_names: components_eiffel_names.count = 1

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
end -- class WIZARD_RENAMING_CLAUSE

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

