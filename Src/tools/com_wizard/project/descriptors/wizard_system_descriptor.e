indexing
	description: "System descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SYSTEM_DESCRIPTOR

inherit 
	WIZARD_SPECIAL_TYPE_LIBRARIES

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize system descriptor.
		do
			create library_descriptors.make (5)
			create {ARRAYED_LIST [WIZARD_ENUM_DESCRIPTOR]} enumerators.make (20)
			create {ARRAYED_LIST [WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR]} interfaces.make (20)
			interfaces.compare_objects
			create {ARRAYED_LIST [WIZARD_COCLASS_DESCRIPTOR]} coclasses.make (20)
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

			create {ARRAYED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes_client.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes_server.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER_VISIBLE_CLAUSE]} visible_classes_common.make (20)
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
			valid_file_name: not a_type_library_file_name.is_empty
		local
			l_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			l_type_lib: ECOM_TYPE_LIB
		do
			create l_type_lib.make_from_name (a_type_library_file_name)
			create l_descriptor.make (l_type_lib)
			type_lib_guid := l_descriptor.guid
			name := l_descriptor.name.twin
			add_library_descriptor (l_descriptor)
			
			-- Pass 1: generate raw descriptors except coclasses
			l_descriptor.generate
			progress_report.step

			-- Pass 2: generate inherited interfaces
			from
				start
			until
				after or environment.abort
			loop
				l_descriptor := library_descriptor_for_iteration
				l_descriptor.set_complete
				l_descriptor.finalize_inherited_interfaces
				forth
			end
			progress_report.step
			
			-- Pass 3: Build interface vtable and IDispatch feature tables
			from
				start
			until
				after or environment.abort
			loop
				l_descriptor := library_descriptor_for_iteration
				if not Non_generated_type_libraries.has (l_descriptor.guid) then
					l_descriptor.finalize_interface_features
				end
				forth
			end
			progress_report.step

			-- Pass 4: Resolve Eiffel class name clashes,
			--         Resolve interface feature names clashes,
			--         Initialize implemented interfaces for server implementation
			from
				start
			until
				after or environment.abort
			loop
				l_descriptor := library_descriptor_for_iteration
				l_descriptor.finalize_aliases
				if not Non_generated_type_libraries.has (l_descriptor.guid) then
					l_descriptor.finalize_names
					l_descriptor.finalize_interface_feature_names
					l_descriptor.create_implemented_interfaces
				end
				forth
			end
			progress_report.step
			
			-- Pass 5: Resolve coclass (Eiffel and C) feature names clashes
			from
				start
			until
				after or environment.abort
			loop
				l_descriptor := library_descriptor_for_iteration
				if not Non_generated_type_libraries.has (l_descriptor.guid) then
					l_descriptor.finalize_coclass_feature_names
				end
				forth
			end
			progress_report.step
			l_type_lib.release
		rescue
			if l_type_lib /= Void then
				l_type_lib.release
			end
		end

	add_library_descriptor (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Add `descriptor' to `library_descriptors'.
		require
			non_void_descriptor: a_descriptor /= Void
			not_has_descriptor: not has_library (a_descriptor.guid)
		do
			library_descriptors.put (a_descriptor, a_descriptor.guid.to_string)
		ensure
			has_descriptor: has_library (a_descriptor.guid)
		end

	add_enumerator (a_enumerator: WIZARD_ENUM_DESCRIPTOR) is
			-- Add `a_enumerator' to `enumerators'
		require
			non_void_descriptor: a_enumerator /= Void
		do
			enumerators.force (a_enumerator)
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
			valid_type: not a_type.is_empty
		do
			c_types.force (a_type.twin, a_type.twin)
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
end -- class WIZARD_SYSTEM_DESCRIPTOR

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

