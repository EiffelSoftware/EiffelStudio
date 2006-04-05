indexing
	description: "Enumeration descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR

	EXCEPTIONS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_ENUM_DESCRIPTOR_CREATOR) is
			-- Initialize `elements'
			-- and `eiffel_class_name'
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure 
			non_void_elements: elements /= Void
			non_void_class_name: eiffel_class_name /= Void
		end

feature -- Access

	elements: LIST [WIZARD_ENUM_ELEMENT_DESCRIPTOR]
			-- list of element descriptors

	size_of_instance: INTEGER
			-- Size of instance of this type

	creation_message: STRING is
			-- Creation message for wizard output
		local
			l_element: WIZARD_ENUM_ELEMENT_DESCRIPTOR
			l_description: STRING
		do
			create Result.make (512)
			Result.append ("Added enumerator ")
			Result.append (name)
			from
				elements.start
			until
				elements.after
			loop
				l_element := elements.item
				Result.append ("%R%N%T")
				Result.append (l_element.name)
				Result.append (": ")
				Result.append (l_element.value.out)
				l_description := l_element.description
				if l_description /= Void and then not l_description.is_empty then
					Result.append ("%R%N%T%T-- ")
					Result.append (l_description)
				end
				elements.forth
			end
			Result.append ("%R%N")
		end

	is_added: BOOLEAN
			-- Is descriptor added to list of enumerators?

feature -- Basic Operations

	set_added is
			-- Set `added' to `True'.
		do
			is_added := True
		ensure
			added: is_added
		end

	set_elements (some_elements: LIST [WIZARD_ENUM_ELEMENT_DESCRIPTOR]) is
			--
		require
			valid_elements: some_elements /= Void
		do
			elements := some_elements
		ensure
			valid_elements: elements /= Void and elements = some_elements
		end
 
	set_size (a_size: INTEGER) is
			-- Set `size_of_instance' with `a_size'.
		do
			size_of_instance := a_size
		ensure
			valid_size: size_of_instance = a_size
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_enum (Current)
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
end -- WIZARD_ENUM_DESCRIPTOR

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

