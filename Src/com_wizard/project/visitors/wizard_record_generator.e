indexing
	description: "Record generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_GENERATOR

inherit
	WIZARD_VARIABLE_NAME_MAPPER

feature {NONE} -- Implementation

	impl_header_file_name (a_header_file_name: STRING): STRING is
			-- Name of implementation header file.
		require
			non_void_header_file_name: a_header_file_name /= Void
			non_empty_header_file_name: not a_header_file_name.is_empty
			valid_header_file_name: a_header_file_name.substring_index (".h", 1) = 
								a_header_file_name.count - 1
		do
			Result := a_header_file_name.twin
			Result.insert_string ("_impl", Result.count - 1)
		ensure
			non_void_header_file_name: Result /= Void
			non_empty_header_file_name: not Result.is_empty
			valid_header_file_name: Result.substring_index (".h", 1) = Result.count - 1
		end

	macro_accesser_name (record_name: STRING; 
				field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Name of accesser function.
		require
			non_void_record_name: record_name /= Void
			valid_record_name: not record_name.is_empty
			non_void_field_descriptor: field_descriptor /= Void
			non_void_field_name: field_descriptor.name /= Void
			valid_field_name: not field_descriptor.name.is_empty
		do
			create Result.make (100)

			Result.append ("ccom_")
			Result.append (name_for_feature (record_name))
			Result.append (Underscore)
			Result.append (name_for_feature (field_descriptor.name))
			Result.to_lower
		ensure
			non_void_accesser_name: Result /= Void
			valid_accesser_name: not Result.is_empty
		end

	macro_setter_name (record_name: STRING; 
				field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Name of setter function.
		require
			non_void_record_name: record_name /= Void
			valid_record_name: not record_name.is_empty
			non_void_field_descriptor: field_descriptor /= Void
			non_void_field_name: field_descriptor.name /= Void
			valid_field_name: not field_descriptor.name.is_empty
		do
			create Result.make (100)

			Result.append ("ccom_")
			Result.append (name_for_feature (record_name))
			Result.append ("_set_")
			Result.append (name_for_feature (field_descriptor.name))
			Result.to_lower
		ensure
			non_void_accesser_name: Result /= Void
			valid_accesser_name: not Result.is_empty
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
end -- class WIZARD_RECORD_GENERATOR

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

