indexing
	description: "System descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SYSTEM_DESCRIPTOR

inherit 
	WIZARD_SPECIAL_TYPE_LIBRARIES

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize system descriptor.
		do
			create library_descriptors.make (5)
			create {LINKED_LIST [WIZARD_ENUM_DESCRIPTOR]} enumerators.make
			create {LINKED_LIST [WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR]} 
					interfaces.make
			interfaces.compare_objects
			create {LINKED_LIST [WIZARD_COCLASS_DESCRIPTOR]} coclasses.make
			create eiffel_names.make (100)
			eiffel_names.compare_objects

			eiffel_names.force ("FONT_AUTO_INTERFACE", "FONT_AUTO_INTERFACE")
			eiffel_names.force ("FONT_INTERFACE", "FONT_INTERFACE")
			eiffel_names.force ("FONT_EVENTS_AUTO_INTERFACE", "FONT_EVENTS_AUTO_INTERFACE")
			eiffel_names.force ("FONT_EVENTS_INTERFACE", "FONT_EVENTS_INTERFACE")
			eiffel_names.force ("FONT_EVENTS_IMPL_PROXY", "FONT_EVENTS_IMPL_PROXY")
			eiffel_names.force ("FONT_IMPL_PROXY", "FONT_IMPL_PROXY")
			eiffel_names.force ("IENUM_VARIANT_INTERFACE", "IENUM_VARIANT_INTERFACE")
			eiffel_names.force ("IENUM_VARIANT_IMPL_PROXY", "IENUM_VARIANT_IMPL_PROXY")
			eiffel_names.force ("IFONT_IMPL_PROXY", "IFONT_IMPL_PROXY")
			eiffel_names.force ("IFONT_INTERFACE", "IFONT_INTERFACE")
			eiffel_names.force ("IPICTURE_INTERFACE", "IPICTURE_INTERFACE")
			eiffel_names.force ("PICTURE_AUTO_INTERFACE", "PICTURE_AUTO_INTERFACE")
			eiffel_names.force ("PICTURE_INTERFACE", "PICTURE_INTERFACE")
			eiffel_names.force ("PICTURE_IMPL_PROXY", "PICTURE_IMPL_PROXY")

			create {LINKED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes_client.make
			create {LINKED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes_server.make
			create {LINKED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes_common.make
			create c_types.make (20)
		ensure
			non_void_library_descriptors: library_descriptors /= Void
			non_void_enumerators: enumerators /= Void
			non_void_interfaces: interfaces /= Void
			non_void_coclasses: coclasses /= Void
			non_void_eiffel_names: eiffel_names /= Void
			non_void_visible_classes_client: visible_classes_client /= Void
			non_void_visible_classes_server: visible_classes_server /= Void
			non_void_visible_classes_common: visible_classes_common /= Void
			non_void_c_types: c_types /= Void
		end

feature -- Access

	has_library (guid: ECOM_GUID): BOOLEAN is
			-- Does `library_descriptors' have library descriptor with GUID `guid'?
		do
			Result := library_descriptors.has (guid.to_string)
		end

	library_descriptor (guid: ECOM_GUID): WIZARD_TYPE_LIBRARY_DESCRIPTOR is
			-- Library descriptor with GUID `guid'
		require
			has_library: has_library (guid)
		do
			Result := library_descriptors.item (guid.to_string)
		ensure
			valid_descriptor: Result /= Void
		end

	library_descriptor_for_iteration: WIZARD_TYPE_LIBRARY_DESCRIPTOR is
			-- Library descriptor for current cursor position
		do
			Result := library_descriptors.item_for_iteration
		end

	after: BOOLEAN is
			-- Is cursor off descriptor list?
		do
			Result := library_descriptors.after
		end

	enumerators: LIST [WIZARD_ENUM_DESCRIPTOR]
			-- List of enumerators in system.

	interfaces: LIST [WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR]
			-- List of implemented interfaces.

	coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
			-- List of coclasses in system.

	visible_classes_client: LIST [WIZARD_WRITER_VISIBLE_CLAUSE]
			-- List of visible classes in client cluster.

	visible_classes_server: LIST [WIZARD_WRITER_VISIBLE_CLAUSE]
			-- List of visible classes in server cluster.

	visible_classes_common: LIST [WIZARD_WRITER_VISIBLE_CLAUSE]
			-- List of visible classes in system.

	is_iunknown: BOOLEAN
			-- Is IUnknown referenced as data type in system?

	eiffel_names:HASH_TABLE [STRING, STRING]
			-- List of Eiffel names in system.

	c_types: HASH_TABLE [STRING, STRING]
			-- List ot C types in system.

	name: STRING 
			-- System name.

	type_lib_guid: ECOM_GUID
			-- GUID of Type Library that started system.

feature -- Status report

	is_generated_coclass (a_coclass: WIZARD_COCLASS_DESCRIPTOR): BOOLEAN is
			-- Is `a_coclass' generated?
		require
			non_void_coclass: a_coclass /= Void
		do
			Result := not Non_generated_type_libraries.has (a_coclass.type_library_descriptor.guid)
		end

feature -- Basic operations

	generate (a_type_library_file_name: STRING) is
			-- Generate system descriptors according to `a_type_library_file_name'.
		require
			non_void_file_name: a_type_library_file_name /= Void
			valid_file_name: not a_type_library_file_name.empty
		local
			a_type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			a_type_lib: ECOM_TYPE_LIB
		do
			create a_type_lib.make_from_name (a_type_library_file_name)
			create a_type_library_descriptor.make (a_type_lib)
			type_lib_guid := a_type_library_descriptor.guid
			name := clone (a_type_library_descriptor.name)
			add_library_descriptor (a_type_library_descriptor)
			a_type_library_descriptor.generate

			from
				start
			until
				after
			loop
				a_type_library_descriptor := library_descriptor_for_iteration
				a_type_library_descriptor.set_complete
				a_type_library_descriptor.finalize_inherited_interfaces
				forth
			end
			from
				start
			until
				after
			loop
				if not Non_generated_type_libraries.has (library_descriptor_for_iteration.guid) then
					library_descriptor_for_iteration.finalize_interface_features
				end
				forth
			end
			from
				start
			until
				after
			loop
				a_type_library_descriptor := library_descriptor_for_iteration
				a_type_library_descriptor.finalize_aliases
				if not Non_generated_type_libraries.has (library_descriptor_for_iteration.guid) then
					a_type_library_descriptor.finalize_names
					a_type_library_descriptor.finalize_interface_feature_names
					a_type_library_descriptor.create_implemented_interfaces
				end
				forth
			end
			from
				start
			until
				after
			loop
				if not Non_generated_type_libraries.has (library_descriptor_for_iteration.guid) then
					library_descriptor_for_iteration.finalize_coclass_feature_names
				end
				forth
			end
		end

	add_library_descriptor (descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Add `descriptor' to `library_descriptors'.
		require
			non_void_descriptor: descriptor /= Void
			not_has_descriptor: not has_library (descriptor.guid)
		do
			library_descriptors.put (descriptor, descriptor.guid.to_string)
		ensure
			has_descriptor: has_library (descriptor.guid)
		end

	add_enumerator (an_enumerator: WIZARD_ENUM_DESCRIPTOR) is
			-- Add `an_enumerator' to `enumerators'
		require
			non_void_descriptor: an_enumerator /= Void
		do
			enumerators.force (an_enumerator)
		end

	add_coclass (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add `a_coclass to `coclasses
		require
			non_void_descriptor: a_coclass /= Void
		do
			coclasses.force (a_coclass)
		end

	add_visible_class_client (a_class: WIZARD_WRITER_VISIBLE_CLAUSE) is
			-- Add `a_class' to `visible_classes_client'
		require
			non_void_descriptor: a_class /= Void
		do
			visible_classes_client.force (a_class)
		end

	add_visible_class_server (a_class: WIZARD_WRITER_VISIBLE_CLAUSE) is
			-- Add `a_class' to `visible_classes_server'
		require
			non_void_descriptor: a_class /= Void
		do
			visible_classes_server.force (a_class)
		end

	add_visible_class_common (a_class: WIZARD_WRITER_VISIBLE_CLAUSE) is
			-- Add `a_class' to `visible_classes_common'
		require
			non_void_descriptor: a_class /= Void
		do
			visible_classes_common.force (a_class)
		end

	start is
			-- Set cursor to first descriptor
		do
			library_descriptors.start
		end

	forth is
			-- Change cursor to next descriptor in iteration
		do
			library_descriptors.forth
		end

	set_iunknown is
			-- Set `is_inknown' to `True'.
		do
			is_iunknown := True
		end

	add_c_type (a_type: STRING) is
			-- Add `a_type' to list of C types.
		require
			non_void_type: a_type /= Void
			valid_type: not a_type.empty
		do
			c_types.force (clone (a_type), clone (a_type))
		ensure
			has: c_types.has (a_type)
		end

feature {NONE} -- Implementation

	library_descriptors: HASH_TABLE[WIZARD_TYPE_LIBRARY_DESCRIPTOR, STRING]
			-- Hash table of library descriptors,
			-- key is GUID of library

invariant
	valid_library_descriptors: library_descriptors /= Void
	valid_enumerators: enumerators /= Void
	valid_interfaces: interfaces /= Void
	valid_coclasses: coclasses /= Void
	valid_eiffel_names: eiffel_names /= Void

end -- class WIZARD_SYSTEM_DESCRIPTOR

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

