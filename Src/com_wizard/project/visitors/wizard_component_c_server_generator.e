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

	WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
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
			cpp_class_writer.set_namespace (a_component.namespace)
			cpp_class_writer.set_header (a_component.description)
			cpp_class_writer.set_header_file_name (a_component.c_header_file_name)
			cpp_class_writer.add_import (Ecom_server_rt_globals_h)

			if 
				shared_wizard_environment.server and
				not system_descriptor.coclasses.is_empty
			then
				cpp_class_writer.add_import ("server_registration.h")
			end

			-- Add jmp_buf variable
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
			add_constructor_from_object  (a_component)
			add_destructor (a_component)

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
			cpp_class_writer.add_other_source (libid_definition 
					(a_component.type_library_descriptor.name, 
					a_component.type_library_descriptor.guid))

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

	constructor_addition (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Constructor addition.
		do
			create Result.make (0)
		ensure
			non_void_addition: Result /= Void
		end

	destructor_addition (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Destructor addition.
		do
			create Result.make (0)
		ensure
			non_void_addition: Result /= Void
		end

	constructor_from_object_body (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Body of constructor from Eiffel object.
		do
			create Result.make (1000)
			Result.append (Tab)
			Result.append ("ref_count = 0;")
			Result.append (New_line_tab)

			Result.append (Eiffel_object)
			Result.append (Space_equal_space)
			Result.append (Eif_adopt)
			Result.append (Space_open_parenthesis)
			Result.append ("eif_obj")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Type_id)
			Result.append (Space_equal_space)
			Result.append ("eif_type (")
			Result.append (Eiffel_object)
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
			Result.append (constructor_addition (a_component))
			if 
				shared_wizard_environment.server and
				shared_wizard_environment.out_of_process_server and
				not system_descriptor.coclasses.is_empty
			then
				Result.append (New_line_tab)
				Result.append ("LockModule ();")
			end
		end

	add_constructor_from_object (a_component: WIZARD_COMPONENT_DESCRIPTOR)is
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

			constructor_writer.set_body (constructor_from_object_body (a_component))
			check
				valid_constructor_writer: constructor_writer.can_generate
			end

			cpp_class_writer.add_constructor (constructor_writer)

			check
				writer_added: cpp_class_writer.constructors.has (constructor_writer)
			end
		end

	constructor_body (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Body of constructor.
		do
			create Result.make (1000)

			Result.append (New_line_tab)
			Result.append ("ref_count = 0;")
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
			Result.append (constructor_addition (a_component))

			if 
				shared_wizard_environment.server and
				shared_wizard_environment.out_of_process_server and
				not system_descriptor.coclasses.is_empty
			then
				Result.append (New_line_tab)
				Result.append ("LockModule ();")
			end

		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	add_constructor (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add constructor.
		deferred
		end

	add_destructor (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
		local
			tmp_body: STRING
		do
			create tmp_body.make (10000)

			tmp_body.append (Tab)
			tmp_body.append (Eif_procedure)
			tmp_body.append (Space)
			tmp_body.append (Eiffel_procedure_variable_name)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			-- eiffel_procedure = eif_procedure ("set_item", tid)
			tmp_body.append (Eiffel_procedure_variable_name)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Eif_procedure_name)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("set_item")
			tmp_body.append (Double_quote)
			tmp_body.append (Comma_space)
			tmp_body.append (Type_id)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)

			tmp_body.append ("(FUNCTION_CAST (")
			tmp_body.append (Void_c_keyword)
			tmp_body.append (Comma)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Eif_reference)
			tmp_body.append (Comma_space)
			tmp_body.append (Eif_pointer)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Eiffel_procedure_variable_name)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Eif_access)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Eiffel_object)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Comma_space)
			tmp_body.append (Null)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			tmp_body.append (New_line_tab)
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

			tmp_body.append (destructor_addition (a_component))
			if 
				shared_wizard_environment.server and
				shared_wizard_environment.out_of_process_server and
				not system_descriptor.coclasses.is_empty
			then
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
			tmp_body.append ("if ((itinfo != 0) || (pptinfo == NULL))%N%T%Treturn E_INVALIDARG;")
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
			
			body_code.append ("unsigned int uArgErr;%N%T")
			body_code.append ("if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))%N%T%T")
			body_code.append ("return ResultFromScode (E_INVALIDARG);%N%N%T")
			
			body_code.append ("if (puArgErr == NULL)%N%T%T")
			body_code.append ("puArgErr = &uArgErr;%N%N%T")

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

			body_code.append ("VARIANTARG ** ")
			body_code.append (Tmp_variable_name)
			body_code.append (Space_equal_space)
			body_code.append ("NULL")
			body_code.append (Semicolon)
			body_code.append (New_line)
			body_code.append (New_line_tab)
			
			body_code.append ("if (pExcepInfo != NULL)%N%T{%N%T%T")
			body_code.append ("pExcepInfo->wCode = 0;%N%T%T")
			body_code.append ("pExcepInfo->wReserved = 0;%N%T%T")
			body_code.append ("pExcepInfo->bstrSource = NULL;%N%T%T")
			body_code.append ("pExcepInfo->bstrDescription = NULL;%N%T%T")
			body_code.append ("pExcepInfo->bstrHelpFile = NULL;%N%T%T")
			body_code.append ("pExcepInfo->dwHelpContext = 0;%N%T%T")
			body_code.append ("pExcepInfo->pvReserved = NULL;%N%T%T")
			body_code.append ("pExcepInfo->pfnDeferredFillIn = NULL;%N%T%T")
			body_code.append ("pExcepInfo->scode = 0;%N%T}%N%T")
			body_code.append (New_line_tab)

			body_code.append (Switch)
			body_code.append (Space_open_parenthesis)
			body_code.append ("dispID")
			body_code.append (Close_parenthesis)
			body_code.append (New_line_tab)
			body_code.append (Open_curly_brace)
			body_code.append (New_line_tab_tab)

			if 
				default_dispinterface (a_component).dispinterface or
				default_dispinterface (a_component).dual
			then
				body_code.append (invoke_function_case_item (default_dispinterface (a_component)))
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
			dispatch_or_dual: interface_desc.dispinterface or interface_desc.dual
		local
			prop_get_functions: HASH_TABLE[STRING, INTEGER]
			prop_put_functions: HASH_TABLE[STRING, INTEGER]
			a_body: STRING
		do
			create prop_get_functions.make (2)
			create prop_put_functions.make (2)
			create Result.make (10000)			

			if interface_desc.inherit_from_dispatch then
				from
					interface_desc.functions_start
				until
					interface_desc.functions_after
				loop
					if 
						interface_desc.functions_item.dual or 
						interface_desc.functions_item.func_kind = func_dispatch
					then
						if is_propertyget (interface_desc.functions_item.invoke_kind) then
							prop_get_functions.force (propertyget_case (interface_desc.functions_item), interface_desc.functions_item.member_id)
						elseif is_propertyput (interface_desc.functions_item.invoke_kind) then
							prop_put_functions.force (propertyput_case (interface_desc.functions_item), interface_desc.functions_item.member_id)
						elseif is_propertyputref (interface_desc.functions_item.invoke_kind) then
							prop_put_functions.force (propertyput_case (interface_desc.functions_item), interface_desc.functions_item.member_id)
						else
							Result.append (function_case (interface_desc.functions_item))
						end
					end

					interface_desc.functions_forth
				end

				if not interface_desc.properties.is_empty then
					from
						interface_desc.properties.start
					until
						interface_desc.properties.after
					loop
						Result.append (case_code (properties_case_body (interface_desc.properties.item), interface_desc.properties.item.member_id))
						interface_desc.properties.forth
					end
				end

				if not prop_get_functions.is_empty then
					from
						prop_get_functions.start
					until
						prop_get_functions.off
					loop
						create a_body.make (1000)
						a_body.append (prop_get_functions.item_for_iteration)

						if prop_put_functions.has (prop_get_functions.key_for_iteration) then
							a_body.append (prop_put_functions.item (prop_get_functions.key_for_iteration))
							prop_put_functions.remove (prop_get_functions.key_for_iteration)
						end

						Result.append (case_code (a_body, prop_get_functions.key_for_iteration))
						prop_get_functions.forth
					end
				end

				if not prop_put_functions.is_empty then
					from
						prop_put_functions.start
					until
						prop_put_functions.off
					loop
						Result.append (case_code (prop_put_functions.item_for_iteration, prop_put_functions.key_for_iteration))
						prop_put_functions.forth
					end
				end

				if not interface_desc.inherited_interface.name.is_equal (IDispatch_type) then
					Result.append (invoke_function_case_item (interface_desc.inherited_interface))
				end
			end
		ensure
			non_void_result: Result /= Void
			valid_result: interface_desc.inherit_from_dispatch and 
					not interface_desc.functions_empty
					implies not Result.is_empty
		end

	properties_case_body (prop_desc: WIZARD_PROPERTY_DESCRIPTOR): STRING is
			-- Case for properties
		require
			non_void_property_descriptor: prop_desc /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			Result.append (New_line_tab_tab_tab)

			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append ("wFlags")
			Result.append (Ampersand)
			Result.append (" (DISPATCH_PROPERTYGET | DISPATCH_METHOD)")
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)

			visitor := prop_desc.data_type.visitor

			Result.append ("VariantClear (pVarResult);")
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			
			Result.append ("pVarResult")
			Result.append (Struct_selection_operator)
			Result.append ("vt")
			Result.append (Space_equal_space)
			Result.append_integer (visitor.vt_type)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)

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
			
			Result.append ("hr = ")
			Result.append (Get_clause)
			Result.append (prop_desc.name)
			Result.append (Space_open_parenthesis)
			Result.append (Ampersand)
			Result.append (C_result)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)

			Result.append (check_failer (0, excepinfo_setting, "DISP_E_EXCEPTION"))
			Result.append (New_line_tab_tab_tab)
			Result.append (tab)

			if visitor.is_structure then
				Result.append (memcpy)
				Result.append (Space_open_parenthesis)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append ("pVarResult")
				Result.append (Struct_selection_operator)
				Result.append (vartype_namer.variant_field_name (visitor))
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Ampersand)
				Result.append (C_result)
				Result.append (Comma_space)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
			else
				Result.append ("pVarResult")
				Result.append (Struct_selection_operator)
				Result.append (vartype_namer.variant_field_name (visitor))
				Result.append (Space_equal_space)
				Result.append (C_result)
			end
			Result.append (Semicolon)
			
			Result.append (New_line_tab_tab_tab)
			Result.append (Close_curly_brace)
			Result.append (New_line_tab_tab_tab)
			

			if not is_varflag_freadonly (prop_desc.var_flags) then
				
				Result.append (If_keyword)
				Result.append (Space_open_parenthesis)
				Result.append ("wFlags")
				Result.append (Ampersand)
				Result.append (" (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF)")
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab_tab)
				Result.append (Open_curly_brace)
				Result.append (New_line_tab_tab_tab)
				Result.append (tab)

				visitor := prop_desc.data_type.visitor

				Result.append (New_line_tab_tab_tab)
				Result.append (tab)

				Result.append (get_argument_from_variant (prop_desc.data_type, "arg", "(&(pDispParams->rgvarg [0]))", 0, 0))
				Result.append ("hr = ")
				Result.append (Set_clause)
				Result.append (prop_desc.name)
				Result.append (Space_open_parenthesis)
				Result.append ("arg")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (tab)
				Result.append (check_failer (0, excepinfo_setting, "DISP_E_EXCEPTION"))
				Result.append (New_line_tab_tab_tab)
				Result.append (Close_curly_brace)
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

	function_case_body (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		local
			a_body_generator: WIZARD_DISPATCH_INVOKE_CASE_BODY_GENERATOR
		do
			create a_body_generator.make (func_desc)
			Result := a_body_generator.function_case_body 
		ensure
			non_void_body: Result /= Void
			valid_body: Result /= Void
		end

	case_code (a_case_body: STRING; a_case_member_id: INTEGER): STRING is
			-- Code for case statement.
		require
			non_void_body: a_case_body /= Void
			non_empty_body: not a_case_body.is_empty 
			valid_body_start: a_case_body.substring_index ("%N%T%T%T%<", 1) = 1 or a_case_body.substring_index ("%N%T%T%Tif", 1) = 1
		do
			create Result.make (1000)
			Result.append (New_line_tab_tab)
			Result.append (Case)
			Result.append (Space)
			Result.append_integer (a_case_member_id)
			Result.append (Colon)
			Result.append (a_case_body)
			Result.append (New_line_tab_tab_tab)
			Result.append (Break)
			Result.append (Semicolon)
			Result.append (New_line)
		ensure
			non_void_code: Result /= Void
			non_empty_code: not Result.is_empty
		end

	function_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		do
			Result := case_code (function_case_body (func_desc), func_desc.member_id)
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

			-- pTypeLib->Release ();
			
			Result.append (Type_lib_variable_name + Release_function)
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
			tmp_body.append (New_line_tab)

			tmp_body.append (Open_curly_brace)
			tmp_body.append (New_line_tab_tab)

			if dispatch_interface then
				tmp_body.append (If_keyword)
				tmp_body.append (Space)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (Type_info_variable_name)
				tmp_body.append (Space)
				tmp_body.append (C_not_equal)
				tmp_body.append (Null)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (New_line_tab_tab)

				tmp_body.append (Open_curly_brace)
				tmp_body.append (New_line_tab_tab_tab)

				tmp_body.append (Type_info_variable_name)
				tmp_body.append (Struct_selection_operator)
				tmp_body.append ("Release")
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab_tab_tab)

				tmp_body.append (Type_info_variable_name)
				tmp_body.append (Space_equal_space)
				tmp_body.append (Null)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab_tab)

				tmp_body.append (Close_curly_brace)
				tmp_body.append (New_line_tab_tab)
			end

			tmp_body.append (Delete)
			tmp_body.append (Space)
			tmp_body.append (This)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append (Close_curly_brace)
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

	case_body_in_query_interface (interface_name, interface_namespace, interface_id: STRING): STRING is
			-- Case body in QueryInterface function implemenatation.
		require
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.is_empty
			non_void_interface_id: interface_id /= Void
			valid_interface_id: not interface_id.is_empty
		do
			create Result.make (200)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Riid)
			Result.append (C_equal)
			Result.append (interface_id)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (Star_ppv)
			Result.append (Space_equal_space)
			Result.append (Static_cast)
			Result.append (Less)
			if 
				interface_namespace /= Void and then
				not interface_namespace.is_empty
			then
				Result.append (interface_namespace)
				Result.append ("::")
			end
			Result.append (interface_name)
			Result.append (Asterisk)
			Result.append (More)
			Result.append (Open_parenthesis)
			Result.append (This)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Else_keyword)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
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
