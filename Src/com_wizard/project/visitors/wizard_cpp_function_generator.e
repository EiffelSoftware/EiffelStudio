indexing
	description: "CPP function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_FUNCTION_GENERATOR

inherit
	WIZARD_FUNCTION_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR

feature -- Access

	ccom_feature_writer: WIZARD_WRITER_C_FUNCTION

	c_header_files: LINKED_LIST[STRING]

feature {NONE} -- Implementation

	set_vtable_function_return_type is
			-- Set return type of Vtable function.
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			a_result_type: STRING
		do
			if func_desc.return_type /= Void then
				visitor := func_desc.return_type.visitor
				if 
					visitor.vt_type = Vt_hresult
				then
					ccom_feature_writer.set_result_type (Std_method_imp)
				else
					create a_result_type.make (100)
					a_result_type.append (Std_method_imp)
					a_result_type.append (Underscore)
					a_result_type.append (Open_parenthesis)
					a_result_type.append (visitor.c_type)
					a_result_type.append (Close_parenthesis)
					ccom_feature_writer.set_result_type (a_result_type)
				end
			else
				create a_result_type.make (100)
				a_result_type.append (Std_method_imp)
				a_result_type.append (Underscore)
				a_result_type.append (Open_parenthesis)
				a_result_type.append (Void_c_keyword)
				a_result_type.append (Close_parenthesis)
				ccom_feature_writer.set_result_type (a_result_type)
			end
		end

	vtable_signature: STRING is
			-- Set server signature
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			if not func_desc.arguments.is_empty then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					visitor := func_desc.arguments.item.type.visitor

					Result.append (Beginning_comment_paramflag)

					if is_paramflag_fretval (func_desc.arguments.item.flags) then
						Result.append (Out_keyword)
						Result.append (Comma_space)
						Result.append (Retval)
					elseif is_paramflag_fout (func_desc.arguments.item.flags) then
						if is_paramflag_fin (func_desc.arguments.item.flags) then
							Result.append (Inout)
						else
							Result.append (Out_keyword)
						end
					else
						Result.append (In)
					end
					Result.append (End_comment_paramflag)

					Result.append (visitor.c_type)
					Result.append (Space)

					if visitor.is_array_basic_type or visitor.is_array_type then
						Result.append (Asterisk)
					end

					Result.append (func_desc.arguments.item.name)

					Result.append (Comma)
					add_header_file (func_desc.arguments.item.type)

					func_desc.arguments.forth
				end

				if Result.item (Result.count).is_equal (',') then
					Result.remove (Result.count)
				end
			else
				Result.append (Void_c_keyword)					
			end
		end

	add_header_file (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Add header file to list of header files if needed.
		do
		end

	add_ref_in_interface_pointer (a_name: STRING): STRING is
			-- Add reference to interface pointer before passing it.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (100)
			Result.append (a_name)
			Result.append (Add_reference_function)
		ensure
			non_void_add_ref: Result /= Void
			valid_add_ref: not Result.is_empty
		end

end -- class WIZARD_CPP_FUNCTION_GENERATOR
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
