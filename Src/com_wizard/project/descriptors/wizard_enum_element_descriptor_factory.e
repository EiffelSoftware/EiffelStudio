indexing
	description: "Factory of Enumeration Element Descriptors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; 
					a_value: INTEGER): WIZARD_ENUM_ELEMENT_DESCRIPTOR is
			-- Create description of element of enumerartion
		require
			valid_documentaion: a_documentation /= Void and then
				a_documentation.name /= Void
		do
			name := name_for_feature_with_keyword_check (a_documentation.name)
			name.put (name.item (1).upper, 1)
			value := a_value
			description := a_documentation.doc_string

			create Result.make (Current)
		ensure
			valid_name: not name.is_empty
			valid_value: value = a_value
		end

	initialize_descriptor (a_descriptor: WIZARD_ENUM_ELEMENT_DESCRIPTOR) is
			-- Initialize `a_descriptor' fields
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_value (value)
			a_descriptor.set_description (description)
		end

feature {NONE} -- Implementation

	name: STRING
			-- element name

	value: INTEGER
			-- element value

	description: STRING;
			-- help string

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
end -- class WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY

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

