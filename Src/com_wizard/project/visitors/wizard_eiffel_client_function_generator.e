indexing
	description: "Eiffel client function generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

create
	generate

feature -- Access

	external_feature_writer: WIZARD_WRITER_FEATURE

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate client feature
		local
			ccom_func_name: STRING
			c_type: STRING
		do
			func_desc := a_descriptor

			create feature_writer.make
			create external_feature_writer.make
			feature_writer.set_comment (func_desc.description)
			external_feature_writer.set_comment (func_desc.description)

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

			external_feature_writer.add_argument (default_pointer_argument)

			set_feature_result_type_and_arguments
			add_feature_argument_comments

			set_external_feature_result_type_and_arguments

			feature_writer.set_effective
			feature_writer.set_body (client_body (ccom_func_name))

			external_feature_writer.set_external

			create c_type.make (50)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				c_type.append (a_component_descriptor.namespace)
				c_type.append ("::")
			end
			c_type.append (a_component_descriptor.c_type_name)
			external_feature_writer.set_body (external_client_body (c_type, a_component_descriptor.c_header_file_name))
		end

feature {NONE} -- Implementation

	external_client_body (class_name, header_file_name: STRING): STRING is
			-- Coclass eiffel client external feature body
		require
			non_void_class_name: class_name /= Void
			valid_class_name: not class_name.is_empty
			non_void_header_file_name: header_file_name /= Void
			valid_header_file_name: not header_file_name.is_empty
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			return_type: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create return_type.make (100)
			
			create Result.make (10000)
			Result.append (Tab_tab_tab)
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
			if arguments /= Void and then not arguments.is_empty then
				from
					arguments.start
				until
					arguments.off
				loop
					visitor := arguments.item.type.visitor 

					if is_paramflag_fretval (arguments.item.flags) then
						return_type.append (Colon)
						return_type.append (Space)
						if visitor.is_basic_type then
							Result.append (visitor.cecil_type)
						elseif visitor.is_enumeration then
							Result.append (visitor.cecil_type)
						else
							pointed_descriptor ?= arguments.item.type
							if pointed_descriptor /= Void then
								visitor := pointed_descriptor.pointed_data_type_descriptor.visitor 
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
							Result.append (visitor.cecil_type)
						elseif visitor.is_enumeration then
							Result.append (visitor.cecil_type)
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

					else --if is_paramflag_fin (arguments.item.flags) then
						if visitor.is_basic_type then
							Result.append (visitor.cecil_type)

						elseif (visitor.vt_type = Vt_bool) then
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
							visitor.is_coclass_pointer
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

			visitor := func_desc.return_type.visitor 

			if not is_void (visitor.vt_type) and not is_hresult (visitor.vt_type) and
					not is_error (visitor.vt_type) then
				return_type.append (Colon)
				return_type.append (Space)

				pointed_descriptor ?= func_desc.return_type
				if pointed_descriptor /= Void then
					visitor := pointed_descriptor.pointed_data_type_descriptor.visitor 
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
			valid_body: not Result.is_empty
		end

	set_external_feature_result_type_and_arguments is
			-- Set arguments for external feature
		local
 			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			tmp_string: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			arguments := func_desc.arguments
			from
				arguments.start
			until
				arguments.off
			loop
				visitor := arguments.item.type.visitor 

				if is_paramflag_fretval (arguments.item.flags) then
					pointed_descriptor ?= arguments.item.type
					if pointed_descriptor /= Void then
						visitor := pointed_descriptor.pointed_data_type_descriptor.visitor 
					end
					external_feature_writer.set_result_type (visitor.eiffel_type)
				else
					create tmp_string.make (100)
					tmp_string.append (arguments.item.name)
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

			visitor := func_desc.return_type.visitor 

			if 
				not is_hresult (visitor.vt_type) and
				not is_error (visitor.vt_type) and
				not is_void (visitor.vt_type)
			then
				external_feature_writer.set_result_type (visitor.eiffel_type)
			end
		end

	client_body (func_name: STRING): STRING is
			-- Coclass client body
		require
			non_void_name: func_name /= Void
			valid_name: not func_name.is_empty
		local
 			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			tmp_string, local_variable: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
			is_interface_pointer: BOOLEAN
		do
			create Result.make (10000)			
			Result.append (Tab_tab_tab)

			arguments := func_desc.arguments

			create tmp_string.make (1000)
			tmp_string.append (func_name)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Initializer_variable)

			if arguments /= Void and then not arguments.is_empty then
				from
					arguments.start
				until
					arguments.off
				loop
					if is_paramflag_fretval (arguments.item.flags) then
						tmp_string.prepend (Result_clause)
					else
						tmp_string.append (Comma_space)
						visitor := arguments.item.type.visitor 

						if visitor.is_array_basic_type then
							create local_variable.make (100)
							local_variable.append (Tmp_clause)
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
							visitor.is_coclass_pointer
						then
							feature_writer.add_local_variable 
								(argument_item_name (arguments.item.name) +
								": POINTER")

							Result.append (check_interface_item (arguments.item.name))
							if not is_interface_pointer then
								feature_writer.add_local_variable ("a_stub: ECOM_STUB")
								is_interface_pointer := True
							end
							tmp_string.append (argument_item_name (arguments.item.name))
						elseif
							visitor.is_structure_pointer or
							visitor.is_structure 
						then
							tmp_string.append (arguments.item.name)
							tmp_string.append (Item_function)
						elseif
							is_paramflag_fin (arguments.item.flags) and
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

			visitor := func_desc.return_type.visitor 

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
			valid_body: not Result.is_empty
		end

	check_interface_item (an_argument_name: STRING): STRING is
			-- Check item of interface with `an_argument_name'.
		require
			non_void_name: an_argument_name /= Void
			valid_name: not an_argument_name.is_empty
		do
			create Result.make (200)
			Result.append ("if " + an_argument_name + " /= Void then")
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)
			
			Result.append ("if (")
			Result.append (an_argument_name)
			Result.append (".item = default_pointer) then")
			Result.append (New_line_tab_tab_tab)
			Result.append (tab_tab)

			Result.append ("a_stub ?= ")
			Result.append (an_argument_name)
			Result.append (New_line_tab_tab_tab)
			Result.append (tab_tab)

			Result.append ("if a_stub /= Void then")
			Result.append (New_line_tab_tab_tab)
			Result.append (tab_tab_tab)

			Result.append ("a_stub.create_item")
			Result.append (New_line_tab_tab_tab)
			Result.append (tab_tab)

			Result.append (End_keyword)
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)

			Result.append (End_keyword)
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)
			
			Result.append (argument_item_name (an_argument_name) +
							" := " + an_argument_name + ".item")
			Result.append (New_line_tab_tab_tab)
			Result.append (End_keyword)
			Result.append (New_line_tab_tab_tab)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	argument_item_name (an_argument_name: STRING): STRING is
			-- Argument item name.
		require
			non_void_name: an_argument_name /= Void
			valid_name: not an_argument_name.is_empty
		do
			create Result.make (100)
			Result.append (an_argument_name)
			Result.append ("_item")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
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
