indexing
	description: "Creator of Interface descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INTERFACE_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT	
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end
	
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then
				a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		local
			a_handle: INTEGER
			tmp_type_info: ECOM_TYPE_INFO
			dispinterface_creator: WIZARD_INTERFACE_DESCRIPTOR_CREATOR
		do
			name := clone (a_documentation.name)
			if name /= Void then
				add_c_type
			end

			description := clone (a_documentation.doc_string)
			type_kind := a_type_info.type_attr.type_kind

			if type_kind = Tkind_dispatch then
				dispinterface := True
			end
			flags := a_type_info.type_attr.flags
			if is_typeflag_fdual (flags) then
				dual := True
			end

			if dual and dispinterface then
				a_handle := a_type_info.ref_type_of_impl_type (-1)
				tmp_type_info := a_type_info.type_info (a_handle)
				type_kind := tmp_type_info.type_attr.type_kind
				dispinterface := False
				create dispinterface_creator
				dispinterface_descriptor := dispinterface_creator.create_dispinterface_descriptor (a_documentation, a_type_info)
			else
				check
					not_dual: not dual
				end
				tmp_type_info := a_type_info
			end
			Result := interface_descriptor (tmp_type_info)
		end

	create_dispinterface_descriptor  (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then
				a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		do
			name := clone (a_documentation.name)

			description := clone (a_documentation.doc_string)
			type_kind := a_type_info.type_attr.type_kind

			if type_kind = Tkind_dispatch then
				dispinterface := True
			end
			flags := a_type_info.type_attr.flags
			if is_typeflag_fdual (flags) then
				dual := True
			end

			Result := interface_descriptor (a_type_info)
		ensure
			non_void_dispinterface: Result /= Void
		end

	interface_descriptor (a_type_info: ECOM_TYPE_INFO): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		local
			tmp_type_attr: ECOM_TYPE_ATTR
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
		do
			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid	
			tmp_type_attr := a_type_info.type_attr
			create guid.make_from_guid (tmp_type_attr.guid)

			type_library_descriptor := system_descriptor.library_descriptor (tmp_guid)
			add_type_lib_description (type_library_descriptor)

			if name = Void or else name.is_empty then
				create name.make (100)
				name.append ("interface_")
				name.append (type_library_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end


			if prefixed_libraries.has (tmp_guid) then
				name.prepend (Underscore)
				name.prepend (type_library_descriptor.name)
			end

			create c_type_name.make (100)
			c_type_name.append (name)
			system_descriptor.add_c_type (name)

			if 
				not name.is_equal (Iunknown_type) and
				not name.is_equal (Idispatch_type)
			then
				namespace := namespace_name (type_library_descriptor.name)
				eiffel_class_name := name_for_class (name, type_kind, False)

				create c_header_file_name.make (100)
				if not Non_generated_type_libraries.has (type_library_descriptor.guid) then
					c_header_file_name := header_name (namespace, name)
				end
			else
				eiffel_class_name := clone (Ecom_interface)
				create c_header_file_name.make (0)
				create namespace.make (0)
			end

			lcid := tmp_type_attr.lcid
			vtbl_size := tmp_type_attr.vtbl_size

			if a_type_info.type_attr.count_implemented_types > 0 then
				create_inherited_interface (a_type_info)
			end

			create feature_names.make
			create_function_descriptors (a_type_info)
			create_property_descriptors (a_type_info)
			if 
				inherited_interface /= Void or 
				inherited_interface_descriptor /= Void or 
				c_type_name.is_equal (Iunknown_type) 
			then
				create Result.make (Current)
			end
		ensure then
			valid_guid: guid /= Void
			valid_functions: a_type_info.type_attr.count_func > 0 implies
					vtable_functions /= Void and dispatch_functions /= Void
			valid_properties: a_type_info.type_attr.count_variables > 0 implies
					properties /= Void 
			valid_interface: a_type_info.type_attr.count_implemented_types > 0 implies
						inherited_interface /= Void or inherited_interface_descriptor /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
				-- Initialize Descriptor
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_vtable_functions (vtable_functions)
				a_descriptor.set_dispatch_functions (dispatch_functions)
				a_descriptor.set_function_table (function_table)
				a_descriptor.set_properties (properties)
				a_descriptor.set_inherited_interface (inherited_interface)
				a_descriptor.set_inherited_interface_descriptor (inherited_interface_descriptor)
				a_descriptor.set_dispinterface_descriptor (dispinterface_descriptor)
				a_descriptor.update_dual (dual)
				a_descriptor.update_dispinterface (dispinterface)
				a_descriptor.set_lcid (lcid)
				a_descriptor.set_vtbl_size (vtbl_size)
				a_descriptor.set_flags (flags)
				a_descriptor.set_type_library (type_library_descriptor)
			end

	create_function_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create function descriptors
		require
			valid_type_info: a_type_info /= Void
		local
			i, count: INTEGER
			a_function_descriptor: WIZARD_FUNCTION_DESCRIPTOR
			a_func_desc: ECOM_FUNC_DESC
			function_descriptor_factory: WIZARD_FUNCTION_DESCRIPTOR_FACTORY
		do
			count := a_type_info.type_attr.count_func
			from
				i := 0
				create vtable_functions.make
				create dispatch_functions.make
				create function_table.make
			variant
				count - i
			until
				i = count
			loop
				a_func_desc := a_type_info.func_desc (i)
				create function_descriptor_factory
				a_function_descriptor := function_descriptor_factory.create_descriptor (a_type_info, a_func_desc)

				if feature_names.has (a_function_descriptor.name) then
					a_function_descriptor.name.append_integer (counter)
				end
				feature_names.extend (a_function_descriptor.name)
				function_table.force (a_function_descriptor)
				i := i + 1
			end
		ensure
			valid_functions: a_type_info.type_attr.count_func > 0 implies
					vtable_functions /= Void and 
					dispatch_functions /= Void and 
					function_table /= Void
		end


	create_property_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create property descriptors
		require
			valid_type_info: a_type_info /= Void
		local
			i, count: INTEGER
			a_property_descriptor: WIZARD_PROPERTY_DESCRIPTOR
			property_descriptor_factory: WIZARD_PROPERTY_DESCRIPTOR_FACTORY
		do
			count := a_type_info.type_attr.count_variables
			from
				i := 0
				create properties.make
			variant
				count - i
			until
				i = count
			loop
				create property_descriptor_factory
				a_property_descriptor := property_descriptor_factory.create_descriptor (a_type_info, i)
				if feature_names.has (a_property_descriptor.name) then
					a_property_descriptor.name.append_integer (counter)
				end
				feature_names.extend (a_property_descriptor.name)
				properties.force (a_property_descriptor)
				i := i + 1
			end
		ensure
			valid_properties: a_type_info.type_attr.count_variables > 0 implies
					properties /= Void 
		end

	create_inherited_interface (a_type_info: ECOM_TYPE_INFO) is
			-- Create inherited interface descriptors
		require
			valid_type_info: a_type_info /= void
			have_inherited_interface: a_type_info.type_attr.count_implemented_types > 0
		local
			a_handle: INTEGER
			tmp_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			tmp_type_info: ECOM_TYPE_INFO
			tmp_descriptor_index: INTEGER
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			a_handle := a_type_info.ref_type_of_impl_type (0)
			tmp_type_info := a_type_info.type_info (a_handle)

			tmp_descriptor_index := tmp_type_info.index_in_type_lib + 1
			tmp_type_lib := tmp_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			if system_descriptor.has_library (tmp_guid) then
				tmp_library_descriptor := system_descriptor.library_descriptor (tmp_guid)
			else
				create tmp_library_descriptor.make (tmp_type_lib)
				system_descriptor.add_library_descriptor (tmp_library_descriptor)
				tmp_library_descriptor.generate
			end
			if tmp_library_descriptor.descriptors.item (tmp_descriptor_index) = void then
				create inherited_interface_descriptor.make (tmp_library_descriptor, tmp_descriptor_index)
				
			else
				tmp_interface_descriptor ?= tmp_library_descriptor.descriptors.item (tmp_descriptor_index)
				if tmp_interface_descriptor = void then
					raise ("Type descriptor is not inteface descriptor")
				end
			end;
			inherited_interface := tmp_interface_descriptor
		ensure
			valid_interfaces: inherited_interface /= Void or inherited_interface_descriptor /= Void
		end

feature {NONE} -- Implementation

	vtable_functions: SORTED_TWO_WAY_LIST[WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's functions

	dispatch_functions: LINKED_LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's dispatch functions.

	function_table: LINKED_LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Table of interface functions.
			-- Needed for fast search.

	properties: LINKED_LIST [WIZARD_PROPERTY_DESCRIPTOR]
			-- Descriptions of interface's properties

	inherited_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Description of inherited interface
	
	inherited_interface_descriptor: WIZARD_INHERITED_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	dual: BOOLEAN
			-- Is dual interface?

	dispinterface: BOOLEAN
			-- Is dispinterface?

	dispinterface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- If interface is dual, then it has dual description as dispinterface.

	lcid: INTEGER
			-- Locale of member names and doc strings.

	vtbl_size: INTEGER
			-- Size of type's VTBL

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values.

	feature_names: SORTED_TWO_WAY_LIST [STRING]
			-- Names of functions and features.

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

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

end -- class WIZARD_INTERFACE_DESCRIPTOR_CREATOR

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

