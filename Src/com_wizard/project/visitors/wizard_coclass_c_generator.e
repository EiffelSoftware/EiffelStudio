indexing
	description: "Coclass C generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_C_GENERATOR

inherit
	WIZARD_COMPONENT_C_GENERATOR

feature -- Initialization

	initialize is
			-- Initialize generator.
		do
			cpp_class_writer := Void
			interface_names := Void
			dispatch_interface := False
		ensure
			void_atributes: cpp_class_writer = Void and
				interface_names = Void and
				dispatch_interface = False
		end


feature {NONE} -- Access

	interface_names: LINKED_LIST[STRING]
			-- Interface names


feature {NONE} -- Implementation

	clsid_name (a_name: STRING): STRING is
			-- Name of CLSID constant.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Clsid_type)
			Result.append ("_")
			Result.append (a_name)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.empty
		end


	clsid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of CLSID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Const)
			Result.append (Space)
			Result.append (Clsid_type)
			Result.append (Space)
			Result.append (clsid_name (a_name))
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (a_guid.to_definition_string)
			Result.append (Semicolon)
		ensure
			non_void_definition: Result /= Void
			valid_definition: not Result.empty
		end


	clsid_declaration (a_name: STRING): STRING is
			-- Declaration of CLSID in header file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			-- extern "C" CLSID CLSID_`a_name';

			create Result.make (0)
			Result.append (Extern)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append ("C")
			Result.append (Double_quote)
			Result.append (Space)
			Result.append (Const)
			Result.append (Space)
			Result.append (Clsid_type)
			Result.append (Space)
			Result.append (clsid_name (a_name))
			Result.append (Semicolon)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.empty
		end

end -- class WIZARD_COCLASS_C_GENERATOR

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

