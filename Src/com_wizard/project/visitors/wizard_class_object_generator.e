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
		ensure
			void_class_writer: cpp_class_writer = Void
			void_coclass_descriptor: coclass_descriptor = Void
		end

feature -- Access

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate class object.
		local
			tmp_string: STRING
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			coclass_descriptor := a_descriptor

			create cpp_class_writer.make

			tmp_string := clone (coclass_descriptor.c_type_name)
			tmp_string.append (Underscore)
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

			if shared_wizard_environment.in_process_server then
				-- Set type id feature
				cpp_class_writer.add_function (set_type_id_feature, Public)
			end

			-- Member
			create member_writer.make
			member_writer.set_name (Type_id)
			member_writer.set_result_type (Eif_type_id)
			member_writer.set_comment ("Component class id")
			cpp_class_writer.add_member (member_writer, Private)

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

	constructor: WIZARD_WRITER_CPP_CONSTRUCTOR is
			--  Constructor of class factory
		do
			create Result.make
			Result.set_body("")
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
			tmp_body.append (Tmp_clause)
			tmp_body.append (Hresult_variable_name)
			tmp_body.append (Semicolon)

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
