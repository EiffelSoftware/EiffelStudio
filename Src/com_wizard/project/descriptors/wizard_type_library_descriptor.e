indexing
	description: "Description of Type Library"
	status: "See notice at end of class"
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

	WIZARD_SHARED_DATA
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

creation
	make

feature -- Initialization

	make (a_type_lib: ECOM_TYPE_LIB) is
			-- Initialize `type_lib' with `a_type_lib'
		require
			non_void_type_lib: a_type_lib /= Void
		local
			i: INTEGER
			a_referee_list: LINKED_LIST [WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR]
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
				create a_referee_list.make
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

	referees: ARRAY [LINKED_LIST [WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR]]
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

	context_id: INTEGER 
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
			if not description.empty and then not (description.item (description.count) = '.') then
				description.append_character ('.')
			end
			if help_file /= Void then
				description.append (" Help file: ")
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

	add_descriptor (type_descriptor: WIZARD_TYPE_DESCRIPTOR; an_index: INTEGER) is
			-- Add `type_descriptor' to 'descriptors'.
		require
			valid_index: an_index > 0 and an_index <= descriptors.count
			not_has: descriptors.item (an_index) = Void
		do
			descriptors.put (type_descriptor, an_index)
			if an_index = 41 then
				do_nothing
			end
		ensure
			added: descriptors.item (an_index) = type_descriptor
		end

	add_referee (a_data_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR; an_index: INTEGER) is
			-- Add `a_data_descriptor' to `referees'.
		require
			non_void_descriptor: a_data_descriptor /= Void
			valid_index: an_index > 0 and an_index <= descriptors.count
		do
			referees.item (an_index).force (a_data_descriptor)
		end

	generate  is
			-- Create `descriptors' array.
		local
			i: INTEGER
		do
			progress_report.set_range (progress_report.range + type_lib.type_info_count)
			from
				i := 0
			until
				i = type_lib.type_info_count or Shared_wizard_environment.abort
			loop
				if descriptors.item (i + 1) = Void then
					add_descriptor (Type_descriptor_factory.create_type_descriptor (
									type_lib.documentation (i), type_lib.type_info (i)), i + 1)
				end
				i := i + 1
				progress_report.step
			end
		end

	finalize_inherited_interfaces is
			-- Set references to inherited interfaces.
		require
			complete: complete
		local
			i: INTEGER
			interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if (descriptors.item (i).type_kind = Tkind_interface) or (descriptors.item (i).type_kind = Tkind_dispatch) then
						interface_descriptor ?= descriptors.item (i)
						if interface_descriptor /= Void then
							if 
								interface_descriptor.inherited_interface = Void and 
								interface_descriptor.inherited_interface_descriptor /= Void
							then
								interface_descriptor.initialize_inherited_interface
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
			i: INTEGER
			interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if 
						(descriptors.item (i).type_kind = Tkind_interface) or 
						(descriptors.item (i).type_kind = Tkind_dispatch) 
					then
						interface_descriptor ?= descriptors.item (i)
						if interface_descriptor /= Void then
							interface_descriptor.finalize_interface_functions
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
			i, local_counter: INTEGER
			tmp_string: STRING
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if 
						system_descriptor.eiffel_names.has (descriptors.item (i).eiffel_class_name) 
					then
						local_counter := counter
						create tmp_string.make (3)
						tmp_string.append_integer (local_counter)
						descriptors.item (i).eiffel_class_name.append (tmp_string)
						if not (descriptors.item (i).type_kind = Tkind_alias) then
							if 
								descriptors.item (i).c_header_file_name /= Void and then 
								not descriptors.item (i).c_header_file_name.empty 
							then
								descriptors.item (i).c_header_file_name.insert 
									(tmp_string, descriptors.item (i).c_header_file_name.index_of ('.', 1))
							end
						end
						descriptors.item (i).c_type_name.append (tmp_string)
						descriptors.item (i).name.append (tmp_string)
					end
					system_descriptor.eiffel_names.force (descriptors.item (i).eiffel_class_name, descriptors.item (i).eiffel_class_name)
				end
				i := i + 1
			end
		end

	finalize_aliases is
			-- Remove anonymous aliases.
		require
			complete: complete
		local
			i: INTEGER
			alias_descriptor: WIZARD_ALIAS_DESCRIPTOR
			user_defined_type_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			a_name: STRING
			a_lib: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			an_index: INTEGER
			aliased_descriptor: WIZARD_TYPE_DESCRIPTOR
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if (descriptors.item (i).type_kind = Tkind_alias) then
						alias_descriptor ?= descriptors.item (i)
						if alias_descriptor /= Void then
							user_defined_type_descriptor ?= alias_descriptor.type_descriptor
							if user_defined_type_descriptor /= Void then
								a_lib := user_defined_type_descriptor.library_descriptor
								an_index := user_defined_type_descriptor.type_descriptor_index
								aliased_descriptor := a_lib.descriptors.item (an_index)
								a_name := clone (aliased_descriptor.name)
								a_name.to_upper
								if 
									(a_name.substring_index ("__MIDL___MIDL_", 1) > 0) or
									(a_name.substring_index ("TAG", 1) > 0)
								then
									aliased_descriptor.set_name (descriptors.item (i).name)
									aliased_descriptor.set_c_type_name (descriptors.item (i).name)
									aliased_descriptor.set_eiffel_class_name 
										(name_for_class (descriptors.item (i).name, aliased_descriptor.type_kind, False))
									aliased_descriptor.set_c_header_file_name (header_name (aliased_descriptor.c_type_name))
								end
									
								from
									referees.item (i).start
								until
									referees.item (i).after
								loop
									referees.item (i).item.set_type_descriptor_index (an_index)
									referees.item (i).item.set_library_descriptor (a_lib)
									referees.item (i).forth
								end
								descriptors.put (Void, i)
							end
						end
					end
				end
				i := i + 1
			end
		end

	finalize_interface_feature_names is
			-- Remove feature name clashes on interface level.
		require
			complete: complete
		local
			i: INTEGER
			interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if (descriptors.item (i).type_kind = Tkind_interface) or 
						(descriptors.item (i).type_kind = Tkind_dispatch)
					then
						interface_descriptor ?= descriptors.item (i)
						if interface_descriptor /= Void then
							interface_descriptor.disambiguate_eiffel_names
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
			i: INTEGER
			coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if (descriptors.item (i).type_kind = Tkind_coclass) then
						coclass_descriptor ?= descriptors.item (i)
						if coclass_descriptor /= Void then
							coclass_descriptor.disambiguate_feature_names
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
			i: INTEGER
			interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			implemented_interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR
		do
			from
				i := 1
			variant
				descriptors.count - i + 1
			until
				i > descriptors.count
			loop
				if descriptors.item (i) /= Void then
					if (descriptors.item (i).type_kind = Tkind_interface) or 
						(descriptors.item (i).type_kind = Tkind_dispatch)
					then
						interface_descriptor ?= descriptors.item (i)
						if interface_descriptor /= Void then
							if 
								(system_descriptor.is_iunknown or 
								not referees.item (i).empty) and 
								not Non_generated_type_libraries.has (guid) 
							then
								if not (interface_descriptor.inherited_interface = Void) then
									implemented_interface_descriptor := interface_descriptor.implemented_interface
									system_descriptor.interfaces.force (implemented_interface_descriptor)
								end
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

end -- class WIZARD_TYPE_LIBRARY_DESCRIPTOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

