indexing
	description: "Renaming clause, conforms to feature so that it can be added and%
					%treated as a feature for code generation."
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

