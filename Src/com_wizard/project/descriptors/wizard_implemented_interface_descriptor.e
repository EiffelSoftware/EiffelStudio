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
			name.append ("_impl")
			c_type_name := clone (name)
			
			eiffel_class_name := name_for_class (name, type_kind, Shared_wizard_environment.client)

			create c_header_file_name.make (0)
			c_header_file_name.append ("ecom_")
			c_header_file_name.append (name)
			c_header_file_name.append (".h")

			description := "Implemented "
			description.append (Back_quote)
			description.append (a_descriptor.name)
			description.append (Single_quote)
			description.append (Space)
			description.append (Interface)
			description.append (Dot)
		end

feature -- Access

	interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR

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

feature -- Basic operations

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_implemented_interface (Current)
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
