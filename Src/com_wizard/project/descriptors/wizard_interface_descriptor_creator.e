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

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then
				a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		local
			tmp_type_attr: ECOM_TYPE_ATTR
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
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

			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid	
			tmp_type_attr := a_type_info.type_attr
			create guid.make_from_guid (tmp_type_attr.guid)

--			if not guid.is_equal (Iunknown_guid) then
				tmp_lib_descriptor := system_descriptor.library_descriptor (tmp_guid)
				if name = Void or else name.empty then
					create name.make (0)
					name.append ("interface_")
					name.append (tmp_lib_descriptor.name)
					name.append ("_")
					name.append_integer (a_type_info.index_in_type_lib + 1)
				end

				eiffel_class_name := name_for_class (name, type_kind, False)

				c_type_name := clone (name)
			
				create c_header_file_name.make (0)
				if not Non_generated_type_libraries.has (tmp_lib_descriptor.guid) then
					c_header_file_name.append ("ecom_")
					c_header_file_name.append (name)
					c_header_file_name.append (".h")
				end

				lcid := tmp_type_attr.lcid
				vtbl_size := tmp_type_attr.vtbl_size

				if a_type_info.type_attr.count_implemented_types > 0 then
					create_inherited_interface (a_type_info)
				end

				create feature_names.make
				create_function_descriptors (a_type_info)
				create_property_descriptors (a_type_info)
				create Result.make (Current)
--			end
		ensure then
			valid_guid: guid /= Void
			valid_functions: a_type_info.type_attr.count_func > 0 implies
					functions /= Void 
			valid_properties: a_type_info.type_attr.count_variables > 0 implies
					properties /= Void 
			valid_interface: a_type_info.type_attr.count_implemented_types > 0 implies
						inherited_interface /= Void 
		end

	initialize_descriptor (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
				-- Initialize Descriptor
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_functions (functions)
				a_descriptor.set_properties (properties)
				a_descriptor.set_inherited_interface (inherited_interface)
				a_descriptor.update_dual (dual)
				a_descriptor.update_dispinterface (dispinterface)
				a_descriptor.set_lcid (lcid)
				a_descriptor.set_vtbl_size (vtbl_size)
				a_descriptor.set_flags (flags)
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
				create functions.make
			variant
				count - i
			until
				i = count
			loop
				a_func_desc := a_type_info.func_desc (i)
				create function_descriptor_factory
				a_function_descriptor := function_descriptor_factory.create_descriptor (a_type_info, a_func_desc)
				if inherited_interface = Void or else not inherited_interface.has_function (a_function_descriptor) then
					if feature_names.has (a_function_descriptor.name) then
						a_function_descriptor.name.append_integer (counter)
					end
					feature_names.extend (a_function_descriptor.name)
					functions.force (a_function_descriptor)
				end
				i := i + 1
			end
		ensure
			valid_functions: a_type_info.type_attr.count_func > 0 implies
					functions /= Void 
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
				if inherited_interface = Void or else not inherited_interface.has_property (a_property_descriptor) then
					if feature_names.has (a_property_descriptor.name) then
						a_property_descriptor.name.append_integer (counter)
					end
					feature_names.extend (a_property_descriptor.name)
					properties.force (a_property_descriptor)
				end
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
			i, a_handle: INTEGER;
			tmp_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR;
			tmp_documentation: ECOM_DOCUMENTATION;
			tmp_type_info: ECOM_TYPE_INFO;
			tmp_descriptor_index: INTEGER;
			tmp_type_lib: ECOM_TYPE_LIB;
			tmp_guid: ECOM_GUID;
			tmp_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			a_handle := a_type_info.ref_type_of_impl_type (0);
			tmp_type_info := a_type_info.type_info (a_handle);
			tmp_descriptor_index := tmp_type_info.index_in_type_lib + 1;
			tmp_type_lib := tmp_type_info.containing_type_lib;
			tmp_guid := tmp_type_lib.library_attributes.guid;
			if system_descriptor.has_library (tmp_guid) then
				tmp_library_descriptor := system_descriptor.library_descriptor (tmp_guid)
			else
				create tmp_library_descriptor.make (tmp_type_lib);
				system_descriptor.add_library_descriptor (tmp_library_descriptor);
				tmp_library_descriptor.generate
			end;
			if tmp_library_descriptor.descriptors.item (tmp_descriptor_index) = void then
				tmp_documentation := tmp_type_lib.documentation (tmp_type_info.index_in_type_lib);
				tmp_interface_descriptor ?= type_descriptor_factory.create_type_descriptor (tmp_documentation, tmp_type_info);
				tmp_library_descriptor.add_descriptor (tmp_interface_descriptor, tmp_descriptor_index)
			else
				tmp_interface_descriptor ?= tmp_library_descriptor.descriptors.item (tmp_descriptor_index);
				if tmp_interface_descriptor = void then
					raise ("Type descriptor is not inteface descriptor")
				end
			end;
			inherited_interface := tmp_interface_descriptor
		ensure
			valid_interfaces: a_type_info.type_attr.count_implemented_types > 0 implies inherited_interface /= void
		end;

feature {NONE} -- Implementation

	functions: SORTED_TWO_WAY_LIST[WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's functions

	properties: LINKED_LIST[WIZARD_PROPERTY_DESCRIPTOR]
			-- Descriptions of interface's properties

	inherited_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Description of inherited interface

	dual: BOOLEAN
			-- Is dual interface?

	dispinterface: BOOLEAN
			-- Is dispinterface?

	lcid: INTEGER
			-- Locale of member names and doc strings.

	vtbl_size: INTEGER
			-- Size of type's VTBL

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values.

	feature_names: SORTED_TWO_WAY_LIST [STRING]
			-- Names of functions and features.

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

