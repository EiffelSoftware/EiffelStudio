indexing
	description: "Component C server generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			Result.append ("%Tref_count = 0;%N%T")
			Result.append ("eiffel_object = eif_adopt (eif_obj);%N%T")
			Result.append ("type_id = eif_type (eiffel_object);")
			if dispatch_interface then
				Result.append ("%N%TpTypeInfo = 0;")
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

			Result.append ("%Tref_count = 0;%N%T")
			Result.append ("eiffel_object = eif_create (type_id);%N%T")
			Result.append ("EIF_PROCEDURE eiffel_procedure;%N%T")
			Result.append ("eiffel_procedure = eif_procedure (%"make_from_pointer%", type_id);%N%N%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);")
			if dispatch_interface then
				Result.append ("%N%TpTypeInfo = 0;")
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
				Result.append ("%TLockModule ();%N")
			end
		ensure
			non_void_result: Result /= Void
		end

	add_destructor (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add destructor.
		local
			l_body: STRING
		do
			create l_body.make (2000)
			l_body.append (eif_initialize_aux_thread)
			l_body.append (ecom_enter_proc_stub)
			l_body.append (new_line)
			l_body.append ("%TEIF_PROCEDURE eiffel_procedure;%N%T")
			l_body.append ("eiffel_procedure = eif_procedure (%"set_item%", type_id);%N%N%T")
			l_body.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);%N%T")
			l_body.append ("eif_wean (eiffel_object);")
			if dispatch_interface then
				l_body.append ("%N%Tif (pTypeInfo)%N%T%TpTypeInfo->Release ();")
			end
			l_body.append (destructor_addition (a_component))
			l_body.append (new_line_tab)
			l_body.append (ecom_exit_proc_stub)
			cpp_class_writer.set_destructor (l_body)
		end

	unlock_module: STRING is
			-- "UnlockModule ();" line.
		do
			create Result.make (0)
			if not environment.is_client and environment.is_out_of_process and not system_descriptor.coclasses.is_empty then
				Result.append ("%TUnlockModule ();%N")
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
			l_body.append ("%Tif ((itinfo != 0) || (pptinfo == NULL))%N%T%Treturn E_INVALIDARG;%N%T")
			l_body.append ("*pptinfo = NULL;%N")
			l_body.append (check_type_info (a_component))
			l_body.append ("(*pptinfo = pTypeInfo)->AddRef ();%N%T")
			l_body.append ("return S_OK;")

			func_writer.set_name ("GetTypeInfo")
			func_writer.set_comment ("Get type info")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo")
			func_writer.set_body (l_body)
			cpp_class_writer.add_function (func_writer, Public)
		end

	add_get_type_info_count_function is
			-- Add GetTypeInfoCount function.
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			l_body: STRING
		do
			create func_writer.make
			create l_body.make (200)
			l_body.append ("%Tif (pctinfo == NULL)%N%T%T")
			l_body.append ("return E_NOTIMPL;%N%T")
			l_body.append ("*pctinfo = 1;%N%T")
			l_body.append ("return S_OK;")
			func_writer.set_name (Get_type_info_count)
			func_writer.set_comment ("Get type info count")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature ("unsigned int * pctinfo")
			func_writer.set_body (l_body)
			cpp_class_writer.add_function (func_writer, Public)
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
			cpp_class_writer.add_function (func_writer, Public)
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

			create body_code.make (10000)

			body_code.append ("%THRESULT hr = 0;%N%T")
			body_code.append ("int i = 0;%N%N%T")
			body_code.append ("unsigned int uArgErr;%N%T")
			body_code.append ("if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))%N%T%T")
			body_code.append ("return ResultFromScode (E_INVALIDARG);%N%N%T")

			body_code.append ("if (puArgErr == NULL)%N%T%T")
			body_code.append ("puArgErr = &uArgErr;%N%N%T")

			body_code.append ("VARIANTARG * rgvarg = pDispParams->rgvarg;%N%T")
			body_code.append ("DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;%N%T")
			body_code.append ("unsigned int cArgs = pDispParams->cArgs;%N%T")
			body_code.append ("unsigned int cNamedArgs = pDispParams->cNamedArgs;%N%T")
			body_code.append ("VARIANTARG ** tmp_value = NULL;%N%N%T")

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

			body_code.append ("switch (dispID)%N%T{%N%T%T")
			if default_dispinterface (a_component).dispinterface or default_dispinterface (a_component).dual then
				body_code.append (invoke_function_case_item (default_dispinterface (a_component)))
			end
			body_code.append ("%N%T%Tdefault:%N%T%T%Treturn DISP_E_MEMBERNOTFOUND;%N%T}%N%T")
			body_code.append ("return S_OK;")

			func_writer.set_body (body_code)
			cpp_class_writer.add_function (func_writer, Public)
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
			Result.append ("%N%T%T%Tif (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))%N%T%T%T{%N%T%T%T%T")
			Result.append ("VariantClear (pVarResult);%N%T%T%T%TpVarResult->vt = ")
			Result.append_integer (l_visitor.vt_type)
			Result.append (";%N%T%T%T%T")
			Result.append (l_visitor.c_type)
			Result.append (" result")
			if not l_visitor.is_structure then
				Result.append (" = 0")
			end
			Result.append (";%N%T%T%T%T")
			Result.append ("hr = get_")
			Result.append (prop_desc.name)
			Result.append (" (&result);%N%T%T%T%T")

			Result.append (check_failer (0, excepinfo_setting, "DISP_E_EXCEPTION"))
			Result.append ("%N%T%T%T%T")

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
			Result.append (";%N%T%T%T}%N%T%T%T")

			if not prop_desc.is_read_only then
				Result.append ("if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))%N%T%T%T{%N%T%T%T%T")
				l_visitor := prop_desc.data_type.visitor
				Result.append (";%N%T%T%T%T")
				Result.append (get_argument_from_variant (prop_desc.data_type, "arg", "(&(pDispParams->rgvarg [0]))", 0, 0))
				Result.append ("hr = set_")
				Result.append (prop_desc.name)
				Result.append (" (arg);%N%T%T%T%T")
				Result.append (check_failer (0, excepinfo_setting, "DISP_E_EXCEPTION"))
				Result.append ("%N%T%T%T}")
			end
		end

	propertyput_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Function code for propertyput
		require
			non_void_descriptor: func_desc /= Void
		do
			create Result.make (2000)
			Result.append ("%N%T%T%Tif (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))")
			Result.append (function_case_body (func_desc))
		end

	propertyget_case (func_desc: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		do
			create Result.make (2000)
			Result.append ("%N%T%T%Tif (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))")
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
			Result.append ("%N%T%Tcase ")
			Result.append_integer (a_case_member_id)
			Result.append_character (':')
			Result.append (a_case_body)
			Result.append ("%N%T%T%Tbreak;%N")
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
			l_body.append ("%T return InterlockedIncrement (&ref_count);")

			func_writer.set_name ("AddRef")
			func_writer.set_comment ("Increment reference count")
			func_writer.set_result_type (Ulong_std_method_imp)
			func_writer.set_body (l_body)
			cpp_class_writer.add_function (func_writer, Public)
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

			create Result.make (2000)

			Result.append ("%Tif (pTypeInfo == 0)%N%T{%N%T%T")
			Result.append ("HRESULT tmp_hr = 0;%N%T%T")
			Result.append ("ITypeLib *pTypeLib = 0;%N%T%T")

			-- tmp_hr = LoadRegTypeLib ('guid','major_version_num', 'minor_version_num', 'locale_id', pTypeLib)
			Result.append ("tmp_hr = LoadRegTypeLib (")
			Result.append (libid_name (type_lib.name))
			Result.append (", ")
			Result.append_integer (type_lib.major_version_number)
			Result.append (", ")
			Result.append_integer (type_lib.minor_version_number)
			Result.append (", ")
			Result.append_integer (type_lib.lcid)
			Result.append (", &pTypeLib);%N%T%T")

			Result.append ("if (FAILED(tmp_hr))%N%T%T%T")
			Result.append ("return tmp_hr;%N%T%T")

			-- tmp_hr = pTypeLib->GetTypeInfoOfGuid ('guid', &pTypeInfo)
			Result.append ("tmp_hr = pTypeLib->GetTypeInfoOfGuid (")
			Result.append (iid_name (default_dispinterface_name (a_component)))
			Result.append (", &pTypeInfo);%N%T%T")

			Result.append ("pTypeLib->Release ();%N%T%T")
			Result.append ("if (FAILED(tmp_hr))%N%T%T%T")
			Result.append ("return tmp_hr;%N%T}%N%T")
		end

	add_release_function is
			-- Add function 'Release()'. 
		local
			l_body: STRING
			func_writer: WIZARD_WRITER_C_FUNCTION
		do
			create func_writer.make

			create l_body.make (2000)
			l_body.append (unlock_module)
			l_body.append ("%TLONG res = InterlockedDecrement (&ref_count);%N%T")
			l_body.append ("if (res == 0)%N%T{%N%T%T")
			if dispatch_interface then
				l_body.append ("if (pTypeInfo != NULL)%N%T%T{%N%T%T%T")
				l_body.append ("pTypeInfo->Release();%N%T%T%T")
				l_body.append ("pTypeInfo = NULL;%N%T%T}%N%T%T")
			end
			l_body.append ("delete this;%N%T}%N%T")
			l_body.append ("return res;")

			func_writer.set_name ("Release")
			func_writer.set_comment ("Decrement reference count")
			func_writer.set_result_type (Ulong_std_method_imp)
			func_writer.set_body (l_body)
			cpp_class_writer.add_function (func_writer, Public)
		end

	case_body_in_query_interface (a_name, a_namespace, a_id: STRING): STRING is
			-- Case body in QueryInterface function implemenatation.
		require
			non_void_interface_name: a_name /= Void
			valid_interface_name: not a_name.is_empty
			non_void_interface_id: a_id /= Void
			valid_interface_id: not a_id.is_empty
		do
			create Result.make (200)
			Result.append ("if (riid == ")
			Result.append (a_id)
			Result.append (")%N%T%T")
			Result.append ("*ppv = static_cast<")
			if a_namespace /= Void and then not a_namespace.is_empty then
				Result.append (a_namespace)
				Result.append ("::")
			end
			Result.append (a_name)
			Result.append ("*>(this);%N%T")
			Result.append ("else")
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_COMPONENT_C_SERVER_GENERATOR


