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

	set_result_type_and_signature: STRING is
			-- Result type and signature of feature
		require
			non_void_feature_writer: ccom_feature_writer /= Void
			non_void_arguments: func_desc.arguments /= Void
			has_arguments: not func_desc.arguments.empty
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (0)
			arguments := func_desc.arguments
			from
				arguments.start
			until
				arguments.off
			loop
				create visitor
				visitor.visit (arguments.item.type)

				if is_paramflag_fretval (arguments.item.flags) then
					if visitor.is_basic_type then
						message_output.add_warning (Current, message_output.Not_pointer_type)
					else
						pointed_descriptor ?= arguments.item.type
						if pointed_descriptor /= Void then
							create visitor
							visitor.visit (pointed_descriptor.pointed_data_type_descriptor)
							if visitor.is_basic_type or visitor.is_enumeration then
								ccom_feature_writer.set_result_type (visitor.cecil_type)
							else
								ccom_feature_writer.set_result_type (Eif_reference)
							end
						else
							ccom_feature_writer.set_result_type (Eif_reference)
						end
					end

				elseif is_paramflag_fout (arguments.item.flags) then
					Result.append (Beginning_comment_paramflag)
					if is_paramflag_fin (arguments.item.flags) then
						Result.append ("in, ")
					end
					Result.append ("out")
					Result.append (End_comment_paramflag)
					if visitor.is_basic_type then
						message_output.add_warning (Current, message_output.Not_pointer_type)
					elseif 
						visitor.is_array_basic_type or 
						visitor.is_interface_pointer or 
						visitor.is_coclass_pointer or 
						visitor.is_structure_pointer 
					then
						Result.append (visitor.c_type)
						Result.append (Space)
						Result.append (arguments.item.name)
						Result.append (visitor.c_post_type)
					elseif visitor.is_interface or visitor.is_structure then
						Result.append (Eif_pointer)
						Result.append (Space)
						Result.append (arguments.item.name)

					else
						Result.append (Eif_object)
						Result.append (Space)
						Result.append (arguments.item.name)
					end
					if not (visitor.c_header_file = Void or else visitor.c_header_file.empty) then
						c_header_files.extend (visitor.c_header_file)
					end
					Result.append (Comma_space)

				else
					Result.append (Beginning_comment_paramflag)
					Result.append ("in")
					Result.append (End_comment_paramflag)
					if visitor.is_basic_type or visitor.is_enumeration then
						Result.append (visitor.cecil_type)
					elseif 
						visitor.is_array_basic_type or 
						visitor.is_interface_pointer or 
						visitor.is_coclass_pointer or 
						visitor.is_structure_pointer 
					then
						Result.append (visitor.c_type)

					elseif visitor.is_interface or visitor.is_structure then
						Result.append (visitor.c_type)
						Result.append (Space)
						Result.append (Asterisk)

					else
						Result.append (Eif_object)
					end

					Result.append (Space)
					Result.append (arguments.item.name)

					if visitor.is_array_basic_type then
						Result.append (visitor.c_post_type)
					end

					if not (visitor.c_header_file = Void or else visitor.c_header_file.empty) then
						c_header_files.extend (visitor.c_header_file)
					end

					Result.append (Comma_space)

				end
				visitor := Void
				arguments.forth
			end

			if Result.count > 0  then
				Result.remove (Result.count)
				Result.remove (Result.count)
			end
		ensure
			valid_result: Result /= Void and then not Result.empty
		end

	set_client_result_type_and_signature is
			-- Set ccom client feature signature
		do
			if func_desc.arguments /= Void and not func_desc.arguments.empty then
				ccom_feature_writer.set_signature (set_result_type_and_signature)
			end
		end

	cecil_feature_set_up (arg_name, cecil_feature_type, feature_name, object_type: STRING): STRING is
			-- Code to set up cecil access to Eiffel object
		require
			Non_void_string: arg_name /= Void
			Non_void_string: cecil_feature_type /= Void
			Non_void_string: feature_name /= Void
			Non_void_string: object_type /= Void
		local
			cecil_feature_name: STRING
		do
			cecil_feature_name := clone (cecil_feature_type)
			cecil_feature_name.to_lower

			-- EIF_TYPE_ID 'arg_name'_tid;
			-- 'cecil_feature_type' 'feature_name'_feature;
			Result := clone (Eif_type_id)
			Result.append (Space)
			Result.append (arg_name)
			Result.append (Append_tid_clause)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			Result.append (cecil_feature_type)
			Result.append (Space)
			Result.append (feature_name)
			Result.append (Feature_clause)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- 'arg_name'_tid = eif_type_id ("'object_type'");
			-- 'feature_name'_feature = 'cecil_feature_name' ('feature_name', 'arg_name'_tid);
			Result.append (arg_name)
			Result.append (Append_tid_clause)
			Result.append (Space_equal_space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append (object_type)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			Result.append (feature_name)
			Result.append (Feature_clause)
			Result.append (Space_equal_space)
			Result.append (cecil_feature_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append (feature_name)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (arg_name)
			Result.append (Append_tid_clause)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
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
