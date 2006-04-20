indexing
	description: "Union descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_UNION_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR


creation
	make

feature {NONE}-- Initialization

	make (a_creator: WIZARD_UNION_DESCRIPTOR_CREATOR) is
			-- Initialize `fields'
			-- and `eiffel_class_name'
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure 
			non_void_fields: fields /= Void
			non_void_class_name: eiffel_class_name /= Void
		end

feature -- Access

	fields: LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: INTEGER
			-- Size of instance of this type

	creation_message: STRING is
			-- Creation message for wizard output
		do
		end

feature -- Basic operations

	set_fields (some_fields: LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]) is
			-- Set `fields' with `some_fields'.
		require
			valid_fields: some_fields /= Void
		do
			fields := some_fields
		ensure
			fields_set: fields /= Void and fields = some_fields
		end

	set_size (a_size: INTEGER) is
			-- Set `size_of_instance' with `a_size'.
		do
			size_of_instance := a_size
		ensure
			size_set: size_of_instance = a_size
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_union (Current)
		end

invariant
	valid_fields: fields /= Void

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
end -- class WIZARD_UNION_DESCRIPTOR

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

