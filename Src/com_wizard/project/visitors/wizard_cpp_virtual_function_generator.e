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

feature -- Basic operations

	generate (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate pure virtual function
		require
			non_void_descriptor: a_descriptor /= Void
		local
			signature: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
			a_result_type: STRING
		do
			func_desc := a_descriptor

			create ccom_feature_writer.make
			create c_header_files.make
			ccom_feature_writer.set_pure_virtual

			create signature.make (1000)

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment(func_desc.description)

			visitor := func_desc.return_type.visitor 

			set_vtable_function_return_type

			if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
				c_header_files.force (visitor.c_header_file)
			end

			ccom_feature_writer.set_signature(vtable_signature)

		ensure
			ccom_feature_writer_exist: ccom_feature_writer /= Void
			function_descriptor_exist: func_desc /= Void
		end

	generate_dual (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate pure virtual function
		require
			non_void_descriptor: a_descriptor /= Void
		local
			signature: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			func_desc := a_descriptor

			create ccom_feature_writer.make
			create c_header_files.make
			ccom_feature_writer.set_pure_virtual

			create signature.make (1000)

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment(func_desc.description)

			ccom_feature_writer.set_result_type(Std_method_imp)

			if not func_desc.arguments.empty or else not func_desc.return_type.name.is_equal (Void_c_keyword) then
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
					signature.append (Space)
					signature.append (func_desc.arguments.item.name)
					signature.append (Comma)
					if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
						c_header_files.force (visitor.c_header_file)
					end

					func_desc.arguments.forth
				end

				visitor := a_descriptor.return_type.visitor 

				if visitor.c_type.is_equal (Void_c_keyword) then
					-- Remove the last comma
					if signature.item (signature.count).is_equal(',') then
						signature.remove (signature.count)
					end
				else
					signature.append (visitor.c_type)
					signature.append (Space)
					signature.append (Asterisk)
					signature.append (Return_value_name)
				end
					
				if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
					c_header_files.force (visitor.c_header_file)
				end
			end

			ccom_feature_writer.set_signature(signature)

		ensure
			ccom_feature_writer_exist: ccom_feature_writer /= Void
			function_descriptor_exist: func_desc /= Void
		end

	add_header_file (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Add header file to list of header files if needed.
		do
			if a_visitor.c_header_file /= Void and then not a_visitor.c_header_file.empty then
				c_header_files.force (a_visitor.c_header_file)
			end
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
