indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_C_GENERATOR

inherit
	WIZARD_CPP_WRITER_GENERATOR

feature -- Access

	dispatch_interface: BOOLEAN
			-- Is coclass contained dispatch interface?

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	generate_functions_and_properties (descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate functions and properties.
		require
			non_void_descriptor: descriptor /= Void
			non_void_cpp_class_writer: cpp_class_writer /= Void
		deferred
		end

	iid_name (a_name: STRING): STRING is
			-- Name of IID constant.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Iid_type)
			Result.append ("_")
			Result.append (a_name)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.empty
		end

	iid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of IID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Const)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append (Space)
			Result.append (iid_name (a_name))
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (a_guid.to_definition_string)
			Result.append (Semicolon)
		ensure
			non_void_definition: Result /= Void
			valid_definition: not Result.empty
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation


end -- class WIZARD_COMPONENT_C_GENERATOR

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
