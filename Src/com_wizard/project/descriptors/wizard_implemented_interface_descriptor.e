indexing
	description: "Implemented interface descriptor."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR

inherit
	WIZARD_COMPONENT_DESCRIPTOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_FILE_NAME_FACTORY
		export
			{NONE} all
		end

create
	make_from_interface

feature -- Initialization

	make_from_interface (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Initialize
		require
			non_void_descriptor: a_descriptor /= Void
		do
			interface_descriptor := a_descriptor
			type_kind := Tkind_coclass
			name := a_descriptor.name.twin
			namespace := a_descriptor.namespace.twin
			name.append ("_impl")
			c_type_name := name.twin
			eiffel_class_name := name_for_class (name, type_kind, True)
			c_definition_header_file_name := header_name (namespace, name)
			c_declaration_header_file_name := declaration_header_file_name (c_definition_header_file_name)
			description := "Implemented %Q"
			description.append (a_descriptor.name)
			description.append ("%' interface.")
			type_library_descriptor := a_descriptor.type_library_descriptor
		end

feature -- Access

	interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	creation_message: STRING is
			-- Creation message for wizard output
		do
			create Result.make (1024)
			Result.append ("Processing implemented ")
			if interface_descriptor.dispinterface then
				Result.append ("dispatch interface ")
			else
				Result.append ("interface ")
			end
			Result.append (name)
			Result.append_character ('.')
		end

	source: BOOLEAN
			-- Is source interface?

feature -- Basic operations

	set_source (a_boolean: BOOLEAN) is
			-- Set `source' with `a_boolean'.
		do
			source := a_boolean
		ensure
			source_set: source = a_boolean
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_implemented_interface (Current)
		end

	set_impl_names (is_client: BOOLEAN) is
			-- Set implementation names.
		do
			c_type_name := impl_c_type_name (is_client)
			eiffel_class_name := impl_eiffel_class_name (is_client)
			c_declaration_header_file_name := impl_c_declaration_header_file_name (is_client)
			c_definition_header_file_name := impl_c_definition_header_file_name (is_client)
		end

	impl_c_type_name (is_client: BOOLEAN): STRING is
			-- Implementation C type name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := impl_name (is_client)
		ensure
			non_void_c_type_name: Result /= Void
			valid_c_type_name: not Result.is_empty
		end

	impl_eiffel_class_name (is_client: BOOLEAN): STRING is
			-- Implementation Eiffel class name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := to_eiffel_name (impl_name (is_client))
			Result.to_upper
		ensure
			non_void_class_name: Result /= Void
			valid_class_name: not Result.is_empty
		end

	impl_c_definition_header_file_name (is_client: BOOLEAN): STRING is
			-- Implementation header file name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := header_name (namespace, impl_name (is_client))
		ensure
			non_void_header: Result /= Void
			valid_header: not Result.is_empty
		end

	impl_c_declaration_header_file_name (is_client: BOOLEAN): STRING is
			-- Implementation header file name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := declaration_header_file_name (impl_c_definition_header_file_name (is_client))
		ensure
			non_void_header: Result /= Void
			valid_header: not Result.is_empty
		end

feature {NONE} -- implementation

	impl_name (is_client: BOOLEAN): STRING is
			-- Implementation name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := name.twin
			if is_client then
				Result.append ("_proxy")
			else
				Result.append ("_stub")
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

invariant
	non_void_interface: interface /= Void

end -- class WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR

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
