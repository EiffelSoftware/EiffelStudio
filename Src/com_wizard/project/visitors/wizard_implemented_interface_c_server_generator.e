indexing
	description: "Implemented interface generator for C server"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_C_SERVER_GENERATOR

inherit
	WIZARD_IMPLEMENTED_INTERFACE_C_GENERATOR

	WIZARD_COMPONENT_C_SERVER_GENERATOR

feature -- Access

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

	generate (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate C server for implemented interface.
		local
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			create cpp_class_writer.make

			-- Initialization
			dispatch_interface := False

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)

			cpp_class_writer.add_import (a_descriptor.interface_descriptor.c_header_file_name)
			cpp_class_writer.add_other_source (iid_definition (a_descriptor.interface_descriptor.name, a_descriptor.interface_descriptor.guid))

			-- Import header file
			cpp_class_writer.add_import (Ecom_server_rt_globals_h)

			-- Add jmp_buf variable and integer value
			cpp_class_writer.add_other_source ("int return_hr_value;")
			cpp_class_writer.add_other_source ("jmp_buf exenv;")

			-- member (LONG Ref_count)
			create member_writer.make
			member_writer.set_name (Ref_count)
			member_writer.set_result_type (Long_macro)
			member_writer.set_comment ("Reference counter")
			cpp_class_writer.add_member (member_writer, Private)

			-- member (EIF_OBJECT eiffel_object)
			create member_writer.make
			member_writer.set_name (Eiffel_object)
			member_writer.set_result_type (Eif_object)
			member_writer.set_comment ("Corresponding Eiffel object")
			cpp_class_writer.add_member (member_writer, Private)

			-- member (EIF_TYPE_ID type_id)
			create member_writer.make
			member_writer.set_name (Type_id)
			member_writer.set_result_type (Eif_type_id)
			member_writer.set_comment ("Eiffel type id")
			cpp_class_writer.add_member (member_writer, Private)


			generate_functions_and_properties (a_descriptor, a_descriptor.interface_descriptor)

			cpp_class_writer.add_constructor (constructor (a_descriptor))

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
		ensure then
			non_void_cpp_class_writer: cpp_class_writer /= Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_c_server
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	constructor (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_interface_descriptor: a_descriptor.interface_descriptor /= Void
		local
			constructor_body: STRING
			a_signature: STRING
		do
			create Result.make

			create a_signature.make (0)
			create constructor_body.make (0)
			constructor_body.append (Tab)
			Result.set_body (constructor_body)
		ensure
			non_void_constructor: Result /= Void
		end

invariant
	invariant_clause: -- Your invariant here

end -- class WIZARD_IMPLEMENTED_INTERFACE_C_SERVER_GENERATOR

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
