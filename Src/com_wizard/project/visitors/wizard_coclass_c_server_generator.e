indexing
	description: "Coclass c server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_C_SERVER_GENERATOR
	
inherit
	WIZARD_COCLASS_C_GENERATOR

	WIZARD_COMPONENT_C_SERVER_GENERATOR

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c server for coclass.
		local
			member_writer: WIZARD_WRITER_C_MEMBER
			a_class_object: WIZARD_CLASS_OBJECT_GENERATOR
			a_registration_code_gen: WIZARD_REGISTRATION_CODE_GENERATOR
			tmp_string: STRING
		do
			create cpp_class_writer.make
			create interface_names.make

			-- Initialization
			dispatch_interface := False

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)

			-- Import header file
			cpp_class_writer.add_import (Ecom_server_rt_globals_h)

			if shared_wizard_environment.out_of_process_server then
				tmp_string := clone (a_descriptor.c_type_name)
				tmp_string.append (Underscore)
				tmp_string.append (Factory)
				tmp_string.append (Header_file_extension)
				cpp_class_writer.add_import (tmp_string)
			end

			-- Add clsid of the coclass
			-- const CLSID CLSID_'coclass_name'
			cpp_class_writer.add_other (clsid_declaration (a_descriptor.c_type_name))
			cpp_class_writer.add_other_source (clsid_definition (a_descriptor.c_type_name, a_descriptor.guid))

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

			-- Process functions
			process_interfaces	(a_descriptor)			

			if dispatch_interface then
				-- Add type library id
				cpp_class_writer.add_other (libid_declaration (a_descriptor.type_library_descriptor.name))
				cpp_class_writer.add_other_source (libid_definition (a_descriptor.type_library_descriptor.name, a_descriptor.type_library_descriptor.guid))


				-- member (ITypeInfo * pTypeInfo)
				create member_writer.make
				member_writer.set_name (Type_info_variable_name)
				member_writer.set_result_type (Type_info)
				member_writer.set_comment ("Type information")
				cpp_class_writer.add_member (member_writer, Private)

				add_get_type_info_function (a_descriptor)
				add_get_type_info_count_function (a_descriptor)
				add_get_ids_of_names_function (a_descriptor)
				-- add_invoke_function (a_descriptor)
				dispatch_invoke_function (a_descriptor)
			end

			-- constructor
			add_constructor

			-- destructor
			add_destructor

			-- Implement IUnknown interface
			add_release_function
			add_addref_function
			add_query_interface

			check
				valid_cpp_class_writer: cpp_class_writer.can_generate
			end

			-- Generate code and save name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)

			-- Generate code for class object factory.
			create a_class_object
			a_class_object.initialize
			a_class_object.generate (a_descriptor)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_c_server
		end

feature {NONE} -- Implementation

	process_interfaces (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process inherited interfaces
		require
			non_void_cpp_class_writer: cpp_class_writer /= Void
			non_void_component_descriptor: a_coclass_descriptor /= Void
			non_void_interface_descriptors: a_coclass_descriptor.interface_descriptors /= Void
		local
			a_name, tmp_string: STRING
			interface_descriptors: LIST[WIZARD_INTERFACE_DESCRIPTOR]
			coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
		do
			interface_descriptors := a_coclass_descriptor.interface_descriptors

			-- Find all the features and properties in inherited interfaces
			if not interface_descriptors.empty then
				from
					interface_descriptors.start
				until
					interface_descriptors.off
				loop
					-- Add parent and import header files
					cpp_class_writer.add_parent (interface_descriptors.item.c_type_name, Public)
					cpp_class_writer.add_import (interface_descriptors.item.c_header_file_name)
					cpp_class_writer.add_other_source (iid_definition (interface_descriptors.item.name, interface_descriptors.item.guid))

					-- Find all features and properties
					a_name := interface_descriptors.item.c_type_name
					interface_names.extend (a_name)

					if interface_descriptors.item.dispinterface or interface_descriptors.item.dual then
						if dispatch_interface_name = Void then
							dispatch_interface_name := clone (interface_descriptors.item.c_type_name)
						end
						dispatch_interface := True
					end

					generate_functions_and_properties (a_coclass_descriptor, interface_descriptors.item)

					interface_descriptors.forth
				end
			end
		end

	add_destructor is
		local
			tmp_body: STRING
		do
			tmp_body := clone (Tab)
			tmp_body.append (Eif_wean)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Eiffel_object)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			if dispatch_interface then
				tmp_body.append (New_line_tab)
				tmp_body.append (If_keyword)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Type_info_variable_name)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (New_line_tab_tab)
				tmp_body.append (Type_info_variable_name)
				tmp_body.append (Release_function)
			end

			if shared_wizard_environment.out_of_process_server then
				tmp_body.append (New_line_tab)
				tmp_body.append ("UnlockModule ();")
			end
			cpp_class_writer.set_destructor (tmp_body)
		end

	add_constructor is
		local
			constructor_writer: WIZARD_WRITER_CPP_CONSTRUCTOR
			tmp_string: STRING
		do
			create constructor_writer.make

			tmp_string := clone (Eif_type_id)
			tmp_string.append (Space)
			tmp_string.append (Type_id_variable_name)

			constructor_writer.set_signature (tmp_string)

			tmp_string := clone (Tab)
			tmp_string.append (Type_id)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Type_id_variable_name)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)
			tmp_string.append (Eiffel_object)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Eif_create)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Type_id)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			if dispatch_interface then
				tmp_string.append (New_line_tab)
				tmp_string.append (Type_info_variable_name)
				tmp_string.append (Space_equal_space)
				tmp_string.append (Zero)
				tmp_string.append (Semicolon)
			end

			if shared_wizard_environment.out_of_process_server then
				tmp_string.append (New_line_tab)
				tmp_string.append ("LockModule ();")
			end

			constructor_writer.set_body (tmp_string)
		
			check
				valid_constructor_writer: constructor_writer.can_generate
			end

			cpp_class_writer.add_constructor (constructor_writer)

			check
				writer_added: cpp_class_writer.constructors.has (constructor_writer)
			end
		end

	add_get_type_info_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add GetTypeInfo function.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info (a_coclass_descriptor)
			tmp_body.append (Assert)
			tmp_body.append (Open_parenthesis)
			tmp_body.append ("itinfo == 0 && pptinfo != 0")
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Open_parenthesis)
			tmp_body.append ("*pptinfo")
			tmp_body.append (Space_equal_space)
			tmp_body.append (Type_info_variable_name)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Add_reference_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return_s_ok)

			func_writer.set_name (Get_type_info)
			func_writer.set_comment ("Get type info")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo")
			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end
		
	add_get_type_info_count_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add GetTypeInfoCount function.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := clone (Tab)
			tmp_body.append (Assert)
			tmp_body.append (Open_parenthesis)
			tmp_body.append ("pctinfo != 0")
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append ("*pctinfo")
			tmp_body.append (Space_equal_space)
			tmp_body.append (One)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return_s_ok)

			func_writer.set_name (Get_type_info_count)
			func_writer.set_comment ("Get type info count")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("unsigned int * pctinfo")
			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end

	add_get_ids_of_names_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add GetIDsOfNames function
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info (a_coclass_descriptor)
			tmp_body.append (Assert)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (C_equal)
			tmp_body.append (Iid_type)
			tmp_body.append (Underscore)
			tmp_body.append (Null)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Type_info_variable_name)
			tmp_body.append (Struct_selection_operator)
			tmp_body.append (Get_ids_of_names)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append ("rgszNames, cNames, rgdispid")
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			func_writer.set_name (Get_ids_of_names)
			func_writer.set_comment ("IDs of function names 'rgszNames'")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid")
			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end

	dispatch_invoke_function (cocls_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add Invoke function for pure dispatch interface
		require
			non_void_coclass_descriptor: cocls_descriptor /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			body_code: STRING
		do
			create func_writer.make

			func_writer.set_name (Invoke)
			func_writer.set_comment ("Invoke function.")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr")

			body_code := check_type_info (cocls_descriptor)
			body_code.append (Hresult)
			body_code.append (Space)
			body_code.append (Hresult_variable_name)
			body_code.append (Space_equal_space)
			body_code.append (Zero)
			body_code.append (Semicolon)
			body_code.append (New_line_tab)
			body_code.append (Int)
			body_code.append (Space)
			body_code.append ("i")
			body_code.append (Space_equal_space)
			body_code.append (Zero)
			body_code.append (Semicolon)
			body_code.append (New_line)
			body_code.append (New_line_tab)
			body_code.append (Assert)
			body_code.append (Open_parenthesis)
			body_code.append (Riid)
			body_code.append (C_equal)
			body_code.append (Iid_type)
			body_code.append (Underscore)
			body_code.append (Null)
			body_code.append (Close_parenthesis)
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			body_code.append ("VARIANTARG * lcl_rgvarg")
			body_code.append (Space_equal_space)
			body_code.append (Dispparam_parameter)
			body_code.append (Struct_selection_operator)
			body_code.append ("rgvarg")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			body_code.append ("VARIANTARG * ")
			body_code.append (Tmp_variable_name)
			body_code.append (Space_equal_space)
			body_code.append (Zero)
			body_code.append (Semicolon)
			body_code.append (New_line)
			body_code.append (New_line_tab)

			body_code.append (Switch)
			body_code.append (Space_open_parenthesis)
			body_code.append ("dispID")
			body_code.append (Close_parenthesis)
			body_code.append (New_line_tab)
			body_code.append (Open_curly_brace)
			body_code.append (New_line_tab_tab)

			from
				cocls_descriptor.interface_descriptors.start
			until
				cocls_descriptor.interface_descriptors.after
			loop
				if cocls_descriptor.interface_descriptors.item.dispinterface then
					body_code.append (invoke_function_case_item (cocls_descriptor.interface_descriptors.item))
				end
				cocls_descriptor.interface_descriptors.forth
			end
			body_code.append (New_line_tab_tab)
			body_code.append ("default:")
			body_code.append (New_line_tab_tab_tab)
			body_code.append (Return)
			body_code.append (Space)
			body_code.append ("DISP_E_MEMBERNOTFOUND")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)
			body_code.append (Close_curly_brace)

			body_code.append (New_line)
			body_code.append (New_line_tab)
			body_code.append (If_keyword)
			body_code.append (Space_open_parenthesis)
			body_code.append (Dispparam_parameter)
			body_code.append (Struct_selection_operator)
			body_code.append ("cArgs")
			body_code.append (Space)
			body_code.append (C_not_equal)
			body_code.append (Space)
			body_code.append (Zero)
			body_code.append (Close_parenthesis)
			body_code.append (New_line_tab_tab)			

			body_code.append (Co_task_mem_free)
			body_code.append (Space_open_parenthesis)
			body_code.append (Tmp_variable_name)
			body_code.append (Close_parenthesis)
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			func_writer.set_body (body_code)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end

	invoke_function_case_item (interface_desc: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Case statement for functions in interface
		require
			non_void_descriptor: interface_desc /= Void
		local
			prop_get_functions: HASH_TABLE[STRING, INTEGER]
			prop_put_functions: HASH_TABLE[STRING, INTEGER]
		do
			create prop_get_functions.make (2)
			create prop_put_functions.make (2)
			create Result.make (0)			

			from
				interface_desc.functions.start
			until
				interface_desc.functions.after
			loop
				if is_propertyget (interface_desc.functions.item.invoke_kind) then
					prop_get_functions.extend (propertyget_case (interface_desc.functions.item), interface_desc.functions.item.member_id)
				elseif is_propertyput (interface_desc.functions.item.invoke_kind) then
					prop_put_functions.extend (propertyput_case (interface_desc.functions.item), interface_desc.functions.item.member_id)
				elseif is_propertyputref (interface_desc.functions.item.invoke_kind) then
				else
					Result.append (function_case (interface_desc.functions.item))
				end

				interface_desc.functions.forth
			end

			if not interface_desc.properties.empty then
				from
					interface_desc.properties.start
				until
					interface_desc.properties.after
				loop
					Result.append (properties_case (interface_desc.properties.item, prop_get_functions, prop_put_functions))
					interface_desc.properties.forth
				end
			end

			if not prop_get_functions.empty then
				from
					prop_get_functions.start
				until
					prop_get_functions.off
				loop
					Result.append (New_line_tab_tab)
					Result.append (Case)
					Result.append (Space)
					Result.append_integer (prop_get_functions.key_for_iteration)
					Result.append (Colon)
					Result.append (New_line_tab_tab_tab)

					Result.append (prop_get_functions.item_for_iteration)

					if prop_put_functions.has (prop_get_functions.key_for_iteration) then
						Result.append (prop_put_functions.item (prop_get_functions.key_for_iteration))
						prop_put_functions.remove (prop_get_functions.key_for_iteration)
					end

					Result.append (New_line)
					Result.append (New_line_tab_tab_tab)
					Result.append (Break)
					Result.append (Semicolon)
					prop_get_functions.forth
				end
			end

			if not prop_put_functions.empty then
				from
					prop_put_functions.start
				until
					prop_put_functions.off
				loop
					Result.append (New_line_tab_tab)
					Result.append (Case)
					Result.append (Space)
					Result.append_integer (prop_put_functions.key_for_iteration)
					Result.append (Colon)
					Result.append (New_line_tab_tab_tab)

					Result.append (prop_put_functions.item_for_iteration)
					Result.append (New_line_tab_tab_tab)
					Result.append (Break)
					Result.append (Semicolon)

					prop_put_functions.forth
				end
			end

			if not interface_desc.inherited_interface.name.is_equal (IDispatch_type) then
				Result.append (invoke_function_case_item (interface_desc.inherited_interface))
			end
		end

	properties_case (prop_desc: WIZARD_PROPERTY_DESCRIPTOR; prop_get_func, prop_put_func: HASH_TABLE[STRING, INTEGER]): STRING is
			-- Case for properties
		require
			non_void_property_descriptor: prop_desc /= Void
			non_void_property_get_functions: prop_get_func /= Void
			non_void_property_put_functions: prop_put_func /= Void
		local
			local_buffer: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			local_buffer := clone (prop_desc.name)
			local_buffer.to_lower

			Result := clone (New_line_tab_tab)
			Result.append (Case)
			Result.append (Space)
			Result.append_integer (prop_desc.member_id)
			Result.append (Colon)
			Result.append (New_line_tab_tab_tab)

			if prop_get_func.has (prop_desc.member_id) then
				Result.append (prop_get_func.item (prop_desc.member_id))
				prop_get_func.remove (prop_desc.member_id)
			else
				Result := clone (Tab_tab)
				Result.append (If_keyword)
				Result.append (Space_open_parenthesis)
				Result.append ("wFlags")
				Result.append (C_equal)
				Result.append ("INVOKE_PROPERTYGET")
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab)
				Result.append (Open_curly_brace)
				Result.append (New_line_tab_tab_tab)

				create visitor
				visitor.visit (prop_desc.data_type)

				Result.append ("pVarResult")
				Result.append (Struct_selection_operator)
				Result.append ("vt")
				Result.append (Space_equal_space)
				Result.append_integer (visitor.vt_type)
				Result.append (Semicolon)

				Result.append (New_line_tab_tab)
				Result.append (Get_clause)

				Result.append (local_buffer)
				Result.append (Space_open_parenthesis)
				Result.append (Ampersand)
				Result.append ("pVarResult")
				Result.append (Struct_selection_operator)
				Result.append (vartype_namer.variant_field_name (visitor))
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)
				Result.append (Close_curly_brace)
			end

			if not is_varflag_freadonly (prop_desc.var_flags) then
				if prop_put_func.has (prop_desc.member_id) then
					Result.append (prop_put_func.item (prop_desc.member_id))
					prop_put_func.remove (prop_desc.member_id)
				else
					Result := clone (Tab_tab)
					Result.append (If_keyword)
					Result.append (Space_open_parenthesis)
					Result.append ("wFlags")
					Result.append (C_equal)
					Result.append ("INVOKE_PROPERTYPUT")
					Result.append (Close_parenthesis)
					Result.append (New_line_tab_tab)
					Result.append (Open_curly_brace)
					Result.append (New_line_tab_tab_tab)

					create visitor
					visitor.visit (prop_desc.data_type)
	
					Result.append (New_line_tab_tab)

					Result.append (Set_clause)
					Result.append (local_buffer)
					Result.append (Space_open_parenthesis)
					Result.append (Variant_parameter)
					Result.append (Struct_selection_operator)
					Result.append (vartype_namer.variant_field_name (visitor))
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab_tab)
					Result.append (Close_curly_brace)
				end
			end
			
		end

	propertyput_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Function code for propertyput
		require
			non_void_descriptor: func_desc /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			Result := clone (Tab_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append ("wFlags")
			Result.append (C_equal)
			Result.append ("INVOKE_PROPERTYPUT")
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab_tab)

			create visitor
			visitor.visit (func_desc.arguments.first.type)

			Result.append (New_line_tab_tab)
			Result.append (func_desc.name)
			Result.append (Space_open_parenthesis)
			Result.append (Variant_parameter)
			Result.append (Struct_selection_operator)
			Result.append (vartype_namer.variant_field_name (visitor))
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			Result.append (Close_curly_brace)
		end

	propertyget_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			Result := clone (Tab_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append ("wFlags")
			Result.append (C_equal)
			Result.append ("INVOKE_PROPERTYGET")
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab_tab)

			create visitor
			visitor.visit (func_desc.return_type)

			Result.append ("pVarResult")
			Result.append (Struct_selection_operator)
			Result.append ("vt")
			Result.append (Space_equal_space)
			Result.append_integer (visitor.vt_type)
			Result.append (Semicolon)

			Result.append (New_line_tab_tab)
			Result.append (func_desc.name)
			Result.append (Space_open_parenthesis)
			Result.append (Ampersand)
			Result.append ("pVarResult")
			Result.append (Struct_selection_operator)
			Result.append (vartype_namer.variant_field_name (visitor))
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			Result.append (Close_curly_brace)
			
		end

	function_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			counter: INTEGER
			local_buffer: STRING
		do
			create local_buffer.make (0)

			Result := clone (New_line_tab_tab)
			Result.append (Case)
			Result.append (Space)
			Result.append_integer (func_desc.member_id)
			Result.append (Colon)
			Result.append (New_line_tab_tab_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Dispparam_parameter)
			Result.append (Struct_selection_operator)
			Result.append ("cArgs")
			Result.append (Space)
			Result.append (C_not_equal)
			Result.append (Space)
			Result.append_integer (func_desc.argument_count)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			Result.append (Return)
			Result.append (Space)
			Result.append ("DISP_E_BADPARAMCOUNT")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab_tab_tab)

			if func_desc.argument_count > 0 then
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (Variantarg)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append (Co_task_mem_alloc)
				Result.append (Space_open_parenthesis)
				Result.append_integer (func_desc.argument_count)
				Result.append (Asterisk)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append (Variantarg)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (New_line_tab_tab_tab)

				Result.append (If_keyword)
				Result.append (Space_open_parenthesis)
				Result.append (Dispparam_parameter)
				Result.append (Struct_selection_operator)
				Result.append ("cNamedArgs")
				Result.append (Space)
				Result.append (More)
				Result.append (Zero)
				Result.append (Close_parenthesis)

				-- for (int i=0; i < 'dispparam'->cNamedArgs;i++)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				Result.append (For)
				Result.append (Space_open_parenthesis)
				Result.append ("i=0; i < ")
				Result.append (Dispparam_parameter)
				Result.append (Struct_selection_operator)
				Result.append ("cNamedArgs")
				Result.append (Semicolon)
				Result.append ("i++")
				Result.append (Close_parenthesis)

				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Plus)
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Dispparam_parameter)
				Result.append (Struct_selection_operator)
				Result.append ("rgdispidNamedArgs")
				Result.append (Close_parenthesis)
				Result.append (Plus)
				Result.append ("i")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Space_equal_space)
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (Variant_parameter)
				Result.append (Plus)
				Result.append ("i")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (New_line_tab_tab_tab)

				-- for (int i='dispparam'->cArgs, counter = 0;i>'dispparam'->cNamedArgs;i--)
				Result.append (For)
				Result.append (Space_open_parenthesis)
				Result.append ("i=")
				Result.append (Dispparam_parameter)
				Result.append (Struct_selection_operator)
				Result.append ("cArgs")
				Result.append (Semicolon)
				Result.append ("i>")
				Result.append (Dispparam_parameter)
				Result.append (Struct_selection_operator)
				Result.append ("cNamedArgs")
				Result.append (Semicolon)
				Result.append ("i--")
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Plus)
				Result.append (Open_parenthesis)
				Result.append (Dispparam_parameter)
				Result.append (Struct_selection_operator)
				Result.append ("cArgs")
				Result.append ("-i")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Space_equal_space)
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (Variant_parameter)
				Result.append (Plus)
				Result.append (Open_parenthesis)
				Result.append ("i-1")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
			end
			Result.append (New_line)
			Result.append (New_line_tab_tab_tab)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (func_desc.name)
			Result.append (Space_open_parenthesis)

			if not func_desc.arguments.empty then

				from
					func_desc.arguments.start
					counter := 0
				until
					func_desc.arguments.off
				loop
					create visitor
					visitor.visit (func_desc.arguments.item.type)

					Result.append (Space)
					Result.append (Open_parenthesis)
					Result.append (Tmp_variable_name)
					Result.append (Plus)
					Result.append_integer (counter)
					Result.append (Close_parenthesis)
					Result.append (Struct_selection_operator)
					Result.append (vartype_namer.variant_field_name (visitor))
					Result.append (Comma)

					if is_paramflag_fout (func_desc.arguments.item.flags) then
						local_buffer.append (Open_parenthesis)
						local_buffer.append (Tmp_variable_name)
						local_buffer.append (Plus)
						local_buffer.append_integer (counter)
						local_buffer.append (Close_parenthesis)
						local_buffer.append (Struct_selection_operator)
						local_buffer.append ("vt")
						local_buffer.append (Space_equal_space)
						local_buffer.append_integer (visitor.vt_type)
						local_buffer.append (Semicolon)
						local_buffer.append (New_line_tab_tab_tab)				
					end

					counter := counter + 1
					func_desc.arguments.forth
				end
				if func_desc.return_type.name.is_equal (Void_c_keyword) then
					Result.remove (Result.count)
				end
			end

			if not func_desc.return_type.name.is_equal (Void_c_keyword) then
				create visitor
				visitor.visit (func_desc.return_type)

				Result.append (Ampersand)
				Result.append ("pVarResult")
				Result.append (Struct_selection_operator)
				Result.append (vartype_namer.variant_field_name (visitor))

				local_buffer.append ("pVarResult")
				local_buffer.append (Struct_selection_operator)
				local_buffer.append ("vt")
				local_buffer.append (Space_equal_space)
				local_buffer.append_integer (visitor.vt_type)
				local_buffer.append (Semicolon)
				local_buffer.append (New_line_tab_tab_tab)
			end

			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)

			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Space_open_parenthesis)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)
			Result.append (Tab_tab)
			if not func_desc.arguments.empty then
				Result.append (Co_task_mem_free)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)
				Result.append (Tab_tab)
			end
			Result.append (Return)
			Result.append (Space)
			Result.append (Hresult_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
			Result.append (Close_curly_brace)
			Result.append (New_line_tab_tab_tab)

			if not local_buffer.empty then
				Result.append (local_buffer)
				Result.append (New_line_tab_tab_tab)
			end
			Result.append (Break)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
		end

	add_invoke_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add Invoke function
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info (a_coclass_descriptor)
			tmp_body.append (Assert)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (C_equal)
			tmp_body.append (Iid_type)
			tmp_body.append (Underscore)
			tmp_body.append (Null)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (C_void_pointer)
			tmp_body.append (Tmp_clause)
			tmp_body.append (This)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Static_cast)
			tmp_body.append (Less)
			tmp_body.append (dispatch_interface_name)
			tmp_body.append (Asterisk)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (This)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Type_info_variable_name)
			tmp_body.append (Struct_selection_operator)
			tmp_body.append (Invoke)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Tmp_clause)
			tmp_body.append (This)
			tmp_body.append (Comma_space)
			tmp_body.append ("dispID, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr")
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			func_writer.set_name (Invoke)
			func_writer.set_comment ("Invoke function.")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr")
			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end			

	add_query_interface is
			-- Add function 'QueryInterface'
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			func_writer.set_name (Query_interface)
			func_writer.set_comment ("Query Interface")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature (Query_interface_signature)

			tmp_body := clone (Tab)

			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (C_equal)
			tmp_body.append (Iunknown_clsid)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Static_cast)
			tmp_body.append (Less)
			tmp_body.append (interface_names.first)
			tmp_body.append (Asterisk)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (This)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Else_keyword)

			if dispatch_interface then
				tmp_body.append (Space)
				tmp_body.append (If_keyword)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Riid)
				tmp_body.append (C_equal)
				tmp_body.append (Iid_type)
				tmp_body.append (Underscore)
				tmp_body.append (Idispatch_type)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (New_line_tab_tab)
				tmp_body.append (Star_ppv)
				tmp_body.append (Space_equal_space)
				tmp_body.append (Static_cast)
				tmp_body.append (Less)
				tmp_body.append (dispatch_interface_name)
				tmp_body.append (Asterisk)
				tmp_body.append (More)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (This)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)
				tmp_body.append (Else_keyword)
			end

			from
				interface_names.start
			until
				interface_names.off
			loop
				tmp_body.append (Space)
				tmp_body.append (If_keyword)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Riid)
				tmp_body.append (C_equal)
				tmp_body.append (Iid_type)
				tmp_body.append (Underscore)
				tmp_body.append (interface_names.item)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (New_line_tab_tab)
				tmp_body.append (Star_ppv)
				tmp_body.append (Space_equal_space)
				tmp_body.append (Static_cast)
				tmp_body.append (Less)
				tmp_body.append (interface_names.item)
				tmp_body.append (Asterisk)
				tmp_body.append (More)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (This)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)
				tmp_body.append (Else_keyword)
				interface_names.forth
			end

			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Return)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Zero)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Comma_space)
			tmp_body.append (E_no_interface)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)
			tmp_body.append (Reinterpret_cast)
			tmp_body.append (Less)
			tmp_body.append (Iunknown)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Star_ppv)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Add_reference_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return_s_ok)

			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end

	add_addref_function is
			-- Add function 'AddRef()'.
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := clone (Tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Interlocked_increment)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Ampersand)
			tmp_body.append (Ref_count)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			func_writer.set_name ("AddRef")
			func_writer.set_comment ("Increment reference count")
			func_writer.set_result_type (Ulong_std_method_imp)
			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end

	check_type_info (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Code to check whether type info exist
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			tmp_path: STRING
			counter: INTEGER
			type_lib: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			type_lib := a_coclass_descriptor.type_library_descriptor
			Result := clone (Tab)

			-- if ( pTypeInfo == 0)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Type_info_variable_name)
			Result.append (C_equal)
			Result.append (Zero)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)

			-- HRESULT tmp_hr = 0;
			Result.append (Hresult)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			-- ITypeLib *pTypeLib = 0
			Result.append (Type_lib_type)
			Result.append (Type_lib_variable_name)
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)


			--tmp_hr = LoadRegTypeLib ('guid','major_version_num', 'minor_version_num', 'locale_id', pTypeLib)

			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append ("LoadRegTypeLib")
			Result.append (Space_open_parenthesis)
			Result.append (libid_name (type_lib.name))
			Result.append (Comma_space)
			Result.append_integer (type_lib.major_version_number)
			Result.append (Comma_space)
			Result.append_integer (type_lib.minor_version_number)
			Result.append (Comma_space)
			Result.append_integer (type_lib.lcid)
			Result.append (Comma_space)
			Result.append (Ampersand)
			Result.append (Type_lib_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- if (FAILED(tmp_hr))
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Open_parenthesis)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (tab)

			Result.append (Return)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (semicolon)
			Result.append (New_line_tab_tab)

			-- tmm_hr = pTypeLib->GetTypeInfoOfGuid (guid, pTypeInfo)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Type_lib_variable_name)
			Result.append (Struct_selection_operator)
			Result.append (Get_type_info_of_guid)
			Result.append (Space_open_parenthesis)
			Result.append (clsid_name(a_coclass_descriptor.c_type_name))
			Result.append (Comma_space)
			Result.append (Ampersand)
			Result.append (Type_info_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- If (FAILED(tmp_hr))
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Open_parenthesis)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab_tab)
			Result.append (Return)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (semicolon)
			Result.append (New_line_tab)
			-- }

			Result.append (Close_curly_brace)
			Result.append (New_line_tab)
		
		end

	add_release_function is
			-- Add function 'Release()'. 
		local
			tmp_body: STRING
			func_writer: WIZARD_WRITER_C_FUNCTION
		do
			create func_writer.make
			tmp_body := clone (Tab)
			tmp_body.append (Long_macro)
			tmp_body.append (Space)
			tmp_body.append ("res")
			tmp_body.append (Space_equal_space)
			tmp_body.append (Interlocked_decrement)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Ampersand)
			tmp_body.append (Ref_count)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append (If_keyword)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append ("res")
			tmp_body.append (Space)
			tmp_body.append (C_equal)
			tmp_body.append (Space)
			tmp_body.append (Zero)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)

			tmp_body.append (Delete)
			tmp_body.append (Space)
			tmp_body.append (This)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append ("res")
			tmp_body.append (Semicolon)

			func_writer.set_name ("Release")
			func_writer.set_comment ("Decrement reference count")
			func_writer.set_result_type (Ulong_std_method_imp)
			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end

	end -- class WIZARD_COCLASS_C_SERVER_GENERATOR

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
