indexing
	description: "Component C server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_C_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_C_GENERATOR

	WIZARD_CPP_WRITER_GENERATOR

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export 
			{NONE} all
		end

	ECOM_VAR_TYPE
		export 
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

feature -- Access

	dispatch_interface: BOOLEAN
			-- Is coclass contained dispatch interface?

	default_dispinterface (a_component: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_INTERFACE_DESCRIPTOR is
			-- Default dispinterface.
		require
			non_void_component: a_component /= Void
			dispatch_interface: dispatch_interface
		deferred
		ensure
			non_void_dispinterface: Result /= Void
		end

feature -- Basic Operations

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Generate C server for component.
		local
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			create cpp_class_writer.make
			cpp_class_writer.set_name (a_component.c_type_name)
			cpp_class_writer.set_header (a_component.description)
			cpp_class_writer.set_header_file_name (a_component.c_header_file_name)
			cpp_class_writer.add_import (Ecom_server_rt_globals_h)

			-- Add jmp_buf variable and integer value
			cpp_class_writer.add_other_source ("static int return_hr_value;")

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
		end

	standard_functions (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Standard functions.
		require
			non_void_component: a_component /= Void
			non_void_cpp_class_writer: cpp_class_writer /= Void	
		do
			add_constructor (a_component)
			add_constructor_from_object
			add_destructor

			-- Implement IUnknown interface
			add_release_function
			add_addref_function
			add_query_interface (a_component)
		end

	dispatch_interface_features (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Dispatch interface features.
		require
			dispatch_interface: dispatch_interface
			non_void_component: a_component /= Void
			non_void_cpp_class_writer: cpp_class_writer /= Void
		local
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			-- Add type library id
			cpp_class_writer.add_other_source (libid_definition (a_component.type_library_descriptor.name, a_component.type_library_descriptor.guid))

			-- member (ITypeInfo * pTypeInfo)
			create member_writer.make
			member_writer.set_name (Type_info_variable_name)
			member_writer.set_result_type (Type_info)
			member_writer.set_comment ("Type information")
			cpp_class_writer.add_member (member_writer, Private)

			add_get_type_info_function (a_component)
			add_get_type_info_count_function 
			add_get_ids_of_names_function (a_component)
			dispatch_invoke_function (a_component)
		end

	constructor_from_object_body: STRING is
			-- Body of constructor from Eiffel object.
		do
			create Result.make (1000)
			Result.append (Tab)
			Result.append (Eiffel_object)
			Result.append (Space_equal_space)
			Result.append (Eif_adopt)
			Result.append (Space_open_parenthesis)
			Result.append ("eif_obj")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			if dispatch_interface then
				Result.append (New_line_tab)
				Result.append (Type_info_variable_name)
				Result.append (Space_equal_space)
				Result.append (Zero)
				Result.append (Semicolon)
			end
		end

	add_constructor_from_object is
			-- Add constructor from Eiffel object.
		local
			constructor_writer: WIZARD_WRITER_CPP_CONSTRUCTOR
			a_signature: STRING
		do
			create constructor_writer.make

			create a_signature.make (100)
			a_signature.append (Eif_object)
			a_signature.append (Space)
			a_signature.append ("eif_obj")
			constructor_writer.set_signature (a_signature)

			constructor_writer.set_body (constructor_from_object_body)
			check
				valid_constructor_writer: constructor_writer.can_generate
			end

			cpp_class_writer.add_constructor (constructor_writer)

			check
				writer_added: cpp_class_writer.constructors.has (constructor_writer)
			end
		end

	constructor_body: STRING is
			-- Body of constructor.
		do
			create Result.make (1000)
			Result.append (New_line_tab)
			Result.append (Eiffel_object)
			Result.append (Space_equal_space)
			Result.append (Eif_create)
			Result.append (Space_open_parenthesis)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_procedure = eif_procedure ("make_from_pointer", tid)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_equal_space)
			Result.append (Eif_procedure_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append ("make_from_pointer")
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			Result.append ("(FUNCTION_CAST (")
			Result.append (Void_c_keyword)
			Result.append (Comma)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_reference)
			Result.append (Comma_space)
			Result.append (Eif_pointer)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Open_parenthesis)
			Result.append (Eif_pointer)
			Result.append (Close_parenthesis)
			Result.append ("this")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)

			if dispatch_interface then
				Result.append (New_line_tab)
				Result.append (Type_info_variable_name)
				Result.append (Space_equal_space)
				Result.append (Zero)
				Result.append (Semicolon)
			end

			if shared_wizard_environment.server then
				Result.append (New_line_tab)
				Result.append ("LockModule ();")
			end

		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	add_constructor (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add constructor.
		deferred
		end

	add_destructor is
		local
			tmp_body: STRING
		do
			create tmp_body.make (10000)
			tmp_body.append (Tab)
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

			if shared_wizard_environment.server then
				tmp_body.append (New_line_tab)
				tmp_body.append ("UnlockModule ();")
			end
			cpp_class_writer.set_destructor (tmp_body)
		end

	add_get_type_info_function (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add GetTypeInfo function.
		require
			non_void_component: a_component /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			create tmp_body.make (1000)

			tmp_body.append (tab)
			tmp_body.append ("if (itinfo != 0) %N%T%Treturn ResultFromScode(DISP_E_BADINDEX);")
			tmp_body.append (New_line_tab)

			tmp_body.append ("*pptinfo = NULL;")
			tmp_body.append (New_line)

			tmp_body.append (check_type_info (a_component))

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
		
	add_get_type_info_count_function is
			-- Add GetTypeInfoCount function.
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			create tmp_body.make (10000)
			tmp_body.append (Tab)
			tmp_body.append ("if (pctinfo == NULL)")
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append ("E_NOTIMPL")
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

	add_get_ids_of_names_function (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add GetIDsOfNames function
		require
			non_void_coclass_descriptor: a_component /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info (a_component)

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

	dispatch_invoke_function (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add Invoke function for pure dispatch interface
		require
			non_void_component: a_component /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			body_code: STRING
		do
			create func_writer.make

			func_writer.set_name (Invoke)
			func_writer.set_comment ("Invoke function.")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr")

			create body_code.make (100000)

			body_code.append (Tab)
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

			body_code.append ("VARIANTARG * rgvarg")
			body_code.append (Space_equal_space)
			body_code.append (Dispparam_parameter)
			body_code.append (Struct_selection_operator)
			body_code.append ("rgvarg")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			body_code.append ("DISPID * rgdispidNamedArgs")
			body_code.append (Space_equal_space)
			body_code.append (Dispparam_parameter)
			body_code.append (Struct_selection_operator)
			body_code.append ("rgdispidNamedArgs")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			body_code.append ("unsigned int cArgs")
			body_code.append (Space_equal_space)
			body_code.append (Dispparam_parameter)
			body_code.append (Struct_selection_operator)
			body_code.append ("cArgs")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			body_code.append ("unsigned int cNamedArgs")
			body_code.append (Space_equal_space)
			body_code.append (Dispparam_parameter)
			body_code.append (Struct_selection_operator)
			body_code.append ("cNamedArgs")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)

			body_code.append ("VARIANTARG * ")
			body_code.append (Tmp_variable_name)
			body_code.append (Space_equal_space)
			body_code.append (Zero)
			body_code.append (Semicolon)
			body_code.append (New_line)
			body_code.append (New_line_tab)

			body_code.append ("pExcepInfo->wCode = 0;%N%T")
			body_code.append ("pExcepInfo->wReserved = 0;%N%T")
			body_code.append ("pExcepInfo->bstrSource = NULL;%N%T")
			body_code.append ("pExcepInfo->bstrDescription = NULL;%N%T")
			body_code.append ("pExcepInfo->bstrHelpFile = NULL;%N%T")
			body_code.append ("pExcepInfo->dwHelpContext = 0;%N%T")
			body_code.append ("pExcepInfo->pvReserved = NULL;%N%T")
			body_code.append ("pExcepInfo->pfnDeferredFillIn = NULL;%N%T")
			body_code.append ("pExcepInfo->scode = 0;%N%T")

			body_code.append (Switch)
			body_code.append (Space_open_parenthesis)
			body_code.append ("dispID")
			body_code.append (Close_parenthesis)
			body_code.append (New_line_tab)
			body_code.append (Open_curly_brace)
			body_code.append (New_line_tab_tab)

			body_code.append (invoke_function_case_item (default_dispinterface (a_component)))
			body_code.append (New_line_tab_tab)
			body_code.append ("default:")
			body_code.append (New_line_tab_tab_tab)
			body_code.append (Return)
			body_code.append (Space)
			body_code.append ("DISP_E_MEMBERNOTFOUND")
			body_code.append (Semicolon)
			body_code.append (New_line_tab)
			body_code.append (Close_curly_brace)

			body_code.append (New_line_tab)
			body_code.append (Return_s_ok)

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
			create Result.make (10000)			

			from
				interface_desc.functions.start
			until
				interface_desc.functions.after
			loop
				if (interface_desc.functions.item.func_kind = Func_dispatch) then
					if is_propertyget (interface_desc.functions.item.invoke_kind) then
						prop_get_functions.force (propertyget_case (interface_desc.functions.item), interface_desc.functions.item.member_id)
					elseif is_propertyput (interface_desc.functions.item.invoke_kind) then
						prop_put_functions.force (propertyput_case (interface_desc.functions.item), interface_desc.functions.item.member_id)
					elseif is_propertyputref (interface_desc.functions.item.invoke_kind) then
						prop_put_functions.force (propertyput_case (interface_desc.functions.item), interface_desc.functions.item.member_id)
					else
						Result.append (function_case (interface_desc.functions.item))
					end
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

			create Result.make (10000)
			Result.append (New_line_tab_tab)
			Result.append (Case)
			Result.append (Space)
			Result.append_integer (prop_desc.member_id)
			Result.append (Colon)
			Result.append (New_line_tab_tab_tab)

			if prop_get_func.has (prop_desc.member_id) then
				Result.append (prop_get_func.item (prop_desc.member_id))
				prop_get_func.remove (prop_desc.member_id)
			else
				create Result.make (10000)
				Result.append (If_keyword)
				Result.append (Space_open_parenthesis)
				Result.append ("wFlags")
				Result.append (Ampersand)
				Result.append (" (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF)")
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab)
				Result.append (Open_curly_brace)
				Result.append (New_line_tab_tab_tab)

				visitor := prop_desc.data_type.visitor

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
					Result.append (If_keyword)
					Result.append (Space_open_parenthesis)
					Result.append ("wFlags")
					Result.append (Ampersand)
					Result.append (" (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF)")
					Result.append (Close_parenthesis)
					Result.append (New_line_tab_tab)
					Result.append (Open_curly_brace)
					Result.append (New_line_tab_tab_tab)

					visitor := prop_desc.data_type.visitor
	
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
		do
			create Result.make (10000)
			Result.append (New_line_tab_tab_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append ("wFlags ")
			Result.append (Ampersand)
			Result.append (" (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF)")
			Result.append (Close_parenthesis)
			Result.append (function_case_body (func_desc))
		end

	propertyget_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		do
			create Result.make (10000)
			Result.append (New_line_tab_tab_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append ("wFlags ")
			Result.append (Ampersand)
			Result.append (" (DISPATCH_PROPERTYGET | DISPATCH_METHOD)")
			Result.append (Close_parenthesis)
			Result.append (function_case_body (func_desc))
		end

	check_failer  (func_desc: WIZARD_FUNCTION_DESCRIPTOR; an_additional_string, a_return_code: STRING): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
			non_void_additional_string: an_additional_string /= Void
			non_void_return_code: a_return_code /= Void
			valid_return_code: not a_return_code.empty
		do
			create Result.make (10000)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Space_open_parenthesis)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			if not func_desc.arguments.empty then
				Result.append (Co_task_mem_free)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
			end
			Result.append (an_additional_string)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			Result.append (Return)
			Result.append (Space)
			Result.append (a_return_code)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			
			Result.append (Close_curly_brace)
			Result.append (New_line_tab_tab_tab)
		end

	excepinfo_setting (an_application_name: STRING): STRING is
			-- Fills EXCEPINFO `bstrDescription' and `bstrSource'
		require
			non_void_application_name: an_application_name /= Void
			valid_application_name: not an_application_name.empty
		do
			Result := "WCHAR * wide_string = 0;%N%
	%					wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));%N%
	%					BSTR b_string = SysAllocString (wide_string);%N%
	%					free (wide_string);%N%
	%					pExcepInfo->bstrDescription = b_string;%N%
	%					wide_string = ccom_create_from_string (%"" + an_application_name + "%");%N%
	%					b_string = SysAllocString (wide_string);%N%
	%					free (wide_string);%N%
	%					pExcepInfo->bstrSource = b_string;%N%
	%					pExcepInfo->wCode = HRESULT_CODE (hr);"
		end

	function_case_body (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			counter: INTEGER
			local_buffer: STRING
		do
			create local_buffer.make (10000)
			create Result.make (10000)
			Result.append (New_line_tab_tab_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)

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

			Result.append (Tab_tab)
			Result.append (Return)
			Result.append (Space)
			Result.append ("DISP_E_BADPARAMCOUNT")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)

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
				Result.append (Tab)

				Result.append (If_keyword)
				Result.append (Space_open_parenthesis)
				Result.append ("cNamedArgs")
				Result.append (Space)
				Result.append (More)
				Result.append (Zero)
				Result.append (Close_parenthesis)

				-- for (int i=0; i < 'dispparam'->cNamedArgs;i++)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				Result.append (For)
				Result.append (Space_open_parenthesis)
				Result.append ("i = 0; i < ")
				Result.append ("cNamedArgs")
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i++")
				Result.append (Close_parenthesis)

				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab_tab)
				Result.append (Memcpy)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("rgdispidNamedArgs")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("i")
				Result.append (Close_bracket)
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append ("rgvarg")
				Result.append (Open_bracket)
				Result.append ("i")
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append ("VARIANTARG")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				-- for (int i='dispparam'->cArgs, counter = 0;i>'dispparam'->cNamedArgs;i--)
				Result.append (For)
				Result.append (Space_open_parenthesis)
				Result.append ("i = ")
				Result.append ("cArgs")
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i > ")
				Result.append ("cNamedArgs")
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i--")
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)

				Result.append (Memcpy)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("rgdispidNamedArgs")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("cArgs")
				Result.append (Close_bracket)
				Result.append (" - i")
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append ("rgvarg")
				Result.append (Open_bracket)
				Result.append ("i - 1")
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append ("VARIANTARG")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				from
					func_desc.arguments.start
					counter := 0
				until
					func_desc.arguments.after
				loop
					visitor := func_desc.arguments.item.type.visitor

					Result.append (If_keyword)
					Result.append (Space_open_parenthesis)
					Result.append (Tmp_variable_name)
					Result.append (Space)
					Result.append (Open_bracket)
					Result.append_integer (counter)
					Result.append (Close_bracket)
					Result.append (Dot)
					Result.append ("vt")
					Result.append (Space)
					Result.append (C_not_equal)
					Result.append_integer (visitor.vt_type)
					Result.append (Close_parenthesis)
					Result.append (New_line_tab_tab_tab)
					Result.append (Tab)
					Result.append (Open_curly_brace)
					Result.append (New_line_tab_tab_tab)
					Result.append (Tab)
					Result.append (Tab)
					Result.append (Co_task_mem_free)
					Result.append (Space_open_parenthesis)
					Result.append (Tmp_variable_name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab_tab_tab)
					Result.append (Tab_tab)
					
					Result.append (Return)
					Result.append (Space)
					Result.append ("DISP_E_BADVARTYPE")
					Result.append (Semicolon)
					Result.append (New_line_tab_tab_tab)
					Result.append (Tab)
					Result.append (Close_curly_brace)
					Result.append (New_line_tab_tab_tab)
					Result.append (Tab)

					if 
						(visitor.is_interface_pointer or 
						visitor.is_coclass_pointer) and
						not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
						visitor.c_type.substring_index (Idispatch_type, 1) > 0)
					then
						Result.append (visitor.c_type)
						Result.append (Space)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Zero)						
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (Iunknown)
						Result.append (Space)
						Result.append ("tmp_")
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Tmp_variable_name)
						Result.append (Space)
						Result.append (Open_bracket)
						Result.append_integer (counter)
						Result.append (Close_bracket)
						Result.append (Dot)
						Result.append (vartype_namer.variant_field_name (visitor))
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append ("IID tmp_iid_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (interface_descriptor_guid (func_desc.arguments.item.type, visitor).to_definition_string)
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (Hresult_variable_name)
						Result.append (Space_equal_space)
						Result.append ("tmp_")
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Struct_selection_operator)
						Result.append (Query_interface)
						Result.append (Space_open_parenthesis)
						Result.append ("tmp_iid_")
						Result.append_integer (counter)
						Result.append (Comma_space)
						Result.append ("(void**)")
						Result.append (Open_parenthesis)
						Result.append (Ampersand)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Close_parenthesis)
						Result.append (Close_parenthesis)
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (check_failer (func_desc, "", "DISP_E_BADVARTYPE"))


					elseif 
						(visitor.is_interface_pointer_pointer or 
						visitor.is_coclass_pointer_pointer) and
						not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
						visitor.c_type.substring_index (Idispatch_type, 1) > 0)
					then
						Result.append (visitor.c_type)
						Result.append (Space)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Zero)						
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append ("IID tmp_iid_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (interface_descriptor_guid (func_desc.arguments.item.type, visitor).to_definition_string)
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (interface_descriptor_c_type_name (func_desc.arguments.item.type, visitor))
						Result.append (Space)
						Result.append (Asterisk)
						Result.append (Space)
						Result.append ("tmp_tmp_arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Zero)						
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (Iunknown)
						Result.append (Asterisk)
						Result.append (Space)
						Result.append ("tmp_")
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Tmp_variable_name)
						Result.append (Space)
						Result.append (Open_bracket)
						Result.append_integer (counter)
						Result.append (Close_bracket)
						Result.append (Dot)
						Result.append (vartype_namer.variant_field_name (visitor))
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (Hresult_variable_name)
						Result.append (Space_equal_space)
						Result.append (Open_parenthesis)
						Result.append (Asterisk)
						Result.append ("tmp_")
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Close_parenthesis)
						Result.append (Struct_selection_operator)
						Result.append (Query_interface)
						Result.append (Space_open_parenthesis)
						Result.append ("tmp_iid_")
						Result.append_integer (counter)
						Result.append (Comma_space)
						Result.append ("(void**)")
						Result.append (Open_parenthesis)
						Result.append (Ampersand)
						Result.append ("tmp_tmp_arg_")
						Result.append_integer (counter)
						Result.append (Close_parenthesis)
						Result.append (Close_parenthesis)
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (check_failer (func_desc, "", "DISP_E_BADVARTYPE"))

						Result.append (Tab)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Ampersand)
						Result.append ("tmp_tmp_arg_")
						Result.append_integer (counter)						
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

					elseif visitor.is_structure then
						Result.append (visitor.c_type)
						Result.append (Space)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

						Result.append (Memcpy)
						Result.append (Space_open_parenthesis)
						Result.append (Ampersand)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Comma_space)
						if not (visitor.vt_type = Vt_variant) then
							Result.append (Ampersand)
							Result.append (Open_parenthesis)
						end
						Result.append (Tmp_variable_name)
						Result.append (Space)
						Result.append (Open_bracket)
						Result.append_integer (counter)
						Result.append (Close_bracket)
						Result.append (Dot)
						Result.append (vartype_namer.variant_field_name (visitor))
						if not (visitor.vt_type = Vt_variant) then
							Result.append (Close_parenthesis)
						end
						Result.append (Comma_space)
						Result.append (sizeof)
						Result.append (Space_open_parenthesis)
						Result.append (visitor.c_type)
						Result.append (Close_parenthesis)
						Result.append (Close_parenthesis)
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)

					else
						Result.append (visitor.c_type)
						Result.append (Space)
						Result.append ("arg_")
						Result.append_integer (counter)
						Result.append (Space_equal_space)
						Result.append (Tmp_variable_name)
						Result.append (Space)
						Result.append (Open_bracket)
						Result.append_integer (counter)
						Result.append (Close_bracket)
						Result.append (Dot)
						Result.append (vartype_namer.variant_field_name (visitor))
						Result.append (Semicolon)
						Result.append (New_line_tab_tab_tab)
						Result.append (Tab)
					end

					if is_paramflag_fout (func_desc.arguments.item.flags) then
						local_buffer.append (Tmp_variable_name)
						local_buffer.append (Space)
						local_buffer.append (Open_bracket)
						local_buffer.append_integer (counter)
						local_buffer.append (Close_bracket)
						local_buffer.append (Dot)
						local_buffer.append ("vt")
						local_buffer.append (Space_equal_space)
						local_buffer.append_integer (visitor.vt_type)
						local_buffer.append (Semicolon)
						local_buffer.append (New_line_tab_tab_tab)	
						local_buffer.append (Tab)

						if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
							local_buffer.append (Asterisk)
							local_buffer.append (Open_parenthesis)
						end
						local_buffer.append (Tmp_variable_name)
						local_buffer.append (Space)
						local_buffer.append (Open_bracket)
						local_buffer.append_integer (counter)
						local_buffer.append (Close_bracket)
						local_buffer.append (Dot)
						local_buffer.append (vartype_namer.variant_field_name (visitor))
						if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
							local_buffer.append (Close_parenthesis)
						end
						local_buffer.append (Space_equal_space)
						if 
							(visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer or
							visitor.is_interface_pointer or visitor.is_coclass_pointer) and
							not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
							visitor.c_type.substring_index (Idispatch_type, 1) > 0)
						then
							local_buffer.append ("static_cast<IUnknown *>(")
						end
						if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
							local_buffer.append (Asterisk)
						end
						local_buffer.append ("arg_")
						local_buffer.append_integer (counter)
						if 
							(visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer or
							visitor.is_interface_pointer or visitor.is_coclass_pointer) and
							not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
							visitor.c_type.substring_index (Idispatch_type, 1) > 0)
						then
							local_buffer.append (Close_parenthesis)
						end
						local_buffer.append (Semicolon)
						local_buffer.append (New_line_tab_tab_tab)	
						local_buffer.append (Tab)
					end
					if func_desc.argument_count > 0 then
					end

					counter := counter + 1
					func_desc.arguments.forth
				end
			end
			if not func_desc.return_type.name.is_equal (Void_c_keyword) then
				visitor := func_desc.return_type.visitor

				Result.append (visitor.c_type)
				Result.append (Space)
				Result.append (C_result)
				if not visitor.is_structure then
					Result.append (Space_equal_space)
					Result.append (Zero)
				end
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				local_buffer.append ("pVarResult")
				local_buffer.append (Struct_selection_operator)
				local_buffer.append ("vt")
				local_buffer.append (Space_equal_space)
				if visitor.vt_type = Vt_hresult then
					local_buffer.append_integer (Vt_error)
				else
					local_buffer.append_integer (visitor.vt_type)
				end
				local_buffer.append (Semicolon)
				local_buffer.append (New_line_tab_tab_tab)
				local_buffer.append (Tab)

				if visitor.is_structure then
					local_buffer.append (memcpy)
					local_buffer.append (Space_open_parenthesis)
					local_buffer.append (Ampersand)
					local_buffer.append (Open_parenthesis)
					local_buffer.append ("pVarResult")
					local_buffer.append (Struct_selection_operator)
					local_buffer.append (vartype_namer.variant_field_name (visitor))
					local_buffer.append (Close_parenthesis)
					local_buffer.append (Comma_space)
					local_buffer.append (Ampersand)
					local_buffer.append (C_result)
					local_buffer.append (Comma_space)
					local_buffer.append (Sizeof)
					local_buffer.append (Space_open_parenthesis)
					local_buffer.append (visitor.c_type)
					local_buffer.append (Close_parenthesis)
					local_buffer.append (Close_parenthesis)
				else
					local_buffer.append ("pVarResult")
					local_buffer.append (Struct_selection_operator)
					local_buffer.append (vartype_namer.variant_field_name (visitor))
					local_buffer.append (Space_equal_space)
					local_buffer.append (C_result)
				end
				local_buffer.append (Semicolon)
				local_buffer.append (New_line_tab_tab_tab)
				local_buffer.append (Tab)
			end

			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (func_desc.name)
			Result.append (Space_open_parenthesis)


			if not func_desc.arguments.empty then

				from
					counter := 0
				until
					counter = func_desc.argument_count
				loop

					Result.append (Space)
					Result.append ("arg_")
					Result.append_integer (counter)
					Result.append (Comma)


					counter := counter + 1
				end
				if func_desc.return_type.name.is_equal (Void_c_keyword) then
					Result.remove (Result.count)
				end
			end

			if not func_desc.return_type.name.is_equal (Void_c_keyword) then
				visitor := func_desc.return_type.visitor

				Result.append (Ampersand)
				Result.append (C_result)
			end

			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)

			Result.append (check_failer (func_desc, excepinfo_setting (Shared_wizard_environment.project_name), "DISP_E_EXCEPTION"))

			if not local_buffer.empty then
				Result.append (Tab)
				Result.append (local_buffer)
				Result.append (New_line_tab_tab_tab)
			end

			if not func_desc.arguments.empty then
				Result.append (Tab)
				Result.append (If_keyword)
				Result.append (Space_open_parenthesis)
				Result.append ("cNamedArgs")
				Result.append (Space)
				Result.append (More)
				Result.append (Zero)
				Result.append (Close_parenthesis)

				-- for (int i=0; i < 'dispparam'->cNamedArgs;i++)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				
				Result.append (For)
				Result.append (Space_open_parenthesis)
				Result.append ("i = 0; i < ")
				Result.append ("cNamedArgs")
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i++")
				Result.append (Close_parenthesis)

				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab_tab)
				Result.append (Memcpy)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append ("rgvarg")
				Result.append (Open_bracket)
				Result.append ("i")
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("rgdispidNamedArgs")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("i")
				Result.append (Close_bracket)
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append ("VARIANTARG")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				-- for (int i='dispparam'->cArgs, counter = 0;i>'dispparam'->cNamedArgs;i--)
				Result.append (For)
				Result.append (Space_open_parenthesis)
				Result.append ("i = ")
				Result.append ("cArgs")
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i > ")
				Result.append ("cNamedArgs")
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i--")
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)

				Result.append (Memcpy)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append ("rgvarg")
				Result.append (Open_bracket)
				Result.append ("i - 1")
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("rgdispidNamedArgs")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("cArgs")
				Result.append (Close_bracket)
				Result.append (" - i")
				Result.append (Close_bracket)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append ("VARIANTARG")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (Co_task_mem_free)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
			end		
			Result.append (Close_curly_brace)
			Result.append (New_line_tab_tab_tab)
		end

	function_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		do
			create Result.make (1000)
			Result.append (New_line_tab_tab)
			Result.append (Case)
			Result.append (Space)
			Result.append_integer (func_desc.member_id)
			Result.append (Colon)
			Result.append (function_case_body (func_desc))

			Result.append (Break)
			Result.append (Semicolon)
			Result.append (New_line)
		end

	add_query_interface (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add function 'QueryInterface'
		deferred
		end

	add_addref_function is
			-- Add function 'AddRef()'.
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			create tmp_body.make (500)
			tmp_body.append (Tab)
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

	check_type_info (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Code to check whether type info exist
		require
			non_void_component: a_component /= Void
			non_void_defualt_interface: default_dispinterface_name (a_component) /= Void
		local
			tmp_path: STRING
			counter: INTEGER
			type_lib: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			type_lib := a_component.type_library_descriptor
			
			create Result.make (10000)
			Result.append (Tab)

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

			-- ITypeLib *pTypeLib = 0;
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
			Result.append (iid_name (default_dispinterface_name (a_component)))
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
			
			create tmp_body.make (10000)
			tmp_body.append (Tab)
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

			if dispatch_interface then
				tmp_body.append (Type_info_variable_name)
				tmp_body.append (Struct_selection_operator)
				tmp_body.append ("Release")
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab_tab)
			end

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

	interface_descriptor_c_type_name (a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Interface's name.
		require
			non_void_descriptor: a_data_type_descriptor /= Void
			non_void_visitor: a_visitor /= void
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if a_visitor.c_type.substring_index (iunknown_type, 1) /= 0 then
				Result := clone (iunknown_type)
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				Result := clone (idispatch_type)
			else
				check 
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer					
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.c_type_name
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.empty
		end

	interface_descriptor_guid (a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR): ECOM_GUID is
			-- Interface's GUID.
		require
			non_void_descriptor: a_data_type_descriptor /= Void
			non_void_visitor: a_visitor /= void
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if a_visitor.c_type.substring_index (iunknown_type, 1) /= 0 then
				create Result.make_from_string (iunknown_guid_string)
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				create Result.make_from_string (idispatch_guid_string)
			else
				check 
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer					
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.guid
			end
		ensure
			non_void_guid: Result /= Void
		end

	default_dispinterface_name (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		deferred
		end

end -- class WIZARD_COMPONENT_C_SERVER_GENERATOR

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
