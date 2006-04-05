indexing
	description: "Structure's field description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	WIZARD_RECORD_FIELD_DESCRIPTOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPARABLE

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_RECORD_FIELD_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_data_type: data_type /= Void
		end

feature -- Access

	name: STRING
			-- Field name

	description: STRING
			-- Help string

	data_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Field's type

	offset: INTEGER
			-- Offeset of field within structure

feature -- Basic Operations

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			name := a_name.twin
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			non_void_description: a_description /= Void
		do
			description := a_description.twin
		ensure
			description_set: description.is_equal (a_description)
		end

	set_data_type (a_data_type: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `data_type' with `a_data_type'.
		require
			valid_data_type: a_data_type /= Void
		do
			data_type := a_data_type
		ensure
			valid_data_type: data_type /= Void and data_type = a_data_type
		end

	set_offset (an_offset: INTEGER) is
			-- Set `offset' with `an_offset'.
		do
			offset := an_offset
		ensure
			valid_offset: offset = an_offset
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := offset < other.offset
		end;

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
end -- class WIZARD_RECORD_FIELD_DESCRIPTOR

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

