indexing
	description: "Description of user defined data type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DATA_TYPE_DESCRIPTOR
		redefine
			visitor
		end

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_USER_DEFINED_DATA_TYPE_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			library_descriptor.add_referee (Current, type_descriptor_index)
		ensure
			non_void_descriptor: library_descriptor /= Void
			valid_reference: type_descriptor_index /= 0
			user_defined_type: is_user_defined (type)
		end

feature -- Access

	type_descriptor_index: INTEGER
			-- Index of type_descriptor in `descriptors' array
			-- of WIZARD_TYPE_LIBRARY_DESCRIPTOR

	library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Description of type library

	visitor: WIZARD_DATA_TYPE_VISITOR is
			-- Data type visitor.
		local
			type_descriptor: WIZARD_TYPE_DESCRIPTOR
		do
			type_descriptor := library_descriptor.descriptors.item (type_descriptor_index)
			if instance_visitor /= Void then
				Result := instance_visitor
			elseif type_descriptor.data_type_visitor /= Void then
				instance_visitor := type_descriptor.data_type_visitor
				Result := type_descriptor.data_type_visitor
			else
				create Result
				Result.visit (Current)
				instance_visitor := Result
				type_descriptor.set_data_type_visitor (Result)
			end
		ensure then
			non_void_data_type_visitor: library_descriptor.descriptors.item (type_descriptor_index).data_type_visitor /= Void
		end

feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		local
			other_user_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
		do
			other_user_descriptor ?= other
			if other_user_descriptor /= Void then
				Result := library_descriptor.is_equal (other_user_descriptor.library_descriptor) and
					type_descriptor_index = other_user_descriptor.type_descriptor_index
			end
		end

feature -- Basic operations

	set_type_descriptor_index (a_index: like type_descriptor_index) is
			-- Set `type_descriptor_index' with `a_index'
		require
			valid_index: a_index /= 0
		do
			type_descriptor_index := a_index
		ensure
			valid_index: type_descriptor_index = a_index
		end

	set_library_descriptor (a_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			--
		require
			valid_descriptor: a_library_descriptor /= Void
		do
			library_descriptor := a_library_descriptor
		ensure
			descriptor_set: library_descriptor = a_library_descriptor
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_user_defined_data_type (Current)
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
end -- class WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR

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

