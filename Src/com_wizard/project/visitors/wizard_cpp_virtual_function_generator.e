indexing
	description: "Cpp virtual function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR
		redefine
			add_header_file
		end

feature -- Access

	forward_declarations: LIST [STRING]
			-- Forward type declarations.

	c_header_files_after: LIST [STRING]

feature -- Basic operations

	generate (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate pure virtual function
		require
			non_void_descriptor: a_descriptor /= Void
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			l_header_file: STRING
		do
			func_desc := a_descriptor

			create ccom_feature_writer.make
			create {ARRAYED_LIST [STRING]} c_header_files.make (20)
			create {ARRAYED_LIST [STRING]} forward_declarations.make (20)
			create {ARRAYED_LIST [STRING]} c_header_files_after.make (20)
			ccom_feature_writer.set_pure_virtual
			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment (func_desc.description)

			l_visitor := func_desc.return_type.visitor 
			set_vtable_function_return_type
			l_header_file := l_visitor.c_declaration_header_file_name
			if l_header_file /= Void and then not l_header_file.is_empty then
				c_header_files.force (l_header_file)
			end

			ccom_feature_writer.set_signature (vtable_signature)
		ensure
			ccom_feature_writer_exist: ccom_feature_writer /= Void
			function_descriptor_exist: func_desc /= Void
		end

	generate_dual (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate pure virtual function
		require
			non_void_descriptor: a_descriptor /= Void
		local
			signature, l_header_file: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			func_desc := a_descriptor

			create ccom_feature_writer.make
			create {ARRAYED_LIST [STRING]} c_header_files.make (20)
			create {ARRAYED_LIST [STRING]} forward_declarations.make (20)
			create {ARRAYED_LIST [STRING]} c_header_files_after.make (20)
			ccom_feature_writer.set_pure_virtual

			create signature.make (1000)

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment(func_desc.description)

			ccom_feature_writer.set_result_type(Std_method_imp)

			if not func_desc.arguments.is_empty or else not func_desc.return_type.name.is_equal (Void_c_keyword) then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					visitor := func_desc.arguments.item.type.visitor 

					signature.append (visitor.c_type)
					if visitor.is_array_type then
						signature.append (Asterisk)
					end
					signature.append (" ")
					signature.append (func_desc.arguments.item.name)
					signature.append (",")
					l_header_file := visitor.c_declaration_header_file_name
					if l_header_file /= Void and then not l_header_file.is_empty then
						c_header_files.force (l_header_file)
					end

					func_desc.arguments.forth
				end

				visitor := a_descriptor.return_type.visitor 

				if visitor.c_type.is_equal ("void") then
					-- Remove the last comma
					if signature.item (signature.count).is_equal(',') then
						signature.remove (signature.count)
					end
				else
					signature.append (visitor.c_type)
					signature.append (" *ret_value")
				end
					
				l_header_file := visitor.c_declaration_header_file_name
				if l_header_file /= Void and then not l_header_file.is_empty then
					c_header_files.force (l_header_file)
				end
			end

			ccom_feature_writer.set_signature (signature)
		ensure
			ccom_feature_writer_exist: ccom_feature_writer /= Void
			function_descriptor_exist: func_desc /= Void
		end

	add_header_file (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Add header file to list of header files if needed.
		local
			a_visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			l_header_file: STRING
		do
			a_visitor := a_descriptor.visitor
			l_header_file := a_visitor.c_declaration_header_file_name
			if l_header_file /= Void and then not l_header_file.is_empty then
				if a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer then
					pointed_descriptor ?= a_descriptor
					if pointed_descriptor /= Void then
						interface_descriptor := pointed_descriptor.interface_descriptor
						forward_declarations.force 
							(forward_interface_declaration (interface_descriptor.c_type_name, interface_descriptor.namespace))
							c_header_files_after.force (l_header_file)
					else
						c_header_files.force (l_header_file)
					end
				else
					c_header_files.force (l_header_file)
				end
			end
		end

	forward_interface_declaration (a_name, a_namespace: STRING): STRING is
			-- Forward declaration of interface.
		local
			interface_declaration: WIZARD_WRITER_FORWARD_CLASS_DECLARATION
		do
			create interface_declaration.make (a_name, a_namespace, True)
			Result := interface_declaration.generated_code
		end
		
end -- class WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR

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
