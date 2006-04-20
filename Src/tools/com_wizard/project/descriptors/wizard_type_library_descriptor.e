indexing
	description: "Description of Type Library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TYPE_LIBRARY_DESCRIPTOR

inherit
	EXCEPTIONS
		undefine
			is_equal
		end

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		undefine
			is_equal
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		undefine
			is_equal
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		undefine
			is_equal
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		undefine
			is_equal
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES
		export
			{NONE} all
		undefine
			is_equal
		end

	ECOM_TYPE_FLAGS
		export
			{NONE} all
		undefine
			is_equal
		end

	WIZARD_GUIDS
		export
			{NONE} all
		undefine
			is_equal
		end

creation
	make

feature -- Initialization

	make (a_type_lib: ECOM_TYPE_LIB) is
			-- Initialize `type_lib' with `a_type_lib'
		require
			non_void_type_lib: a_type_lib /= Void
		local
			i: INTEGER
			a_referee_list: ARRAYED_LIST [WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR]
		do
			create descriptors.make (1, a_type_lib.type_info_count)
			create referees.make (1, a_type_lib.type_info_count)
			from
				i := 1
			variant
				a_type_lib.type_info_count - i +1
			until
				i > a_type_lib.type_info_count
			loop
				create a_referee_list.make (20)
				referees.put (a_referee_list, i)
				i := i + 1
			end
			create guid.make_from_guid (a_type_lib.library_attributes.guid)
			major_version_number := a_type_lib.library_attributes.major_version_number
			minor_version_number := a_type_lib.library_attributes.minor_version_number
			lcid := a_type_lib.library_attributes.lcid
			name := a_type_lib.documentation (-1).name
			doc_string := a_type_lib.documentation (-1).doc_string
			context_id := a_type_lib.documentation (-1).context_id
			help_file := a_type_lib.documentation (-1).help_file
			create_description
			type_lib := a_type_lib
		ensure
			valid_descriptors: descriptors /= Void
			type_lib_set: type_lib = a_type_lib
		end

feature -- Access

	descriptors: ARRAY [WIZARD_TYPE_DESCRIPTOR]
			-- Array of descriptors, index starts from 1
			-- index corresponds to `index_in_type_lib' + 1

	referees: ARRAY [LIST [WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR]]
			-- Array of Referee Lists, index starts from 1
			-- index corresponds to descriptor with same index.

	guid: ECOM_GUID
			-- GUID of Type Library.

	name: STRING
			-- Library name.

	description: STRING
			-- Type Library description.

	doc_string: STRING
			-- Documentation string.

	context_id: NATURAL_32
			-- Context identifier for library help topic in help file.

	help_file: STRING
			-- Full path of help file.

	major_version_number: INTEGER
			-- Major version number.

	minor_version_number: INTEGER
			-- Minor version number.

	lcid: INTEGER
			-- Library locale.

	type_lib: ECOM_TYPE_LIB
			-- Type Library.

	Generation_title: STRING is "Parsing Type Library"
			-- Generation title.

	complete: BOOLEAN
			-- Is generation of library descriptor comlete?

feature -- Status report

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' describes same data type?
		do
			Result := guid.is_equal (other.guid)
		end

feature -- Basic operations

	create_description is
			-- Create Type Libarary description.
		do
			create description.make (100)
			if doc_string /= Void then
				description.append (doc_string)
			end
			if help_file /= Void and then not help_file.is_empty then
				if not description.is_empty and then not (description.item (description.count) = '.') then
					description.append_character ('.')
				end
				description.append (" See: ")
				description.append (help_file)
			end
		ensure
			non_void_description: description /= Void
		end

	set_complete is
			-- Set `complete' to True
		do
			complete := True
		end

	add_descriptor (a_descriptor: WIZARD_TYPE_DESCRIPTOR; a_index: INTEGER) is
			-- Add `a_descriptor' to 'descriptors'.
		require
			valid_index: a_index > 0 and a_index <= descriptors.count
			not_has: descriptors.item (a_index) = Void
		do
			descriptors.put (a_descriptor, a_index)
		ensure
			added: descriptors.item (a_index) = a_descriptor
		end

	add_referee (a_data_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR; a_index: INTEGER) is
			-- Add `a_data_descriptor' to `referees'.
		require
			non_void_descriptor: a_data_descriptor /= Void
			valid_index: a_index > 0 and a_index <= descriptors.count
		do
			referees.item (a_index).force (a_data_descriptor)
		end

	generate  is
			-- Create `descriptors' array.
		local
			i: INTEGER
			l_type_info: ECOM_TYPE_INFO
		do
			from
				i := 0
			until
				i = type_lib.type_info_count or environment.abort
			loop
				l_type_info := type_lib.type_info (i)
				if descriptors.item (i + 1) = Void then
					add_descriptor (Type_descriptor_factory.create_type_descriptor (type_lib.documentation (i), l_type_info), i + 1)
				end
				i := i + 1
				progress_report.step
			end
		end

	finalize_inherited_interfaces is
			-- Set references to inherited interfaces
			-- Flatten interfaces
		require
			complete: complete
		local
			i, l_count: INTEGER
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if l_type.type_kind = Tkind_interface or l_type.type_kind = Tkind_dispatch then
						l_interface ?= l_type
						if l_interface /= Void then
							if l_interface.inherited_interface = Void and l_interface.inherited_interface_descriptor /= Void then
								l_interface.initialize_inherited_interface
							end
						end
					end
				end
				i := i + 1
			end
		end

	finalize_interface_features is
			-- Finalize interface_features.
		require
			complete: complete
		local
			i, l_count: INTEGER
			l_type: WIZARD_TYPE_DESCRIPTOR
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if l_type.type_kind = Tkind_interface or l_type.type_kind = Tkind_dispatch then
						l_interface ?= l_type
						if l_interface /= Void then
							l_interface.finalize_functions
						end
					end
				end
				i := i + 1
			end
		end

	finalize_names is
			-- Remove name clashes in system.
		require
			complete: complete
		local
			i, local_counter, l_count: INTEGER
			l_string: STRING
			l_type: WIZARD_TYPE_DESCRIPTOR
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_component: WIZARD_COMPONENT_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if system_descriptor.eiffel_names.has (l_type.eiffel_class_name) and not l_type.is_well_known_interface then
						local_counter := counter
						create l_string.make (3)
						l_string.append_integer (local_counter)
						l_type.eiffel_class_name.append (l_string)
						if l_type.type_kind /= Tkind_alias then
							if l_type.c_header_file_name /= Void and then not l_type.c_header_file_name.is_empty then
								l_type.c_header_file_name.insert_string (l_string, l_type.c_header_file_name.index_of ('.', 1))
							end
							l_interface ?= l_type
							if l_interface /= Void then
								if l_interface.c_declaration_header_file_name /= Void and then not l_interface.c_declaration_header_file_name.is_empty then
									l_interface.c_declaration_header_file_name.insert_string (l_string, l_interface.c_declaration_header_file_name.index_of ('.', 1))
								end
							else
								l_component ?= l_type
								if l_component /= Void then
									if l_component.c_declaration_header_file_name /= Void and then not l_component.c_declaration_header_file_name.is_empty then
										l_component.c_declaration_header_file_name.insert_string (l_string, l_component.c_declaration_header_file_name.index_of ('.', 1))
									end
								end
							end
						end
						l_type.c_type_name.append (l_string)
						l_type.name.append (l_string)
					end
					system_descriptor.eiffel_names.force (l_type.eiffel_class_name, l_type.eiffel_class_name)
				end
				i := i + 1
			end
		end

	finalize_aliases is
			-- Remove anonymous aliases.
		require
			complete: complete
		local
			i, l_count: INTEGER
			alias_descriptor: WIZARD_ALIAS_DESCRIPTOR
			user_defined_type_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			a_name: STRING
			a_lib: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			a_index: INTEGER
			aliased_descriptor: WIZARD_TYPE_DESCRIPTOR
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if l_type.type_kind = Tkind_alias then
						alias_descriptor ?= l_type
						if alias_descriptor /= Void then
							user_defined_type_descriptor ?= alias_descriptor.type_descriptor
							if user_defined_type_descriptor /= Void then
								a_lib := user_defined_type_descriptor.library_descriptor
								a_index := user_defined_type_descriptor.type_descriptor_index
								aliased_descriptor := a_lib.descriptors.item (a_index)
								a_name := aliased_descriptor.name.twin
								a_name.to_upper
								if
									(a_name.substring_index ("__MIDL___MIDL_", 1) > 0) or
									(a_name.substring_index ("TAG", 1) > 0)
								then
									aliased_descriptor.set_name (l_type.name)
									aliased_descriptor.set_c_type_name (l_type.name)
									aliased_descriptor.set_eiffel_class_name
										(name_for_class (l_type.name, aliased_descriptor.type_kind, False))
									aliased_descriptor.set_c_header_file_name (header_name (aliased_descriptor.namespace, aliased_descriptor.c_type_name))
								end
								update_referees (i, a_index, a_lib)
								descriptors.put (Void, i)
							end
						end
					end
				end
				i := i + 1
			end
		end

	update_referees (a_index, a_new_index: INTEGER; a_new_lib: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Update referees of descriptor at `a_index' to use descriptor at `a_new_index'.
			-- Also update referees type library to `a_new_lib'.
		require
			valid_index: a_index > 0 and a_index <= descriptors.count
			valid_new_index: a_new_index > 0 and a_new_index <= descriptors.count
			non_void_new_lib: a_new_lib /= Void
		local
			l_referees: LIST [WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR]
			l_referee: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
		do
			l_referees := referees.item (a_index)
			from
				l_referees.start
			until
				l_referees.after
			loop
				l_referee := l_referees.item
				if l_referee.type_descriptor_index /= a_new_index then
					l_referee.set_type_descriptor_index (a_new_index)
					l_referee.set_library_descriptor (a_new_lib)
					add_referee (l_referee, a_new_index)
				end
				l_referees.forth
			end
		end

	finalize_interface_feature_names is
			-- Remove feature name clashes on interface level.
		require
			complete: complete
		local
			i, l_count: INTEGER
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if l_type.type_kind = Tkind_interface or l_type.type_kind = Tkind_dispatch then
						l_interface ?= l_type
						if l_interface /= Void and then not l_interface.is_interface_disambiguated then
							l_interface.disambiguate_interface_names
						end
					end
				end
				i := i + 1
			end
		end

	finalize_coclass_feature_names is
			-- Remove feature name clashes on coclass level.
		require
			complete: complete
		local
			i, l_count: INTEGER
			l_descriptor: WIZARD_COCLASS_DESCRIPTOR
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if l_type.type_kind = Tkind_coclass then
						l_descriptor ?= l_type
						if l_descriptor /= Void then
							l_descriptor.disambiguate_feature_names
						end
					end
				end
				i := i + 1
			end
		end

	create_implemented_interfaces is
			-- Create implemented interface descriptors.
		require
			complete: complete
		local
			i, l_count: INTEGER
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			from
				i := 1
				l_count := descriptors.count
			variant
				l_count - i + 1
			until
				i > l_count
			loop
				l_type := descriptors.item (i)
				if l_type /= Void then
					if l_type.type_kind = Tkind_interface or l_type.type_kind = Tkind_dispatch then
						l_interface ?= l_type
						if l_interface /= Void then
							if (not environment.is_client or system_descriptor.is_iunknown or
									not referees.item (i).is_empty) and not Non_generated_type_libraries.has (guid) and
									l_interface.inherited_interface /= Void then
								system_descriptor.interfaces.force (l_interface.implemented_interface)
							end
						end
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	counter: INTEGER is
			-- Counter
		do
			Result := counter_impl.item
			counter_impl.set_item (Result + 1)
		end

	counter_impl: INTEGER_REF is
			-- Global counter
		once
			create Result
			Result.set_item (1)
		end

invariant
	non_void_descriptors: descriptors /= Void

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
end -- class WIZARD_TYPE_LIBRARY_DESCRIPTOR

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

