indexing
	description: "Objects that generate class object code for coclasses"
	status: " See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CLASS_OBJECT_GENERATOR

inherit
	WIZARD_CPP_WRITER_GENERATOR

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Access

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate class object.
		local
			a_name, a_header_file_name, a_header: STRING
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			coclass_descriptor := a_descriptor

			create cpp_class_writer.make

			create a_name.make (1000)
			a_name.append (coclass_descriptor.c_type_name)
			a_name.append (Underscore)
			a_name.append (Factory)
			cpp_class_writer.set_name (a_name)

			create a_header_file_name.make (100)
			a_header_file_name.append (a_name)
			a_header_file_name.append (Header_file_extension)
			cpp_class_writer.set_header_file_name (a_header_file_name)

			-- Description
			create a_header.make (1000)
			a_header.append (coclass_descriptor.c_type_name)
			a_header.append (Space)
			a_header.append (Factory)
			cpp_class_writer.set_header (a_header)

			-- Import/include header file
			cpp_class_writer.add_import (coclass_descriptor.c_header_file_name)

			-- Parent
			cpp_class_writer.add_parent (Class_factory, Void, Public)

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

			-- Initialize
			cpp_class_writer.add_function (initialize_feature, Public)

			-- IsInitialized
			cpp_class_writer.add_member (is_initialized_member, Public)

			-- Extern functions
			cpp_class_writer.add_other (Extern_lock_module)
			cpp_class_writer.add_other (Extern_unlock_module)

			-- Member
			create member_writer.make
			member_writer.set_name (Type_id)
			member_writer.set_result_type (Eif_type_id)
			member_writer.set_comment ("Component class id")
			cpp_class_writer.add_member (member_writer, Private)

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
		local
			tmp_body: STRING 
		do
			create Result.make
			create tmp_body.make (1000)
			tmp_body.append (Tab)
			tmp_body.append ("IsInitialized")
			tmp_body.append (Space_equal_space)
			tmp_body.append (Zero)
			tmp_body.append (Semicolon)

			Result.set_body(tmp_body)
		end

	is_initialized_member: WIZARD_WRITER_C_MEMBER is
			-- is_initialized member.
		do
			create Result.make

			Result.set_name ("IsInitialized")
			Result.set_result_type ("BOOL")
			Result.set_comment ("Is initialized?")
		end

	initialize_feature: WIZARD_WRITER_C_FUNCTION is
			-- Initialize feature.
		local
			tmp_body: STRING 
		do
			create Result.make

			Result.set_name ("Initialize")
			Result.set_comment ("Initialize")
			Result.set_result_type (Void_c_keyword)

			create tmp_body.make (1000)
			tmp_body.append (Tab)
			tmp_body.append (Type_id)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Eif_type_id_function_name)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			
			tmp_body.append (implemented_coclass_name (coclass_descriptor.eiffel_class_name))
			
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append ("IsInitialized")
			tmp_body.append (Space_equal_space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Type_id)
			tmp_body.append (Space)
			tmp_body.append (More)
			tmp_body.append (Equal_sign)
			tmp_body.append (Space)
			tmp_body.append (Zero)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)

			Result.set_body(tmp_body)
		end

	lock_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- LoackServer feature
		local
			a_signature, tmp_body: STRING
		do
			create Result.make
			Result.set_name ("LockServer")
			Result.set_comment ("Lock Server")
			Result.set_result_type (Std_method_imp)

			create a_signature.make (100)
			a_signature.append (Bool)
			a_signature.append (Space)
			a_signature.append (Tmp_variable_name)
			Result.set_signature (a_signature)

			create tmp_body.make (1000)
			tmp_body.append (Tab)
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

			create tmp_body.make (10000)
			tmp_body.append (Tab)
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
			if 
				coclass_descriptor.namespace /= Void and then
				not coclass_descriptor.namespace.empty
			then
				tmp_body.append (coclass_descriptor.namespace)
				tmp_body.append ("::")
			end
			tmp_body.append (coclass_descriptor.c_type_name)
			tmp_body.append (Space)
			tmp_body.append (Asterisk)
			tmp_body.append (Tmp_object_pointer)
			tmp_body.append (Space_equal_space)
			tmp_body.append (New)
			tmp_body.append (Space)
			if 
				coclass_descriptor.namespace /= Void and then
				not coclass_descriptor.namespace.empty
			then
				tmp_body.append (coclass_descriptor.namespace)
				tmp_body.append ("::")
			end
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

			create tmp_body.make (10000)
			tmp_body.append (Tab)
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

			create tmp_body.make (10000)
			tmp_body.append (Tab)

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

			create tmp_body.make (10000)
			tmp_body.append (Tab)

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
