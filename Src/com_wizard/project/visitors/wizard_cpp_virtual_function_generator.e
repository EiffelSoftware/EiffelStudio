indexing
	description: "Cpp virtual function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR

feature -- Basic operations

	generate (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
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

			create signature.make (0)

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment(func_desc.description)

			create visitor
			visitor.visit (func_desc.return_type)

			if visitor.c_type.is_equal (Hresult) then
				ccom_feature_writer.set_result_type(Std_method_imp)
			else
				ccom_feature_writer.set_result_type(visitor.c_type)
			end

			if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
				c_header_files.force (visitor.c_header_file)
			end

			if not func_desc.arguments.empty then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					create visitor
					visitor.visit (func_desc.arguments.item.type)

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
				-- Remove the last comma
				if signature.item (signature.count).is_equal(',') then
					signature.remove (signature.count)
				end
			end

			ccom_feature_writer.set_signature(signature)

		ensure
			ccom_feature_writer_exist: ccom_feature_writer /= Void
			function_descriptor_exist: func_desc /= Void
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
