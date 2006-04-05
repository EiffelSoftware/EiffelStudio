indexing
	description: "Description of element of enumeration"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_ELEMENT_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			non_void_name: name /= Void
			valid_name: not name.is_empty
		end
	
feature -- Access

	name: STRING
			-- element name

	value: INTEGER
			-- element value

	description: STRING
			-- help string

feature -- Basic operations

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			name := a_name.twin
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

	set_value (a_value: INTEGER) is
			-- Set `value' with `a_value'.
		do
			value := a_value
		ensure
			valid_value: value = a_value
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			non_void_description: a_description /= Void
		do
			description := a_description
		ensure
			description_set: description = a_description
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
end -- WIZARD_ENUM_ELEMENT_DESCRIPTOR

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

