indexing
	description: "System descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SYSTEM_DESCRIPTOR

inherit 
	WIZARD_REJECTED_TYPE_LIBRARIES

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
			create {LINKED_LIST [WIZARD_COCLASS_DESCRIPTOR]} coclasses.make
			create {LINKED_LIST [STRING]} eiffel_names.make
			eiffel_names.compare_objects
			create {LINKED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes.make
		ensure
			non_void_library_descriptors: library_descriptors /= Void
			non_void_enumerators: enumerators /= Void
			non_void_interfaces: interfaces /= Void
			non_void_coclasses: coclasses /= Void
			non_void_eiffel_names: eiffel_names /= Void
			non_void_visible_classes: visible_classes /= Void
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

	visible_classes: LIST [WIZARD_WRITER_VISIBLE_CLAUSE]
			-- List of visible classes in system.

	is_iunknown: BOOLEAN
			-- Is IUnknown referenced as data type in system?

	eiffel_names: LIST [STRING]
			-- List of Eiffel names in system.

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
				a_type_library_descriptor.finalize_aliases
				a_type_library_descriptor.finalize_names
				a_type_library_descriptor.create_implemented_interfaces
				a_type_library_descriptor.finalize_interface_feature_names
				forth
			end
			from
				start
			until
				after
			loop
				library_descriptor_for_iteration.finalize_coclass_feature_names
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

	add_visible_class (a_class: WIZARD_WRITER_VISIBLE_CLAUSE) is
			-- Add `a_class to `visible_classes
		require
			non_void_descriptor: a_class /= Void
		do
			visible_classes.force (a_class)
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

