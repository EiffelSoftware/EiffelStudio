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
			cpp_class_writer.set_declaration_header_file_name (a_component.c_declaration_header_file_name)
			cpp_class_writer.set_definition_header_file_name (a_component.c_definition_header_file_name)
			cpp_class_writer.add_import (Ecom_server_rt_globals_h)

			if not environment.is_client and not system_descriptor.coclasses.is_empty then
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
			create Result.make (500)
			Result.append ("%Tref_count = 0;%R%N%T")
			Result.append ("eiffel_object = eif_adopt (eif_obj);%R%N%T")
			Result.append ("type_id = eif_type (eiffel_object);")
			if dispatch_interface then
				Result.append ("%R%N%TpTypeInfo = 0;")
			end
			Result.append (constructor_addition (a_component))
		end

	add_constructor_from_object (a_component: WIZARD_COMPONENT_DESCRIPTOR)is
			-- Add constructor from Eiffel object.
		local
			l_writer: WIZARD_WRITER_CPP_CONSTRUCTOR
		do
			create l_writer.make
			l_writer.set_signature ("EIF_OBJECT eif_obj")
			l_writer.set_body (constructor_from_object_body (a_component))
			cpp_class_writer.add_constructor (l_writer)
		end

	constructor_body (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Body of constructor.
		do
			create Result.make (1000)

			Result.append ("%Tref_count = 0;%R%N%T")
			Result.append ("eiffel_object = eif_create (type_id);%R%N%T")
			Result.append ("EIF_PROCEDURE eiffel_procedure;%R%N%T")
			Result.append ("eiffel_procedure = eif_procedure (%"make_from_pointer%", type_id);%R%N%R%N%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);")
			if dispatch_interface then
				Result.append ("%R%N%TpTypeInfo = 0;")
			end
			Result.append (constructor_addition (a_component))
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	add_constructor (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add constructor.
		deferred
		end

	lock_module: STRING is
			-- "LockModule ();" line
		do
			create Result.make (0)
			if not environment.is_client and environment.is_out_of_process and not system_descriptor.coclasses.is_empty then
				Result.append ("%TLockModule ();%R%N")
			end
		ensure
			non_void_result: Result /= Void
		end
		
	add_destructor (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add destructor.
		local
			l_body: STRING
		do
			create l_body.make (10000)
			l_body.append ("%TEIF_PROCEDURE eiffel_procedure;%R%N%T")
			l_body.append ("eiffel_procedure = eif_procedure (%"set_item%", type_id);%R%N%R%N%T")
			l_body.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);%R%N%T")
			l_body.append ("eif_wean (eiffel_object);")
			if dispatch_interface then
				l_body.append ("%R%N%Tif (pTypeInfo)%R%N%T%TpTypeInfo->Release ();")
			end
			l_body.append (destructor_addition (a_component))
			cpp_class_writer.set_destructor (l_body)
		end

	unlock_module: STRING is
			-- "UnlockModule ();" line.
		do
			create Result.make (0)
			if not environment.is_client and environment.is_out_of_process and not system_descriptor.coclasses.is_empty then
				Result.append ("%TUnlockModule ();%R%N")
			end
		ensure
			non_void_result: Result /= Void
		end
		
	add_get_type_info_function (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add GetTypeInfo function.
		require
			non_void_component: a_component /= Void
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			l_body: STRING
		do
			create func_writer.make

			create l_body.make (500)
			l_body.append ("%Tif ((itinfo != 0) || (pptinfo == NULL))%R%N%T%Treturn E_INVALIDARG;%R%N%T")
			l_body.append ("*pptinfo = NULL;%R%N")
			l_body.append (check_type_info (a_component))
			l_body.append ("(*pptinfo = pTypeInfo)->AddRef ();%R%N%T")
			l_body.append ("return S_OK;")

			func_writer.set_name ("GetTypeInfo")
			func_writer.set_comment ("Get type info")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo")
			func_writer.set_body (l_body)

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
			l_body: STRING
		do
			create func_writer.make
			create l_body.make (200)
			l_body.append ("%Tif (pctinfo == NULL)%R%N%T%T")
			l_body.append ("return E_NOTIMPL;%R%N%T")
			l_body.append ("*pctinfo = 1;%R%N%T")
			l_body.append ("return S_OK;")
			func_writer.set_name (Get_type_info_count)
			func_writer.set_comment ("Get type info count")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("unsigned int * pctinfo")
			func_writer.set_body (l_body)

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
			l_body: STRING
		do
			create func_writer.make
			l_body := check_type_info (a_component)
			l_body.append ("return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);")
			func_writer.set_name ("GetIDsOfNames")
			func_writer.set_comment ("IDs of function names 'rgszNames'")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid")
			func_writer.set_body (l_body)

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
			
			body_code.append ("unsigned int uArgErr;%R%N%T")
			body_code.append ("if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))%R%N%T%T")
			body_code.append ("return ResultFromScode (E_INVALIDARG);%R%N%R%N%T")
			
			body_code.append ("if (puArgErr == NULL)%R%N%T%T")
			body_code.append ("puArgErr = &uArgErr;%R%N%R%N%T")

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
			
			body_code.append ("if (pExcepInfo != NULL)%R%N%T{%R%N%T%T")
			body_code.append ("pExcepInfo->wCode = 0;%R%N%T%T")
			body_code.append ("pExcepInfo->wReserved = 0;%R%N%T%T")
			body_code.append ("pExcepInfo->bstrSource = NULL;%R%N%T%T")
			body_code.append ("pExcepInfo->bstrDescription = NULL;%R%N%T%T")
			body_code.append ("pExcepInfo->bstrHelpFile = NULL;%R%N%T%T")
			body_code.append ("pExcepInfo->dwHelpContext = 0;%R%N%T%T")
			body_code.append ("pExcepInfo->pvReserved = NULL;%R%N%T%T")
			body_code.append ("pExcepInfo->pfnDeferredFillIn = NULL;%R%N%T%T")
			body_code.append ("pExcepInfo->scode = 0;%R%N%T}%R%N%T")
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
			l_function: WIZARD_FUNCTION_DESCRIPTOR
			l_properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]
		do
			create prop_get_functions.make (2)
			create prop_put_functions.make (2)
			create Result.make (10000)			

			if interface_desc.is_idispatch_heir then
				from
					interface_desc.functions_start
				until
					interface_desc.functions_after
				loop
					l_function := interface_desc.functions_item
					if not l_function.is_renaming_clause and (l_function.dual or l_function.func_kind = func_dispatch) then
						if is_propertyget (l_function.invoke_kind) then
							prop_get_functions.force (propertyget_case (l_function), l_function.member_id)
						elseif is_propertyput (l_function.invoke_kind) then
							prop_put_functions.force (propertyput_case (l_function), l_function.member_id)
						elseif is_propertyputref (l_function.invoke_kind) then
							prop_put_functions.force (propertyput_case (l_function), l_function.member_id)
						else
							Result.append (function_case (l_function))
						end
					end
					interface_desc.functions_forth
				end
				l_properties := interface_desc.properties
				if not l_properties.is_empty then
					from
						l_properties.start
					until
						l_properties.after
					loop
						Result.append (case_code (properties_case_body (l_properties.item), l_properties.item.member_id))
						l_properties.forth
					end
				end
				if not prop_get_functions.is_empty then
					from
						prop_get_functions.start
					until
						prop_get_functions.after
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
						prop_put_functions.after
					loop
						Result.append (case_code (prop_put_functions.item_for_iteration, prop_put_functions.key_for_iteration))
						prop_put_functions.forth
					end
				end
				if not interface_desc.is_idispatch_heir then
					Result.append (invoke_function_case_item (interface_desc.inherited_interface))
				end
			end
		ensure
			non_void_result: Result /= Void
			valid_result: (interface_desc.is_idispatch_heir and not interface_desc.functions_empty) implies not Result.is_empty
		end

	properties_case_body (prop_desc: WIZARD_PROPERTY_DESCRIPTOR): STRING is
			-- Case for properties
		require
			non_void_property_descriptor: prop_desc /= Void
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			l_visitor := prop_desc.data_type.visitor
			Result.append ("%R%N%T%T%Tif (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))%R%N%T%T%T{%R%N%T%T%T%T")
			Result.append ("VariantClear (pVarResult);%R%N%T%T%T%TpVarResult->vt = ")
			Result.append_integer (l_visitor.vt_type)
			Result.append (";%R%N%T%T%T%T")
			Result.append (l_visitor.c_type)
			Result.append (" result")
			if not l_visitor.is_structure then
				Result.append (" = 0")
			end
			Result.append (";%R%N%T%T%T%T")
			Result.append ("hr = get_")
			Result.append (prop_desc.name)
			Result.append (" (&result);%R%N%T%T%T%T")

			Result.append (check_failer (0, excepinfo_setting, "DISP_E_EXCEPTION"))
			Result.append ("%R%N%T%T%T%T")

			if l_visitor.is_structure then
				Result.append ("memcpy (&(pVarResult->")
				Result.append (vartype_namer.variant_field_name (l_visitor))
				Result.append ("), &result, sizeof (")
				Result.append (l_visitor.c_type)
				Result.append ("))")
			else
				Result.append ("pVarResult->")
				Result.append (vartype_namer.variant_field_name (l_visitor))
				Result.append (" = result")
			end
			Result.append (";%R%N%T%T%T}%R%N%T%T%T")

			if not prop_desc.is_read_only then
				Result.append ("if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))%R%N%T%T%T{%R%N%T%T%T%T")
				l_visitor := prop_desc.data_type.visitor
				Result.append (";%R%N%T%T%T%T")
				Result.append (get_argument_from_variant (prop_desc.data_type, "arg", "(&(pDispParams->rgvarg [0]))", 0, 0))
				Result.append ("hr = set_")
				Result.append (prop_desc.name)
				Result.append (" (arg);%R%N%T%T%T%T")
				Result.append (check_failer (0, excepinfo_setting, "DISP_E_EXCEPTION"))
				Result.append ("%R%N%T%T%T}")
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
			valid_body_start: a_case_body.substring_index ("%R%N%T%T%T%<", 1) = 1 or a_case_body.substring_index ("%R%N%T%T%Tif", 1) = 1
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
			l_body: STRING
		do
			create func_writer.make

			create l_body.make (500)
			l_body.append (lock_module)
			l_body.append (Tab)
			l_body.append (Return)
			l_body.append (Space)
			l_body.append (Interlocked_increment)
			l_body.append (Space_open_parenthesis)
			l_body.append (Ampersand)
			l_body.append (Ref_count)
			l_body.append (Close_parenthesis)
			l_body.append (Semicolon)

			func_writer.set_name ("AddRef")
			func_writer.set_comment ("Increment reference count")
			func_writer.set_result_type (Ulong_std_method_imp)
			func_writer.set_body (l_body)

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
			l_body: STRING
			func_writer: WIZARD_WRITER_C_FUNCTION
		do
			create func_writer.make
			
			create l_body.make (10000)
			l_body.append (unlock_module)
			l_body.append (Tab)
			l_body.append (Long_macro)
			l_body.append (Space)
			l_body.append ("res")
			l_body.append (Space_equal_space)
			l_body.append (Interlocked_decrement)
			l_body.append (Space_open_parenthesis)
			l_body.append (Ampersand)
			l_body.append (Ref_count)
			l_body.append (Close_parenthesis)
			l_body.append (Semicolon)
			l_body.append (New_line_tab)

			l_body.append (If_keyword)
			l_body.append (Space)
			l_body.append (Open_parenthesis)
			l_body.append ("res")
			l_body.append (Space)
			l_body.append (C_equal)
			l_body.append (Space)
			l_body.append (Zero)
			l_body.append (Close_parenthesis)
			l_body.append (New_line_tab)

			l_body.append (Open_curly_brace)
			l_body.append (New_line_tab_tab)

			if dispatch_interface then
				l_body.append (If_keyword)
				l_body.append (Space)
				l_body.append (Open_parenthesis)
				l_body.append (Type_info_variable_name)
				l_body.append (Space)
				l_body.append (C_not_equal)
				l_body.append (Null)
				l_body.append (Close_parenthesis)
				l_body.append (New_line_tab_tab)

				l_body.append (Open_curly_brace)
				l_body.append (New_line_tab_tab_tab)

				l_body.append (Type_info_variable_name)
				l_body.append (Struct_selection_operator)
				l_body.append ("Release")
				l_body.append (Space_open_parenthesis)
				l_body.append (Close_parenthesis)
				l_body.append (Semicolon)
				l_body.append (New_line_tab_tab_tab)

				l_body.append (Type_info_variable_name)
				l_body.append (Space_equal_space)
				l_body.append (Null)
				l_body.append (Semicolon)
				l_body.append (New_line_tab_tab)

				l_body.append (Close_curly_brace)
				l_body.append (New_line_tab_tab)
			end

			l_body.append (Delete)
			l_body.append (Space)
			l_body.append (This)
			l_body.append (Semicolon)
			l_body.append (New_line_tab)

			l_body.append (Close_curly_brace)
			l_body.append (New_line_tab)

			l_body.append (Return)
			l_body.append (Space)
			l_body.append ("res")
			l_body.append (Semicolon)

			func_writer.set_name ("Release")
			func_writer.set_comment ("Decrement reference count")
			func_writer.set_result_type (Ulong_std_method_imp)
			func_writer.set_body (l_body)

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
