indexing
	description: "Objects that generate class object code for coclasses"
	status: " See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CLASS_OBJECT_GENERATOR

inherit
	WIZARD_CPP_WRITER_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_FILE_NAME_FACTORY
		rename
			create_file_name as factory_create_file_name
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
			l_name, l_header_file_name, l_header: STRING
			l_writer: WIZARD_WRITER_C_MEMBER
		do
			coclass_descriptor := a_descriptor

			create cpp_class_writer.make

			create l_name.make (1000)
			l_name.append (coclass_descriptor.c_type_name)
			l_name.append ("_factory")
			cpp_class_writer.set_name (l_name)

			create l_header_file_name.make (100)
			l_header_file_name.append (l_name)
			l_header_file_name.append (".h")
			cpp_class_writer.set_definition_header_file_name (l_header_file_name)
			cpp_class_writer.set_declaration_header_file_name (declaration_header_file_name (l_header_file_name))

			-- Description
			create l_header.make (1000)
			l_header.append (coclass_descriptor.c_type_name)
			l_header.append (" factory")
			cpp_class_writer.set_header (l_header)

			-- Import/include header file
			cpp_class_writer.add_import (coclass_descriptor.c_definition_header_file_name)

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
			create l_writer.make
			l_writer.set_name (Type_id)
			l_writer.set_result_type (Eif_type_id)
			l_writer.set_comment ("Component class id")
			cpp_class_writer.add_member (l_writer, Private)

			-- Generate code and save name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_declaration_header_file (Shared_file_name_factory.last_created_declaration_header_file_name)
			cpp_class_writer.save_definition_header_file (Shared_file_name_factory.last_created_header_file_name)
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
			Result.set_body ("%TIsInitialized = 0;")
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
			l_body: STRING 
		do
			create Result.make

			Result.set_name ("Initialize")
			Result.set_comment ("Initialize")
			Result.set_result_type ("void")
			create l_body.make (1000)
			l_body.append ("%Ttype_id = eif_type_id (%"")
			l_body.append (implemented_coclass_name (coclass_descriptor.eiffel_class_name))
			l_body.append ("%");%R%N%TIsInitialized = (type_id >= 0);")
			Result.set_body (l_body)
		end

	lock_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- LoackServer feature
		do
			create Result.make
			Result.set_name ("LockServer")
			Result.set_comment ("Lock Server")
			Result.set_result_type (Std_method_imp)
			Result.set_signature ("BOOL tmp_value")
			Result.set_body ("%Tif (tmp_value)%R%N%T%TLockModule ();%R%N%Telse%R%N%T%TUnlockModule ();%R%N%Treturn S_OK;")
		end

	create_instance_feature: WIZARD_WRITER_C_FUNCTION is
			-- CreateInstance of class factory
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name ("CreateInstance")
			Result.set_comment ("Create Instance")
			Result.set_result_type ("STDMETHODIMP")
			Result.set_signature ("IUnknown *pIunknown, REFIID riid, void **ppv")
			create l_body.make (10000)
			l_body.append ("%Tif (ppv == 0)%R%N%T%T")
			l_body.append ("return E_POINTER;%R%N%T")
			l_body.append ("*ppv = 0;%R%N%T")
			l_body.append ("if (pIunknown)%R%N%T%T")
			l_body.append ("return CLASS_E_NOAGGREGATION;%R%N")
			if coclass_descriptor.namespace /= Void and then not coclass_descriptor.namespace.is_empty then
				l_body.append (coclass_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (coclass_descriptor.c_type_name)
			l_body.append (" *pUnknown = new ")
			if coclass_descriptor.namespace /= Void and then not coclass_descriptor.namespace.is_empty then
				l_body.append (coclass_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (coclass_descriptor.c_type_name)
			l_body.append ("(type_id);%R%N%T")
			l_body.append ("if (!pUnknown)%R%N%T%T")
			l_body.append ("return E_OUTOFMEMORY;%R%N%T")
			l_body.append ("pUnknown->AddRef ();%R%N%T")
			l_body.append ("HRESULT tmp_hr = pUnknown->QueryInterface (riid, ppv);%R%N%T")
			l_body.append ("pUnknown->Release ();%R%N%T")
			l_body.append ("return tmp_hr;")
			Result.set_body (l_body)
		end

	query_interface_feature: WIZARD_WRITER_C_FUNCTION is
			-- QueryInterface of class factory
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (Query_interface)
			Result.set_comment ("Query Interface")
			Result.set_result_type (Std_method_imp)
			Result.set_signature (Query_interface_signature)
			create l_body.make (260)
			l_body.append ("%Tif (riid == IID_IClassFactory)%R%N%T%T")
			l_body.append ("*ppv = static_cast<IClassFactory*>(this);%R%N%T")
			l_body.append ("else if (riid == IID_IUnknown)%R%N%T%T")
			l_body.append ("*ppv = static_cast<IClassFactory*>(this);%R%N%T")
			l_body.append ("else%R%N%T%T")
			l_body.append ("return (*ppv = 0), E_NOINTERFACE;%R%N%T")
			l_body.append ("reinterpret_cast<IUnknown *>(this)->AddRef ();%R%N%T")
			l_body.append ("return S_OK;")
			Result.set_body (l_body)
		end

	release_feature: WIZARD_WRITER_C_FUNCTION is
			-- Release of class factory
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name ("Release")
			Result.set_comment ("Decrement reference count")
			Result.set_result_type ("STDMETHODIMP_(ULONG)")
			create l_body.make (10000)
			l_body.append ("%T")
			if environment.is_in_process then
				l_body.append ("UnlockModule ();%R%N%T")
			end
			l_body.append ("return 1;")
			Result.set_body (l_body)
		end

	addref_feature: WIZARD_WRITER_C_FUNCTION is
			-- Addref of class factory
		local	
			l_body: STRING
		do
			create Result.make
			Result.set_name ("AddRef")
			Result.set_comment ("Increment reference count")
			Result.set_result_type ("STDMETHODIMP_(ULONG)")
			create l_body.make (10000)
			l_body.append ("%T")
			if environment.is_in_process then
				l_body.append ("LockModule ();%R%N%T")
			end
			l_body.append ("return 2;")
			Result.set_body (l_body)
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
