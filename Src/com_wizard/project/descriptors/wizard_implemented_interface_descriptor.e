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
			name := clone (a_descriptor.name)
			namespace := clone (a_descriptor.namespace)
			name.append ("_impl")
			c_type_name := clone (name)
			
			eiffel_class_name := name_for_class (name, type_kind, True)
				
			c_header_file_name := header_name (namespace, name)

			description := "Implemented "
			description.append (Back_quote)
			description.append (a_descriptor.name)
			description.append (Single_quote)
			description.append (Space)
			description.append (Interface)
			description.append (Dot)

			type_library_descriptor := a_descriptor.type_library_descriptor
		end

feature -- Access

	interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	creation_message: STRING is
			-- Creation message for wizard output
		do
			Result := clone (Processed)
			Result.append (Space)
 			Result.append (Implemented_word)
			Result.append (Space)
			if interface_descriptor.dispinterface then
				Result.append (Dispinterface_string)
			else
				Result.append (Interface)
			end
			Result.append (Space)
			Result.append (name)
			Result.append (Dot)
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
			c_header_file_name := impl_c_header_file_name (is_client)
		end

	impl_c_type_name (is_client: BOOLEAN): STRING is
			-- Implementation C type name.
		require
			non_void_name: name /= Void
			valid_name: not name.empty
		do
			Result := impl_name (is_client)
		ensure
			non_void_c_type_name: Result /= Void
			valid_c_type_name: not Result.empty
		end

	impl_eiffel_class_name (is_client: BOOLEAN): STRING is
			-- Implementation Eiffel class name.
		require
			non_void_name: name /= Void
			valid_name: not name.empty
		do
			Result := to_eiffel_name (impl_name (is_client))
			Result.to_upper
		ensure
			non_void_class_name: Result /= Void
			valid_class_name: not Result.empty
		end

	impl_c_header_file_name (is_client: BOOLEAN): STRING is
			-- Implementation header file name.
		require
			non_void_name: name /= Void
			valid_name: not name.empty
		do
			Result := header_name (namespace, impl_name (is_client))
		ensure
			non_void_header: Result /= Void
			valid_header: not Result.empty
		end

feature {NONE} -- implementation

	impl_name (is_client: BOOLEAN): STRING is
			-- Implementation name.
		require
			non_void_name: name /= Void
			valid_name: not name.empty
		do
			Result := clone (name)
			if is_client then
				Result.append ("_proxy")
			else
				Result.append ("_stub")
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.empty
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
