indexing
	description: "Coclass c server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_C_SERVER_GENERATOR
	
inherit
	WIZARD_COCLASS_C_GENERATOR

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c server for coclass.
		local
			member_writer: WIZARD_WRITER_C_MEMBER
			a_class_object: WIZARD_CLASS_OBJECT_GENERATOR
			tmp_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			tmp_file_name: STRING
		do
			coclass_descriptor := a_descriptor

			create cpp_class_writer.make
			create interface_names.make

			-- Initialization
			dispatch_interface := False

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)

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

			-- member (ITypeInfo * pTypeInfo)
			create member_writer.make
			member_writer.set_name (Type_info_variable_name)
			member_writer.set_result_type (Type_info)
			member_writer.set_comment ("Type information")
			cpp_class_writer.add_member (member_writer, Private)

			-- constructor
			add_constructor

			-- destructor
			add_destructor

			-- Process functions
			process_interfaces				

			if dispatch_interface then
				add_get_type_info_function
				add_get_type_info_count_function
				add_get_ids_of_names_function
				add_invoke_function
			end

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
			tmp_coclass_descriptor := clone (coclass_descriptor)
			a_class_object.initialize
			a_class_object.generate (tmp_coclass_descriptor)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_c_server
		end

feature {NONE} -- Implementation

	dispatch_interface_name: STRING
			-- Name for a dispatch interface

	function_type: ECOM_FUNC_KIND is
			-- Function type
		once
			create Result
		end

	generate_functions_and_properties (a_desc: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate functions and properties of 'a_desc'
		local
			function_generator: WIZARD_CPP_SERVER_FUNCTION_GENERATOR
			property_generator: WIZARD_CPP_SERVER_PROPERTY_GENERATOR
		do

			if a_desc.dispinterface or a_desc.dual then
				dispatch_interface := True
				if dispatch_interface_name = Void then
					dispatch_interface_name := clone (a_desc.c_type_name)
				end
			end

			if not a_desc.properties.empty then
				from
					a_desc.properties.start
				until
					a_desc.properties.off
				loop
					create property_generator

					property_generator.generate (coclass_descriptor.name, a_desc.properties.item)
					cpp_class_writer.add_function (property_generator.c_access_feature, Public)
					cpp_class_writer.add_function (property_generator.c_setting_feature, Public)

					a_desc.properties.forth
				end
			end

			if not a_desc.functions.empty then
				from
					a_desc.functions.start
				until
					a_desc.functions.off
				loop
					if a_desc.functions.item.func_kind = function_type.Func_dispatch then
						create {WIZARD_CPP_DISPATCH_SERVER_FUNCTION_GENERATOR} function_generator
					else
						create function_generator
					end
					function_generator.generate (coclass_descriptor.name, a_desc.functions.item)
					cpp_class_writer.add_function (function_generator.ccom_feature_writer, Public)

					a_desc.functions.forth
				end
			end

			if a_desc.inherited_interface /= Void and not
					a_desc.inherited_interface.c_type_name.is_equal (Iunknown_type) and then
					not a_desc.inherited_interface.c_type_name.is_equal (Idispatch_type) then
				generate_functions_and_properties (a_desc.inherited_interface)
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
			tmp_string.append (Type_id)

			constructor_writer.set_signature (tmp_string)

			tmp_string := clone (Tab)
			tmp_string.append (Eiffel_object)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Eif_create)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Type_id)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			constructor_writer.set_body (tmp_string)
		
			check
				valid_constructor_writer: constructor_writer.can_generate
			end

			cpp_class_writer.add_constructor (constructor_writer)

			check
				writer_added: cpp_class_writer.constructors.has (constructor_writer)
			end
		end

	add_get_type_info_function is
			-- Add GetTypeInfo function.
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info
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
		
	add_get_type_info_count_function is
			-- Add GetTypeInfoCount function.
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info
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

	add_get_ids_of_names_function is
			-- Add GetIDsOfNames function
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info
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

	add_invoke_function is
			-- Add Invoke function
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			tmp_body := check_type_info
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

	check_type_info: STRING is
			-- Code to check whether type info exist
		do
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
			-- ITypeLib *pTypeLib
			Result.append (Type_lib_type)
			Result.append (Type_lib_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- OLECHAR tmp_value = OLESTR("file_name")
			Result.append (Olechar)
			Result.append (Space)
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append (Olestr)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (shared_wizard_environment.type_library_file_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- HRESULT tmp_hr = LoadTypeLib (&tmp_value, pTypeLib)
			Result.append (Hresult)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Load_type_lib)
			Result.append (Space_open_parenthesis)
			Result.append (Ampersand)
			Result.append (Tmp_variable_name)
			Result.append (Comma_space)
			Result.append (Ampersand)
			Result.append (Type_lib_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

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
			Result.append (Return)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (semicolon)
			Result.append (New_line_tab)
			Result.append (Close_curly_brace)
			Result.append (New_line_tab)

			-- tmm_hr = pTypeLib->GetTypeInfoOfGuid (guid, pTypeInfo)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Type_lib_variable_name)
			Result.append (Struct_selection_operator)
			Result.append (Get_type_info_of_guid)
			Result.append (Space_open_parenthesis)
			Result.append (Ampersand)
			Result.append (Clsid_type)
			Result.append (Underscore)
			Result.append (coclass_descriptor.c_type_name)
			Result.append (Comma_space)
			Result.append (Ampersand)
			Result.append (Type_info_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- If (FAILED(tmp_hr))
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Open_parenthesis)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (Return)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (Hresult_variable_name)
			Result.append (semicolon)
			Result.append (New_line_tab)			
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
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Interlocked_decrement)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Ampersand)
			tmp_body.append (Ref_count)
			tmp_body.append (Close_parenthesis)
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
