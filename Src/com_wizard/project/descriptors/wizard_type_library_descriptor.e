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

	WIZARD_REJECTED_TYPE_LIBRARIES
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
			a_component_list: LINKED_LIST [WIZARD_COCLASS_DESCRIPTOR]
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
			name := a_type_lib.documentation (-1).name
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
			-- GUID of Type Library

	name: STRING
			-- Library name

	type_lib: ECOM_TYPE_LIB
			-- Type Library
	
	Generation_title: STRING is "Parsing Type Library"
			-- Generation title

	complete: BOOLEAN
			-- Is generation of library descriptor comlete?

feature -- Status report

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' describes same data type?
		do
			Result := guid.is_equal (other.guid)
		end

feature -- Basic operations

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
			i, a_descriptor: INTEGER
		do
			from
				i := 0
				progress_report.set_range (progress_report.range + type_lib.type_info_count)
				progress_report.set_title (Generation_title)
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
					if system_descriptor.eiffel_names.has (descriptors.item (i).eiffel_class_name) then
						local_counter := counter
						create tmp_string.make (0)
						tmp_string.append_integer (local_counter)
						descriptors.item (i).eiffel_class_name.append (tmp_string)
						if not (descriptors.item (i).type_kind = Tkind_alias) then
							descriptors.item (i).c_header_file_name.insert 
								(tmp_string, descriptors.item (i).c_header_file_name.index_of ('.', 1))
						end
						descriptors.item (i).c_type_name.append (tmp_string)
						descriptors.item (i).name.append (tmp_string)
					end
					system_descriptor.eiffel_names.force (descriptors.item (i).eiffel_class_name)
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
			type_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
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
							type_descriptor ?= alias_descriptor.type_descriptor
							if type_descriptor /= Void then
								a_lib := type_descriptor.library_descriptor
								an_index := type_descriptor.type_descriptor_index
								aliased_descriptor := a_lib.descriptors.item (an_index)
								a_name := clone (aliased_descriptor.name)
								a_name.to_upper
								if (a_name.substring_index ("__MIDL___MIDL_", 1) > 0) then
									aliased_descriptor.set_name (descriptors.item (i).name)
									aliased_descriptor.set_c_type_name (descriptors.item (i).name)
									aliased_descriptor.set_eiffel_class_name 
										(name_for_class (descriptors.item (i).name, aliased_descriptor.type_kind, False))
									aliased_descriptor.set_c_header_file_name (descriptors.item (i).c_header_file_name)
									
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
								else
									alias_descriptor.set_c_header_file_name (clone (Alias_header_file_name))
								end
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
			implemented_interface_Descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR
			type_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
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
								create implemented_interface_descriptor.make_from_interface (interface_descriptor)
								system_descriptor.interfaces.force (implemented_interface_descriptor)
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

