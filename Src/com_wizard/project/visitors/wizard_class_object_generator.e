indexing
	description: "Objects that generate class object code for coclasses"
	status: " See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CLASS_OBJECT_GENERATOR

inherit
	WIZARD_CPP_WRITER_GENERATOR

feature -- Initialization

	initialize is
			-- Initialize.
		do
			cpp_class_writer := Void
			coclass_descriptor := Void
			coclass_guid := Void
			type_library_name := Void
		ensure
			void_class_writer: cpp_class_writer = Void
			void_coclass_descriptor: coclass_descriptor = Void
			void_coclass_guid: coclass_guid = Void
			void_type_library_name: type_library_name = Void
		end

feature -- Access

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor

	coclass_guid: STRING
			-- Coclass's guid in string format

	type_library_name: STRING
			-- Name of type library the coclass is in

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate class object.
		local
			tmp_string: STRING
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			coclass_descriptor := a_descriptor

			coclass_guid := clone (coclass_descriptor.guid.to_string)

			type_library_name := coclass_descriptor.type_library_descriptor.name

			create cpp_class_writer.make

			tmp_string := clone (coclass_descriptor.c_type_name)
			tmp_string.append (Factory)
			cpp_class_writer.set_name (tmp_string)

			tmp_string := clone (tmp_string)
			tmp_string.append (Header_file_extension)
			cpp_class_writer.set_header_file_name (tmp_string)

			-- Description
			tmp_string := clone (coclass_descriptor.c_type_name)
			tmp_string.append (Space)
			tmp_string.append (Factory)
			cpp_class_writer.set_header (tmp_string)

			-- Import/include header file
			cpp_class_writer.add_import (coclass_descriptor.c_header_file_name)

			-- Parent
			cpp_class_writer.add_parent (Class_factory, Public)

			-- AddRef
			cpp_class_writer.add_function (addref_feature, Public)

			-- Release
			cpp_class_writer.add_function (release_feature, Public)

			-- QueryInterface
			cpp_class_writer.add_function (query_interface_feature, Public)

			-- CreateInstance
			cpp_class_writer.add_function (create_instance_feature, Public)

			-- LockServer
			cpp_class_writer.add_function (lock_server_feature, Public)

			-- Constructor
			cpp_class_writer.add_constructor (constructor)

			-- Extern functions
			cpp_class_writer.add_other (Extern_lock_module)
			cpp_class_writer.add_other (Extern_unlock_module)
			cpp_class_writer.add_other (reg_data_struct)
			cpp_class_writer.add_other (registry_entries_data)
			tmp_string := clone (Const)
			tmp_string.append (Space)
			tmp_string.append (Int)
			tmp_string.append (Space)
			tmp_string.append (Component_entries_count)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Sizeof)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Registry_entries_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append ("/")
			tmp_string.append (Sizeof)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Asterisk)
			tmp_string.append (Registry_entries_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			cpp_class_writer.add_other (tmp_string)

			-- Member
			create member_writer.make
			member_writer.set_name (Type_id)
			member_writer.set_result_type (Eif_type_id)
			member_writer.set_comment ("Component class id")
			cpp_class_writer.add_member (member_writer, Private)

			-- Global variables

			-- member (TCHAR file_name[MAX_PATH])
			create member_writer.make
			member_writer.set_name ("file_name[MAX_PATH]")
			member_writer.set_result_type (Tchar_type)
			member_writer.set_comment ("File name")
			cpp_class_writer.add_global_variable (member_writer)

			-- member (OLECHAR ws_file_name[MAX_PATH])
			create member_writer.make
			member_writer.set_name ("ws_file_name[MAX_PATH]")
			member_writer.set_result_type (Olechar)
			member_writer.set_comment ("Wide string file name")
			cpp_class_writer.add_global_variable (member_writer)


			create member_writer.make
			member_writer.set_name (Class_object_variable_name)

			tmp_string := clone (coclass_descriptor.c_type_name)
			tmp_string.append (Factory)

			member_writer.set_result_type (tmp_string)
			member_writer.set_comment ("Class object")
			cpp_class_writer.add_global_variable (member_writer)

			cpp_class_writer.add_extern_function (unregister_feature)
			cpp_class_writer.add_extern_function (register_feature)

			if shared_wizard_environment.in_process_server then
				cpp_class_writer.add_extern_function (dll_get_class_object_feature)
				cpp_class_writer.add_extern_function (dll_register_server_feature)
				cpp_class_writer.add_extern_function (dll_unregister_server_feature)
				cpp_class_writer.add_extern_function (dll_can_unload_now_feature)
				cpp_class_writer.add_extern_function (dll_unlock_module_feature)
				cpp_class_writer.add_extern_function (dll_lock_module_feature)
				cpp_class_writer.add_function (set_type_id_feature, Public)

				create member_writer.make
				member_writer.set_name (Locks_variable_name)
				member_writer.set_result_type (Long)
				member_writer.set_comment ("Locks counter")
				cpp_class_writer.add_global_variable (member_writer)
			else
				
				cpp_class_writer.add_other ("DWORD threadID = GetCurrentThreadID ();")
				cpp_class_writer.add_extern_function (initialization_feature)
				cpp_class_writer.add_extern_function (exe_lock_module_feature)
				cpp_class_writer.add_extern_function (exe_unlock_module_feature)
			end

			-- Change header file name to generate file

			tmp_string := clone (a_descriptor.c_type_name)
			tmp_string.append (Factory)
			tmp_string.append (Header_file_extension)
			tmp_string.to_lower
			a_descriptor.set_c_header_file_name (tmp_string)

			-- Generate code and save name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
		end

	create_file_name (a_file_name_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Get file name.
		do
			a_file_name_factory.process_class_object
		end

feature {NONE} -- Implementations

	constructor: WIZARD_WRITER_CPP_CONSTRUCTOR is
			--  Constructor of class factory
		do
			create Result.make
			Result.set_body("")
			Result.set_signature (Void_type)
		end

	dll_specific_registry_entries: STRING is
			-- Dll specific registry entries
		require
			non_void_guid: coclass_guid /= Void
			valid_guid: not coclass_guid.empty
		local
			tmp_string: STRING
		do
			tmp_string := clone (Clsid_type)
			tmp_string.append (Registry_field_seperator)
			tmp_string.append (coclass_guid)
			tmp_string.append (Registry_field_seperator)
			tmp_string.append (Inproc_server32)

			Result := struct_creator (tchar_creator (tmp_string), Zero, Module_file_name, C_true)
		end

	application_specific_registry_entries: STRING is 
			-- Application specific registry entries
		require
			non_void_guid: coclass_guid /= Void
			valid_guid: not coclass_guid.empty
			non_void_name: coclass_descriptor.name /= Void
			valid_coclass_name: not coclass_descriptor.name.empty
		local
			string_one, string_two: STRING
		do
			string_one := clone (Appid)
			string_one.append (Registry_field_seperator)
			string_one.append (coclass_guid)

			string_two := clone (Double_quote)
			string_two.append (coclass_descriptor.name)
			string_two.append (Space)
			string_two.append ("Application")
			string_two.append (Double_quote)

			Result := struct_creator (tchar_creator (string_one), Zero, string_two, C_true)
			Result.append (Comma)
			Result.append (New_line_tab)

			string_one := clone (Appid)
			string_one.append (Registry_field_seperator)
			string_one.append (Shared_wizard_environment.project_name)

			Result.append (struct_creator (tchar_creator (string_one), tchar_creator (Appid), tchar_creator (coclass_guid), C_true))
 			Result.append (Comma)
			Result.append (New_line_tab)

			string_one := clone (Clsid_type)
			string_one.append (Registry_field_seperator)
			string_one.append (coclass_guid)
			string_one.append (Registry_field_seperator)
			string_one.append (Local_server32)

			Result.append (struct_creator (tchar_creator (string_one), Zero, Module_file_name, C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_one := clone (Clsid_type)
			string_one.append (Registry_field_seperator)
			string_one.append (coclass_guid)

			Result.append (struct_creator (tchar_creator (string_one), tchar_creator (Appid), tchar_creator (coclass_guid), C_true))
		end

	tchar_creator (value: STRING): STRING is
			-- Tchar creator
		require
			non_void_string: value /= Void
		do
			Result := clone (Tchar_creation_function)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (value)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
		end

	registry_entries_data: STRING is
			-- Registry entries for both dll and application
		require
			non_void_guid: coclass_guid /= Void
			valid_guid: not coclass_guid.empty
			non_void_name: coclass_descriptor.name /= Void
			valid_coclass_name: not coclass_descriptor.name.empty
			non_void_library_name: type_library_name /= Void
			valid_type_library_name: not type_library_name.empty
		local
			string_one, string_two: STRING
		do
			Result := clone (Const)
			Result.append (Space)
			Result.append (Reg_data)
			Result.append (Space)
			Result.append (Registry_entries_variable_name)
			Result.append (Open_bracket)
			Result.append (Close_bracket)
			Result.append (Space_equal_space)
			Result.append (New_line)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab)

			string_one := clone (Clsid_type)
			string_one.append (Registry_field_seperator)
			string_one.append (coclass_guid)

			string_two := clone (coclass_descriptor.name)
			string_two.append (Space)
			string_two.append ("Class")

			Result.append (struct_creator (tchar_creator (string_one), Zero, tchar_creator (string_two), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			if shared_wizard_environment.in_process_server then
				Result.append (dll_specific_registry_entries)
			else
				Result.append (application_specific_registry_entries)
			end
			Result.append (Comma)
			Result.append (New_line_tab)

			string_one := clone (Clsid_type)
			string_one.append (Registry_field_seperator)
			string_one.append (coclass_guid)				
			string_one.append (Registry_field_seperator)
			string_one.append (Prog_id)

			string_two := clone (type_library_name)
			string_two.append (Dot)
			string_two.append (coclass_descriptor.name)
			string_two.append (Dot)
			string_two.append (One)

			Result.append (struct_creator (tchar_creator (string_one), Zero, tchar_creator (string_two), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_one := clone (Clsid_type)
			string_one.append (Registry_field_seperator)
			string_one.append (coclass_guid)
			string_one.append (Registry_field_seperator)
			string_one.append (Version_independent_prog_id)

			string_two := clone (type_library_name)
			string_two.append (Dot)
			string_two.append (coclass_descriptor.name)

			Result.append (struct_creator (tchar_creator (string_one), Zero, tchar_creator (string_two), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_two.append (Dot)
			string_two.append (One)

			Result.append (struct_creator (tchar_creator (string_two), Zero, tchar_creator (coclass_descriptor.name), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_two.append (Registry_field_seperator)
			string_two.append (Clsid_type)

			Result.append (struct_creator (tchar_creator (string_two), Zero, tchar_creator (coclass_guid), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_one := clone (type_library_name)
			string_one.append (Dot)
			string_one.append (coclass_descriptor.name)

			Result.append (struct_creator (tchar_creator (string_one), Zero, tchar_creator (coclass_descriptor.name), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_two := clone (string_one)
			string_two.append (Registry_field_seperator)
			string_two.append (Clsid_type)

			Result.append (struct_creator (tchar_creator (string_two), Zero, tchar_creator (coclass_guid), C_true))
			Result.append (Comma)
			Result.append (New_line_tab)

			string_two := clone (string_one)
			string_one.append (Registry_field_seperator)
			string_one.append (Current_version)

			string_two.append (Dot)
			string_two.append (One)

			Result.append (struct_creator (tchar_creator (string_one), Zero, tchar_creator (string_two), C_true))
			Result.append (Comma)
			Result.append (New_line)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		end

	struct_creator (first_field, second_field, third_field, forth_field: STRING): STRING is
			-- Reg data struct creator
		do
			Result := clone (Open_curly_brace)
			Result.append (New_line_tab_tab)
			Result.append (first_field)
			Result.append (Comma)
			Result.append (New_line_tab_tab)
			Result.append (second_field)
			Result.append (Comma)
			Result.append (New_line_tab_tab)
			Result.append (third_field)
			Result.append (Comma)
			Result.append (New_line_tab_tab)
			Result.append (forth_field)
			Result.append (New_line_tab)
			Result.append (Close_curly_brace)
		end

	lock_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- LoackServer feature
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name ("LockServer")
			Result.set_comment ("Lock Server")
			Result.set_result_type (Std_method_imp)

			tmp_body := clone (Bool)
			tmp_body.append (Space)
			tmp_body.append (Tmp_variable_name)
			Result.set_signature (tmp_body)

			tmp_body := clone (Tab)
			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Tmp_variable_name)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Lock_module_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Else_keyword)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Unlock_module_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (S_ok)
			tmp_body.append (Semicolon)

			Result.set_body (tmp_body)
		end

	create_instance_feature: WIZARD_WRITER_C_FUNCTION is
			-- CreateInstance of class factory
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name ("CreateInstance")
			Result.set_comment ("Create Instance")
			Result.set_result_type (Std_method_imp)
			Result.set_signature ("IUnknown *pIunknown, REFIID riid, void **ppv")

			tmp_body := clone (Tab)
			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append ("ppv")
			tmp_body.append (C_equal)
			tmp_body.append (Zero)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (E_pointer)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Zero)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append ("pIunknown")
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Class_e_noaggregation)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (coclass_descriptor.c_type_name)
			tmp_body.append (Space)
			tmp_body.append (Asterisk)
			tmp_body.append (Tmp_object_pointer)
			tmp_body.append (Space_equal_space)
			tmp_body.append (New)
			tmp_body.append (Space)
			tmp_body.append (coclass_descriptor.c_type_name)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Type_id)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append ("!")
			tmp_body.append (Tmp_object_pointer)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (E_out_of_memory)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Tmp_object_pointer)
			tmp_body.append (Add_reference_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Hresult)
			tmp_body.append (Space)
			tmp_body.append (Tmp_clause)
			tmp_body.append (Hresult_variable_name)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Tmp_object_pointer)
			tmp_body.append (Struct_selection_operator)
			tmp_body.append (Query_interface)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (Comma_space)
			tmp_body.append ("ppv")
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Tmp_object_pointer)
			tmp_body.append (Release_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Hresult_variable_name)

			Result.set_body (tmp_body)
		end

	query_interface_feature: WIZARD_WRITER_C_FUNCTION is
			-- QueryInterface of class factory
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Query_interface)
			Result.set_comment ("Query Interface")
			Result.set_result_type (Std_method_imp)
			Result.set_signature (Query_interface_signature)

			tmp_body:= clone (Tab)
			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (C_equal)
			tmp_body.append (Iid_type)
			tmp_body.append (Underscore)
			tmp_body.append (Class_factory)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Static_cast)
			tmp_body.append (Less)
			tmp_body.append (Class_factory)
			tmp_body.append (Asterisk)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (This)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Else_if)
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
			tmp_body.append (class_factory)
			tmp_body.append (Asterisk)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (This)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Else_keyword)
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
			tmp_body.append (New_line_tab)
			tmp_body.append (Reinterpret_cast)
			tmp_body.append (Less)
			tmp_body.append (Iunknown)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (this)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Add_reference_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return_s_ok)

			Result.set_body (tmp_body)
		end

	release_feature: WIZARD_WRITER_C_FUNCTION is
			-- Release of class factory
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name ("Release")
			Result.set_comment ("Decrement reference count")
			Result.set_result_type (Ulong_std_method_imp)

			tmp_body := clone (Tab)

			if shared_wizard_environment.in_process_server then
				tmp_body.append ("UnlockModule ();")
				tmp_body.append (New_line_tab)
			end

			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (One)
			tmp_body.append (Semicolon)

			Result.set_body (tmp_body)
		end

	addref_feature: WIZARD_WRITER_C_FUNCTION is
			-- Addref of class factory
		local	
			tmp_body: STRING
		do
			create Result.make
			Result.set_name ("AddRef")
			Result.set_comment ("Increment reference count")
			Result.set_result_type (Ulong_std_method_imp)

			tmp_body := clone (Tab)

			if shared_wizard_environment.in_process_server then
				tmp_body.append ("LockModule ();")
				tmp_body.append (New_line_tab)
			end
			tmp_body.append (Return)
			tmp_body.append (" 2;")
			Result.set_body (tmp_body)
		end

	Initialization_feature: WIZARD_WRITER_C_FUNCTION is
			-- Administration function to register or unregister server
			-- Only generated if is outproc server
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name ("ccom_initialize")
            Result.set_comment ("Initialize")
			Result.set_result_type (Void_c_keyword)

			tmp_string := clone (Eif_type_id)
			tmp_string.append (Space)
			tmp_string.append (Type_id_variable_name)
			tmp_string.append (Comma_space)
			tmp_string.append (Char)
			tmp_string.append (Space)
			tmp_string.append (Option_variable_name)

			Result.set_signature (tmp_string)

			-- HRESULT hr = CoInitialize (0)
			tmp_string := clone (Tab)
			tmp_string.append (Type_id)
			tmp_string.append (Space_equal_space)
			tmp_string.append (type_id_variable_name)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line)
			tmp_string.append (New_line_tab)
			tmp_string.append (Hresult)
			tmp_string.append (Space)
			tmp_string.append (Hresult_variable_name)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Co_initialize)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)

			-- if ('option_variable_name' == 'register_server_option')
			tmp_string.append (If_keyword)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Option_variable_name)
			tmp_string.append (C_equal)
			tmp_string.append (Register_server_option)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (New_line_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Module_file_name_set_up)

			-- Register ('Component_entries', 'component_entries_count')
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Register)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Registry_entries_variable_name)
			tmp_string.append (Comma_space)
			tmp_string.append (Component_entries_count)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			-- CoUninitialize ();
			-- return;
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Co_uninitialize_function)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Return)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (New_line_tab)
			tmp_string.append (Close_curly_brace)

			-- else if ('option_variable_name' == 'unregister_server_option')
			tmp_string.append (New_line_tab)
			tmp_string.append (Else_if)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Option_variable_name)
			tmp_string.append (C_equal)
			tmp_string.append (Unregister_server_option)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (New_line_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab)

			-- Unregister ('Component_entries', 'component_entries_count')
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Unregister)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Registry_entries_variable_name)
			tmp_string.append (Comma_space)
			tmp_string.append (Component_entries_count)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			-- CoUninitialize ()
			-- return
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Co_uninitialize_function)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Return)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)
			tmp_string.append (Close_curly_brace)

			-- DWORD 'class_object_registration_token'
			-- hr = CoRegisterClassObject ('Class_id', static_case<IClassFactory*> ('class_object'),
			-- CLSCTX_LOCAL_SERVER, REGCLS_MULTIPLEUSER, &'class_object_registration_token')
			-- ** Allow the implementors to choice between REGCLS_SINGLEUSE or REGCLS_MULTIPLEUSE later.

			tmp_string.append (New_line_tab)
			tmp_string.append (Dword)
			tmp_string.append (Space)
			tmp_string.append (Class_object_registration_token)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)
			tmp_string.append (Hresult_variable_name)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Co_register_class_object)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Clsid_type)
			tmp_string.append (Underscore)
			tmp_string.append (coclass_descriptor.c_type_name)
			tmp_string.append (Comma_space)
			tmp_string.append (Static_cast)
			tmp_string.append (Less)
			tmp_string.append (Class_factory)
			tmp_string.append (Asterisk)
			tmp_string.append (More)
			tmp_string.append (Open_parenthesis)
			tmp_string.append (Ampersand)
			tmp_string.append (Class_object_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Comma_space)
			tmp_string.append (Clsctx_local_server)
			tmp_string.append (Comma_space)
			tmp_string.append (Regcls_multiple_use)
			tmp_string.append (Comma_space)
			tmp_string.append (Ampersand)
			tmp_string.append (Class_object_registration_token)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)

			-- if (SUCCEEDED (hr))
			tmp_string.append (If_keyword)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Succeeded)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Hresult_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (New_line_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab)

			-- MSG msg;
			-- while (GetMessage (&msg, 0, 0, 0))
			--  DispatchMessage (&msg)
			tmp_string.append ("MSG")
			tmp_string.append (Space)
			tmp_string.append (Message_variable_name)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (While)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Get_message)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Ampersand)
			tmp_string.append (Message_variable_name)
			tmp_string.append (Comma_space)
			tmp_string.append (Zero)
			tmp_string.append (Comma_space)
			tmp_string.append (Zero)
			tmp_string.append (Comma_space)
			tmp_string.append (Zero)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append (Dispatch_message)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Ampersand)
			tmp_string.append (Message_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Co_revoke_class_object)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Class_object_registration_token)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab)
			tmp_string.append (Co_uninitialize_function)
			tmp_string.append (New_line_tab)
			tmp_string.append (Return)
			tmp_string.append (Space)
			tmp_string.append (Hresult_variable_name)
			tmp_string.append (Semicolon)

			Result.set_body (tmp_string)
		end

	dll_get_class_object_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllGetClassObject code
		local
			tmp_string: STRING
		do
			create Result.make

			tmp_string := clone (Ccom_clause)
			tmp_string.append (Get_class_object_function_name)

			Result.set_name (tmp_string)
			Result.set_comment ("DLL get class object funcion")
			Result.set_result_type (Std_api)
			Result.set_signature ("EIF_TYPE_ID tid, REFCLASOD rclsid, REFIID riid, void **ppv")

			tmp_string := clone (Tab)
			-- type_id := tid;

			tmp_string.append (Type_id)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Type_id_variable_name)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)
			tmp_string.append (If_keyword)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append ("rclsid == CLSID_")
			tmp_string.append (coclass_descriptor.c_type_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Return)
			tmp_string.append (Space)
			tmp_string.append (Class_object_variable_name)
			tmp_string.append (Dot)
			tmp_string.append (Query_interface)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Riid)
			tmp_string.append (Comma_space)
			tmp_string.append ("ppv")
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab)
			tmp_string.append (Else_keyword)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Return)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Star_ppv)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Zero)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Comma_space)
			tmp_string.append (Class_e_class_not_available)
			tmp_string.append (Semicolon)

			Result.set_body (tmp_string)
		end

	module_file_name_set_up: STRING is
			-- Code to set up module file name
		do
			-- GetModuleFileName (Null, file_name, MAX_PATH)
			Result := clone (Get_module_file_name)
			Result.append (Space_open_parenthesis)
			Result.append (Null)
			Result.append (Comma_space)
			Result.append (Module_file_name)
			Result.append (Comma_space)
			Result.append (Max_path)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)

			-- #ifdef UNICODE
			Result.append (New_line)
			Result.append (Hash_if_def)
			Result.append (Space)
			Result.append (Unicode)
			Result.append (New_line_tab)

			-- lstrcpy ('wide_string_module_file_name', 'module_file_name')
			Result.append (Unicode_string_copy_function)
			Result.append (Space_open_parenthesis)
			Result.append (Wide_string_module_file_name)
			Result.append (Comma_space)
			Result.append (Module_file_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)

			-- #else
			Result.append (New_line)
			Result.append (Hash_else)

			-- mbstowcs ('wide_string_module_file_name', 'module_file_name', MAX_PATH)
			Result.append (New_line_tab)
			Result.append (Non_unicode_string_copy_function)
			Result.append (Space_open_parenthesis)
			Result.append (Wide_string_module_file_name)
			Result.append (Comma_space)
			Result.append (Module_file_name)
			Result.append (Comma_Space)
			Result.append ("MAX_PATH")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)

			-- #endif
			Result.append (New_line)
			Result.append (Hash_end_if)
			
		end

	dll_register_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllRegisterServer
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Register_dll_server_function_name)
			Result.set_comment ("Register DLL server.")
			Result.set_result_type (Std_api)
			Result.set_signature (Void_c_keyword)

			-- Set up module file name
			tmp_body := clone (Tab)
			tmp_body.append (module_file_name_set_up)

			-- return Register ('Component_entries', 'component_entries_count')
			tmp_body.append (New_line_tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Register)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Registry_entries_variable_name)
			tmp_body.append (Comma_space)
			tmp_body.append (Component_entries_count)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			Result.set_body (tmp_body)
		end

	set_type_id_feature: WIZARD_WRITER_C_FUNCTION is
			-- Code to setup set_type_id feature
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name (Set_type_id_function_name)
			Result.set_comment ("Set type id.")
			Result.set_result_type (Void_c_keyword)

			Result.set_signature ("EIF_TYPE_ID tid")

			tmp_string := clone (Tab)
			tmp_string.append (Type_id)
			tmp_string.append (Space_equal_space)
			tmp_string.append (Type_id_variable_name)
			tmp_string.append (Semicolon)

			Result.set_body (tmp_string)
	end

	dll_unregister_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllUnregisterServer
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Unregister_dll_server_function_name)
			Result.set_comment ("Unregister Server.")
			Result.set_result_type (Std_api)
			Result.set_signature (Void_c_keyword)

			tmp_body := clone (Tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append ("Unregister")
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Registry_entries_variable_name)
			tmp_body.append (Comma_space)
			tmp_body.append (Component_entries_count)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			Result.set_body (tmp_body)
		end

	dll_can_unload_now_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllCanUnloadNow function
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Can_unload_dll_now_function_name)
			Result.set_comment ("Whether component can be unloaded?")
			Result.set_result_type (Std_api)
			Result.set_signature (Void_c_keyword)

			tmp_body := clone (Tab)
			tmp_body.append (Return)
			tmp_body.append (Space)
			tmp_body.append (Locks_variable_name)
			tmp_body.append ("? ")
			tmp_body.append (S_false)
			tmp_body.append (Colon)
			tmp_body.append (Space)
			tmp_body.append (S_ok)
			tmp_body.append (Semicolon)

			Result.set_body (tmp_body)
		end

	exe_lock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- Exe implementation of LockModule
		do
			create Result.make
			Result.set_name ("LockModule")
			Result.set_comment ("Lock module.")
			Result.set_result_type (Void_c_keyword)
			Result.set_signature (Void_c_keyword)

			Result.set_body ("%TCoAddRefServerProcess ();")
		end

	exe_unlock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- Exe implementation of UnlockModule
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name ("UnlockModule")
			Result.set_comment ("Unlock module.")
			Result.set_result_type (Void_c_keyword)
			Result.set_signature (Void_c_keyword)

			tmp_string := "%Tif (CoReleaseServerProcess () == 0)"
			tmp_string.append (New_line_tab_tab)
			tmp_string.append ("PostThreadMessage (threadID, WM_QUIT, 0, 0);")

			Result.set_body (tmp_string)
		end

	dll_unlock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- DLL implementation of UnlockModule
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name ("UnlockModule")
			Result.set_comment ("Unlock module.")
			Result.set_result_type (Void_c_keyword)
			Result.set_signature (Void_c_keyword)

			tmp_string := clone (Tab)
			tmp_string.append (Interlocked_decrement)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Ampersand)
			tmp_string.append (Locks_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			Result.set_body (tmp_string)
		end

	dll_lock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- DLL implementation of LockModule
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name ("LockModule")
			Result.set_comment ("Lock module.")
			Result.set_result_type (Void_c_keyword)
			Result.set_signature (Void_c_keyword)

			tmp_string := clone (Tab)
			tmp_string.append (Interlocked_increment)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Ampersand)
			tmp_string.append (Locks_variable_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)

			Result.set_body (tmp_string)
		end

	unregister_feature: WIZARD_WRITER_C_FUNCTION is
			-- Code to unregister server/component
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name (Unregister)
			Result.set_comment ("Unregister Server/Component")
			Result.set_result_type (Std_method_imp)
			Result.set_signature ("const REG_DATA *rgEntries, int cEntries")

			-- HRESULT hr = UnregisterTypeLib (LIBID_'library_name', 1,0,0, SYS_WIN32);
			tmp_string := "%THRESULT hr = UnRegisterTypeLib ("
			tmp_string.append (Libid_type)
			tmp_string.append (Underscore)
			tmp_string.append (coclass_descriptor.type_library_descriptor.name)
			tmp_string.append (", 1, 0, 0, SYS_WIN32);")
			tmp_string.append (New_line_tab)

			-- BOOL bSuccess = SUCCEEDED (hr)
			tmp_string.append ("BOOL bSuccess = SUCCEEDED (hr);")
			tmp_string.append (New_line_tab)

			-- for (int i= cEntries -1; i >= 0; i--)
			tmp_string.append ("for (int i= cEntries -1; i >= 0; i--)")
			tmp_string.append (New_line_tab_tab)

			-- if (rgEntries[i].bDeleteOnUnregister)
			tmp_string.append ("if (rgEntries[i].bDeleteOnUnregister)")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab_tab)

			-- LONG err = RegDeleteKey (HKEY_CLASSES_ROOT, rgEntries[i].keyName);
			tmp_string.append ("LONG err = RegDeleteKey (HKEY_CLASSES_ROOT, rgEntries[i].")
			tmp_string.append (Key_name)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab_tab_tab)

			-- if (err != ERROR_SUCCESS)
			--		bSuccess = FALSE
			tmp_string.append ("if (err != ERROR_SUCCESS)")
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append (Tab)
			tmp_string.append ("bSuccess = FALSE;")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab)

			-- return bSuccess ? S_OK : S_FALSE;
			tmp_string.append ("return bSuccess ? S_OK: S_FALSE;")

			Result.set_body (tmp_string)
		end

	register_feature: WIZARD_WRITER_C_FUNCTION is
			-- Code to register server
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_name (Register)
			Result.set_comment ("Register Server")
			Result.set_result_type (Std_method_imp)

			Result.set_signature ("const REG_DATA *rgEntries, int cEntries")

			-- BOOL bSuccess = TRUE;
			-- const REG_DATA *pEntry = rgEntries;

			tmp_string := "%TBOOL bSuccess = TRUE;"
			tmp_string.append (New_line_tab)
			tmp_string.append ("const REG_DATA *pEntry = rgEntries;")
			tmp_string.append (New_line_tab)

			-- while (pEntry < rgEntries + cEntries)
			-- HKEY hkey;
			tmp_string.append ("while (pEntry < rgEntries + cEntries)")
			tmp_string.append (New_line_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append ("HKEY hkey;")
			tmp_string.append (New_line_tab_tab)

			-- LONG err = RegCreateKey (HKEY_CLASSES_ROOT, pEntry->pKeyName, &hkey);
			-- if (err == ERROR_SUCCESS)
			tmp_string.append ("LONG err = RegCreateKey (HKEY_CLASSES_ROOT, pEntry->")
			tmp_string.append (Key_name)
			tmp_string.append (", &hkey);")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append ("if (err == ERROR_SUCCESS)")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab_tab)

			-- if (pEntry->pValue)
			-- err = RegSetValueEx (hkey, pEntry->pValueName, 0, REG_SZ,
			--	(const BYTE*)pEntry->pValue, (lstrlen (pEntry->pValue) + 1) * sizeof (TCHAR));
			tmp_string.append ("if (pEntry->")
			tmp_string.append (Struct_value)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append ("err = RegSetValueEx (hkey, pEntry->")
			tmp_string.append (Key_name)
			tmp_string.append (", 0, REG_SZ, (const BYTE*)pEntry->")
			tmp_string.append (Struct_value)
			tmp_string.append (", (lstrlen (pEntry->")
			tmp_string.append (Struct_value)
			tmp_string.append (") + 1) * sizeof (TCHAR));")
			tmp_string.append (New_line_tab_tab_tab)

			-- if (err != ERROR_SUCCESS)
			-- bSuccess = FALSE;
			-- Unregister (rgEntries, 1 + pEntry - rgEntries);
			-- RegCloseKey (hkey);
			tmp_string.append ("if (err != ERROR_SUCCESS)")
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append (Tab)
			tmp_string.append ("bSuccess = FALSE;")
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append (Tab)
			tmp_string.append ("Unregister (rgEntries, 1 + pEntry - rgEntries);")
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append ("RegCloseKey (hkey);")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab_tab)

			-- if (err != ERROR_SUCCESS)
			-- bSuccess = FALSE;
			tmp_string.append ("if (err != ERROR_SUCCESS)")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append ("bSuccess = FALSE;")
			tmp_string.append (New_line_tab_tab_tab)

			-- if (pEntry != rgEntries)
			-- 	Unregister (rgEntries, pEntry - rgEntries);
			tmp_string.append ("if (pEntry != rgEntries)")
			tmp_string.append (New_line_tab_tab_tab)
			tmp_string.append ("Unregister (rgEntries, pEntry - rgEntries);")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab_tab)

			-- pEntry++;
			tmp_string.append ("pEntry++;")
			tmp_string.append (New_line_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab)

			-- if (!bSuccess)
			--		return E_FAIL;
			tmp_string.append ("if (!bSuccess)")
			tmp_string.append (New_line_tab_tab)
			tmp_string.append ("return E_FAIL;")
			tmp_string.append (New_line)
			tmp_string.append (New_line_tab)

			-- ITypeLIb *ptl = 0;
			-- HRESULT hr = LoadTypeLib ( 'wide_string_module_file_name, &ptl);
			tmp_string.append ("ITypeLib *ptl = 0;")
			tmp_string.append (New_line_tab)
			tmp_string.append ("HRESULT hr = LoadTypeLib (")
			tmp_string.append (Wide_string_module_file_name)
			tmp_string.append (Comma_space)
			tmp_string.append ("&ptl);")
			tmp_string.append (New_line_tab)

			-- if (SUCCEEDED (hr))
			tmp_string.append ("if (SUCCEEDED (hr))")
			tmp_string.append (New_line_tab)
			tmp_string.append (Open_curly_brace)
			tmp_string.append (New_line_tab_tab)

			-- hr = RegisterTypeLib ( ptl, 'wide_string_module_file_name', 0);
			-- ptl->Release ();
			tmp_string.append ("hr = RegisterTypeLib (ptl")
			tmp_string.append (Comma_space)
			tmp_string.append (Wide_string_module_file_name)
			tmp_string.append (Comma_space)
			tmp_string.append (Zero)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (Semicolon)
			tmp_string.append (New_line_tab_tab)
			tmp_string.append ("ptl->Release ();")
			tmp_string.append (New_line_tab)
			tmp_string.append (Close_curly_brace)
			tmp_string.append (New_line_tab)
			tmp_string.append ("return hr;")

			Result.set_body (tmp_string)
		end

	reg_data_struct: STRING is
			-- Structure code
			-- Use add_other
		do
			Result := clone (Struct)
			Result.append (Space)
			Result.append (Reg_data)
			Result.append (New_line)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab)
			Result.append (Const)
			Result.append (Space)
			Result.append (Tchar)
			Result.append (Key_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Const)
			Result.append (Space)
			Result.append (Tchar)
			Result.append (Value_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Const)
			Result.append (Space)
			Result.append (Tchar)
			Result.append (Struct_value)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Bool)
			Result.append (Space)
			Result.append (Delete_on_unregister)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		end

end -- class WIZARD_CLASS_OBJECT_GENERATOR

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
