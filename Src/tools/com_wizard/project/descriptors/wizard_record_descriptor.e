indexing
	description: "Structure descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR
		redefine
			creation_message
		end

creation
	make

feature {NONE}-- Initialization

	make (a_creator: WIZARD_RECORD_DESCRIPTOR_CREATOR) is
			-- Initialize `fields'
			-- and `eiffel_class_name'
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			non_void_fields: fields /= Void
			non_void_class_name: eiffel_class_name /= Void
			non_void_name: name /= Void
		end

feature -- Access

	fields: SORTED_TWO_WAY_LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: NATURAL_32
			-- Size of instance of this type

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	is_union: BOOLEAN
			-- Is union?

	creation_message: STRING is
			-- Creation message used for wizard output
		local
			l_description: STRING
			l_field: WIZARD_RECORD_FIELD_DESCRIPTOR
		do
			create Result.make (500)
			Result.append ("Added ")
			if is_union then
				Result.append ("Union ")
			else
				Result.append ("Record ")
			end
			Result.append (name)
			from
				fields.start
				Result.append ("%R%N%T")
			until
				fields.after
			loop
				l_field := fields.item
				Result.append (l_field.name)
				Result.append (": ")
				Result.append (l_field.data_type.name)
				l_description := l_field.description
				if l_description /= Void and then not l_description.is_empty then
					Result.append ("%R%N%T%T%T-- ")
					Result.append (l_description)
				end
				Result.append ("%R%N%T")
				fields.forth
			end
		end

feature -- Basic operations

	set_fields (some_fields: SORTED_TWO_WAY_LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]) is
			-- Set `fields' with `some_fields'.
		require
			valid_fields: some_fields /= Void
		do
			fields := some_fields
		ensure
			valid_fields: fields /= Void and fields = some_fields
		end

	set_size (a_size: like size_of_instance) is
			-- Set `size_of_instance' with `a_size'.
		do
			size_of_instance := a_size
		ensure
			valid_size: size_of_instance = a_size
		end

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

	set_is_union (a_boolean: BOOLEAN) is
			-- Set `is_union' with `a_boolean'.
		do
			is_union := a_boolean
		ensure
			valid_is_union: is_union = a_boolean
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_record (Current)
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
end -- class WIZARD_RECORD_DESCRIPTOR

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

