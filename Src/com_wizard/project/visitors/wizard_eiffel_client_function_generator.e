indexing
	description: ""
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Access

	external_feature_writer: WIZARD_WRITER_FEATURE

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate client feature
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_component: a_component_descriptor /= Void
		local
			ccom_func_name: STRING
		do
			func_desc := a_descriptor

			create feature_writer.make
			create external_feature_writer.make
			feature_writer.set_comment (func_desc.description)
			external_feature_writer.set_comment (func_desc.description)

			-- Set function name used in ccom
			if a_descriptor.coclass_eiffel_names.has (a_component_descriptor.name) then
				function_renamed := True
				original_name := a_descriptor.interface_eiffel_name
				changed_name := a_descriptor.coclass_eiffel_names.item (a_component_descriptor.name)
				ccom_func_name := external_feature_name (changed_name)

				feature_writer.set_name (changed_name)
			else
				ccom_func_name := external_feature_name (a_descriptor.interface_eiffel_name)
				feature_writer.set_name (a_descriptor.interface_eiffel_name)
			end
			external_feature_writer.set_name (ccom_func_name)

			-- Set arguments and precondition for eiffel code

			external_feature_writer.add_argument (default_pointer_argument)

			set_feature_result_type_and_arguments

			-- Argument for external feature
			set_external_feature_result_type_and_arguments

			-- Set description, function body
			feature_writer.set_effective
			feature_writer.set_body (client_body (ccom_func_name))

			external_feature_writer.set_external
			external_feature_writer.set_body (external_client_body (a_component_descriptor.c_type_name, a_component_descriptor.c_header_file_name))
		ensure
			non_void_feature_writer: feature_writer /= Void
			non_void_external_feature_writer: external_feature_writer /= Void
		end

feature {NONE} -- Implementation

	external_client_body (class_name, header_file_name: STRING): STRING is
			-- Coclass eiffel client external feature body
		require
			non_void_class_name: class_name /= Void
			valid_class_name: not class_name.empty
			non_void_header_file_name: header_file_name /= Void
			valid_header_file_name: not header_file_name.empty
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			return_type: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create return_type.make (0)
			
			Result := clone(Tab_tab_tab)
			Result.append (Double_quote)
			Result.append (Cpp_clause)
			Result.append (class_name)
			Result.append (Space)
			Result.append (Percent_double_quote)
			Result.append (header_file_name)
			Result.append (Percent_double_quote)			
			Result.append (Close_bracket)
			Result.append (Open_parenthesis)

			arguments := func_desc.arguments
			if arguments /= Void and then not arguments.empty then
				from
					arguments.start
				until
					arguments.off
				loop
					create visitor
					visitor.visit (arguments.item.type)

					if is_paramflag_fretval (arguments.item.flags) then
						return_type.append (Colon)
						return_type.append (Space)
						if visitor.is_basic_type then
							message_output.add_warning (Current, message_output.Not_pointer_type)
						elseif visitor.is_enumeration then
							message_output.add_warning (Current, message_output.Invalid_use_of_enumeration)
						else
							pointed_descriptor ?= arguments.item.type
							if pointed_descriptor /= Void then
								create visitor
								visitor.visit (pointed_descriptor.pointed_data_type_descriptor)
								if visitor.is_basic_type then
									return_type.append (visitor.cecil_type)
								else
									return_type.append (Eif_reference)
								end
							else
								return_type.append (Eif_reference)
							end
						end		
					elseif is_paramflag_fout (arguments.item.flags) then
						if visitor.is_basic_type then
							message_output.add_warning (Current, message_output.Not_pointer_type)
						elseif visitor.is_enumeration then
							message_output.add_warning (Current, message_output.Invalid_use_of_enumeration)
						elseif visitor.is_structure or visitor.is_interface or visitor.is_array_basic_type then
							Result.append (visitor.c_type)
							Result.append (Space)
							Result.append (Asterisk)

						elseif 
							visitor.is_structure_pointer or 
							visitor.is_interface_pointer or
							visitor.is_coclass_pointer
						then
							Result.append (visitor.c_type)
						else
							Result.append (Eif_object)
						end
						Result.append (Comma)

					elseif is_paramflag_fin (arguments.item.flags) then
						if visitor.is_basic_type then
							Result.append (visitor.cecil_type)

						elseif is_boolean (visitor.vt_type) then
							Result.append (Eif_boolean)

						elseif visitor.is_enumeration then
							Result.append (Eif_integer)

						elseif visitor.is_structure or visitor.is_interface or 
								visitor.is_array_basic_type then
							Result.append (visitor.c_type)
							Result.append (Space)
							Result.append (Asterisk)

						elseif 
							visitor.is_structure_pointer or 
							visitor.is_interface_pointer or
							visitor.is_coclass_pointer or
							visitor.is_basic_type_ref 
						then
							Result.append (visitor.c_type)

						elseif visitor.is_enumeration then
							Result.append (Eif_integer)
						elseif is_hresult (visitor.vt_type) or is_error (visitor.vt_type) then
							Result.append (visitor.c_type)
						else
							Result.append (Eif_object)
						end
						Result.append (Comma)
					end
					visitor := Void
					arguments.forth
				end
				if Result.item (Result.count).is_equal (',') then
					Result.remove (Result.count)
				end
			end

			create visitor
			visitor.visit (func_desc.return_type)

			if not is_void (visitor.vt_type) and not is_hresult (visitor.vt_type) and
					not is_error (visitor.vt_type) then
				return_type.append (Colon)
				return_type.append (Space)

				pointed_descriptor ?= func_desc.return_type
				if pointed_descriptor /= Void then
					create visitor
					visitor.visit (pointed_descriptor.pointed_data_type_descriptor)
					if visitor.is_basic_type then
						return_type.append (visitor.cecil_type)
					else
						return_type.append (Eif_reference)
					end
				else
					return_type.append (Eif_reference)
				end
			end
			Result.append (Close_parenthesis)
			Result.append (return_type)
			Result.append (Double_quote)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	set_external_feature_result_type_and_arguments is
			-- Set arguments for external feature
		local
 			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			tmp_string: STRING
			data_type: INTEGER
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			arguments := func_desc.arguments
			from
				arguments.start
			until
				arguments.off
			loop
				create visitor
				visitor.visit (arguments.item.type)

				if is_paramflag_fretval (arguments.item.flags) then
					pointed_descriptor ?= arguments.item.type
					if pointed_descriptor /= Void then
						create visitor
						visitor.visit (pointed_descriptor.pointed_data_type_descriptor)
					end
					external_feature_writer.set_result_type (visitor.eiffel_type)
				else
					tmp_string := clone (arguments.item.name)
					tmp_string.append (Colon)
					tmp_string.append (Space)

					if 
						visitor.is_interface or 
						visitor.is_structure or 
						visitor.is_structure_pointer or 
						visitor.is_coclass or 
						visitor.is_coclass_pointer or 
						visitor.is_array_basic_type or 
						visitor.is_interface_pointer 
					then
						tmp_string.append (Pointer_type)
					elseif visitor.is_enumeration then
						tmp_string.append (Integer_type)
					elseif is_paramflag_fin (arguments.item.flags) and
							not is_paramflag_fout (arguments.item.flags) and
							(is_hresult (visitor.vt_type) or is_error (visitor.vt_type))
					then
						tmp_string.append (Integer_type)
					else
						tmp_string.append (visitor.eiffel_type)
					end

					external_feature_writer.add_argument (tmp_string)
				end
				visitor := Void
				arguments.forth
			end

			create visitor
			visitor.visit (func_desc.return_type)

			if 
				not is_hresult (visitor.vt_type) and
				not is_error (visitor.vt_type) and
				not is_void (visitor.vt_type)
			then
				pointed_descriptor ?= func_desc.return_type
				if pointed_descriptor /= Void then
					create visitor
					visitor.visit (pointed_descriptor.pointed_data_type_descriptor)
				end
				external_feature_writer.set_result_type (visitor.eiffel_type)
			end
		end

	client_body (func_name: STRING): STRING is
			-- Coclass client body
		require
			non_void_name: func_name /= Void
			valid_name: not func_name.empty
		local
			data_type: INTEGER
 			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			tmp_string, local_variable: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			
			Result := clone (Tab_tab_tab)

			arguments := func_desc.arguments

			tmp_string := clone (func_name)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Initializer_variable)

			if arguments /= Void and then not arguments.empty then
				from
					arguments.start
				until
					arguments.off
				loop
					if is_paramflag_fretval (arguments.item.flags) then
						tmp_string.prepend (Result_clause)
					else
						tmp_string.append (Comma_space)
						create visitor
						visitor.visit (arguments.item.type)

						if visitor.is_array_basic_type then
							local_variable := clone (Tmp_clause)
							local_variable.append (arguments.item.name)
							local_variable.append (Colon)
							local_variable.append (Space)
							local_variable.append (Any_type)

							feature_writer.add_local_variable (local_variable)

							Result.append (New_line_tab_tab_tab)
							Result.append (Tmp_clause)
							Result.append (arguments.item.name)
							Result.append (Space)
							Result.append (Assignment)
							Result.append (Space)
							Result.append (arguments.item.name)
							Result.append (Dot)
							Result.append (To_c_function)
							Result.append (New_line_tab_tab_tab)

							tmp_string.append (Dollar)
							tmp_string.append (Tmp_clause)
							tmp_string.append (arguments.item.name)
						elseif 
							visitor.is_interface or 
							visitor.is_interface_pointer or 
							visitor.is_coclass or 
							visitor.is_coclass_pointer or 
							visitor.is_structure_pointer or
							visitor.is_structure 
						then
							tmp_string.append (arguments.item.name)
							tmp_string.append (Item_function)
						elseif is_paramflag_fin (arguments.item.flags) and
								not is_paramflag_fout (arguments.item.flags) and
								(is_hresult (visitor.vt_type) or is_error (visitor.vt_type))
						then
							tmp_string.append (arguments.item.name)
							tmp_string.append (Item_function)
						else
							tmp_string.append (arguments.item.name)
						end
						visitor := Void
					end
					arguments.forth
				end
			end
			tmp_string.append (Close_parenthesis)

			create visitor
			visitor.visit (func_desc.return_type)

			if 
				not is_hresult (visitor.vt_type) and
				not is_void (visitor.vt_type) and
				not is_error (visitor.vt_type)
			then
				tmp_string.prepend (Result_clause)
			end

			Result.append (tmp_string)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

end -- class WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR
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
