indexing
	description: "Source interface C server generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_C_SERVER_GENERATOR

inherit
	WIZARD_SOURCE_INTERFACE_SERVER_GENERATOR
	
	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end

	WIZARD_GUID_GENERATOR
		export
			{NONE} all
		end

	WIZARD_SOURCE_INTERFACE_HELPER
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end
	
create
	generate

feature -- Initialization

	generate (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_coclass_writer: WIZARD_WRITER_CPP_CLASS) is
			-- Generate connection points features and inner class.
		require
			non_void_interface: an_interface /= Void
			non_void_coclass: a_coclass_writer /= Void
		local
			an_inner_class_member: WIZARD_WRITER_C_MEMBER
			coclass_forward_declaration: WIZARD_WRITER_FORWARD_CLASS_DECLARATION
		do
			source_interface := an_interface
			coclass_writer := a_coclass_writer
			create inner_class_writer.make
			
			coclass_writer.add_import (inner_class_header_file)
			inner_class_writer.add_import (source_interface.c_header_file_name)
			
			add_attribute_to_coclass
			coclass_writer.add_other_source (iid_definition (source_interface.name, source_interface.guid))
			
			inner_class_writer.set_name (inner_class_name)
			inner_class_writer.set_header ("To deal with identity relationship of IConnectionPoin,%N" +
				an_interface.c_type_name + "-specific inner class.")
			
			inner_class_writer.set_header_file_name (inner_class_header_file)
			inner_class_writer.add_parent ("IConnectionPoint", Void, Public)
			
			inner_class_writer.add_constructor (inner_class_constructor)
			
			create an_inner_class_member.make
			an_inner_class_member.set_name ("outer")
			an_inner_class_member.set_result_type (coclass_c_type + " *")
			an_inner_class_member.set_comment ("Pointer to coclass.")
			inner_class_writer.add_member (an_inner_class_member, Public)

			create an_inner_class_member.make
			an_inner_class_member.set_name ("eiffel_object")
			an_inner_class_member.set_result_type ("EIF_OBJECT")
			an_inner_class_member.set_comment ("Eiffel object.")
			inner_class_writer.add_member (an_inner_class_member, Private)

			create an_inner_class_member.make
			an_inner_class_member.set_name ("type_id")
			an_inner_class_member.set_result_type ("EIF_TYPE_ID")
			an_inner_class_member.set_comment ("Eiffel object's type ID.")
			inner_class_writer.add_member (an_inner_class_member, Private)
			
			inner_class_writer.add_function (inner_class_query_interface, Public)
			inner_class_writer.add_function (inner_class_add_ref, Public)
			inner_class_writer.add_function (inner_class_release, Public)
			
			inner_class_writer.add_function (inner_class_get_connection_interface, Public)
			inner_class_writer.add_function (inner_class_get_connection_point_container, Public)
			inner_class_writer.add_function (inner_class_advise, Public)
			inner_class_writer.add_function (inner_class_unadvise, Public)
			inner_class_writer.add_function (inner_class_enum_connections, Public)
			
			create coclass_forward_declaration.make (coclass_writer.name, coclass_writer.namespace, False)
			inner_class_writer.add_other (coclass_forward_declaration.generated_code)
			inner_class_writer.add_import_after (coclass_writer.header_file_name)
			inner_class_writer.add_other_source (iid_definition 
						(source_interface.name, source_interface.guid))
			
			-- Generate code and save name.
			Shared_file_name_factory.create_source_inner_class_name  (inner_class_writer)
			inner_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			inner_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
			
		ensure
			non_void_inner_class_writer: inner_class_writer /= Void
		end

feature -- Access

	source_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Source interface descriptor.
			
	inner_class_writer: WIZARD_WRITER_CPP_CLASS
			-- Writer of inner class.

	coclass_writer: WIZARD_WRITER_CPP_CLASS
			-- Writer of coclass.

	inner_class_name: STRING is
			-- Name of inner class.
		do
			Result := connection_point_inner_class_name (source_interface, coclass_writer)
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
	
	inner_class_header_file: STRING is
			-- Header file name of inner class.
		do
			create Result.make (100)
			Result.append (inner_class_name)
			Result.append (".h")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
	
	attrubute_name: STRING is
			-- Name of connection point attribute.
		do
			Result := connection_point_attrubute_name (source_interface, coclass_writer)
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
		
	coclass_c_type: STRING is
			-- C type of coclass
		require
			non_void_coclass_wrier: coclass_writer /= Void
			non_void_coclass_name: coclass_writer.name /= Void
			valid_coclass_name: not coclass_writer.name.is_empty
		do
			create Result.make (100)
			if 
				coclass_writer.namespace /= Void and then 
				not coclass_writer.namespace.is_empty
			then
				Result.append (coclass_writer.namespace + "::")
			end
			Result.append (coclass_writer.name)
		ensure
			non_void_type: Result /= Void
			valid_type: not Result.is_empty
		end
		
	inner_class_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor of inner class.
		require
			non_void_coclass_wrier: coclass_writer /= Void
			non_void_coclass_name: coclass_writer.name /= Void
			valid_coclass_name: not coclass_writer.name.is_empty
		local
			signature: STRING
			body: STRING
		do
			create Result.make
			
			create signature.make (100)
			signature.append (coclass_c_type + " *")
			signature.append (" an_outer, EIF_OBJECT an_object, EIF_TYPE_ID a_type_id")
			Result.set_signature (signature)
			
			create body.make (100)
			body.append (Tab)
			body.append ("outer = an_outer;")
			body.append (New_line_tab)
			body.append ("eiffel_object = an_object;")
			body.append (New_line_tab)
			body.append ("type_id = a_type_id;")
			Result.set_body (body)
		ensure
			non_void_constructor: Result /= Void
			can_generate: Result.can_generate
		end
	
	inner_class_query_interface: WIZARD_WRITER_C_FUNCTION is
			-- QueryInterface of IConnectionPoint.
		do
			create Result.make
			Result.set_comment ("QueryInterface")
			
			Result.set_name ("QueryInterface")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("REFIID riid, void ** ppv")
			
			Result.set_body ("%Tif ((riid == IID_IUnknown) || (riid == IID_IConnectionPoint))%N%T%T%
									%*ppv = static_cast<IConnectionPoint *> (this);%N%T%
								%else%N%T%
								%{%N%T%T%
									%*ppv = NULL;%N%T%T%
									%return E_NOINTERFACE;%N%T%
								%}%N%T%
								%((IUnknown *)* ppv)->AddRef ();%N%T%
								%return S_OK;")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_add_ref: WIZARD_WRITER_C_FUNCTION is
			-- AddRef of IConnectionPoint.
		do
			create Result.make
			Result.set_comment ("AddRef")
			
			Result.set_name ("AddRef")
			Result.set_result_type (Ulong_std_method_imp)
			
			Result.set_signature ("void")
			
			Result.set_body ("%Treturn outer->AddRef ();")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_release: WIZARD_WRITER_C_FUNCTION is
			-- Release of IConnectionPoint.
		do
			create Result.make
			Result.set_comment ("Release")
			
			Result.set_name ("Release")
			Result.set_result_type (Ulong_std_method_imp)
			
			Result.set_signature ("void")
			
			Result.set_body ("%Treturn outer->Release ();")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_get_connection_interface : WIZARD_WRITER_C_FUNCTION is
			-- GetConnectionInterface of IConnectionPoint.
		do
			create Result.make
			Result.set_comment ("GetConnectionInterface")
			
			Result.set_name ("GetConnectionInterface")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("IID * piid")
			
			Result.set_body ("%Tif (piid == NULL)%N%T%T%
									%return E_POINTER;%N%T%
								%*piid = " + iid_name (source_interface.name) + ";%N%T%
								%return S_OK;")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_get_connection_point_container : WIZARD_WRITER_C_FUNCTION is
			-- GetConnectionPointContainer of IConnectionPoint.
		do
			create Result.make
			Result.set_comment ("GetConnectionPointContainer")
			
			Result.set_name ("GetConnectionPointContainer")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("IConnectionPointContainer ** ppcpc")
			
			Result.set_body ("%Tif (ppcpc == NULL)%N%T%T%
									%return E_POINTER;%N%T%
								%(*ppcpc = outer)->AddRef ();%N%T%
								%return S_OK;")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_advise : WIZARD_WRITER_C_FUNCTION is
			-- Advise of IConnectionPoint.
		local
			body: STRING
		do
			create Result.make
			Result.set_comment ("Advise")
			
			Result.set_name ("Advise")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("IUnknown * pUnk, DWORD * pdwCookie")
			
			create body.make (1000)
			body.append ("%Tif ((pUnk == NULL) || (pdwCookie == NULL))%N%T%T%
							%return E_POINTER;%N%T%
							%*pdwCookie = 0;%N%T") 
			if
				source_interface.namespace /= Void and then
				not source_interface.namespace.is_empty
			then
				body.append (source_interface.namespace + "::")
			end
			body.append (source_interface.name + " * p" + source_interface.name + ";%N%T%
							%HRESULT hr = pUnk->QueryInterface (" + 
								iid_name (source_interface.name) + 
								", (void**)&p" + source_interface.name + ");%N%T%
							%if (hr == E_NOINTERFACE)%N%T%T%
							%hr = CONNECT_E_NOCONNECTION;%N%T%
							%if (SUCCEEDED(hr))%N%T%
							%{%N%T%T%
							%EIF_INTEGER_FUNCTION eiffel_function = 0;%N%T%T%
							%eiffel_function = eif_integer_function (%"" + 
										add_feature_name (source_interface) + "%", type_id);%N%T%T%
							%EIF_OBJECT tmp_object = eif_protect (" + Ce_mapper +
								".ccom_ce_pointed_interface (p" + source_interface.name + 
								", %"" + source_interface.implemented_interface.eiffel_class_name + "%"));%N%T%T%
							%*pdwCookie = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function)" + 
								"(eif_access (eiffel_object), eif_wean (tmp_object));%N%T%
							%}%N%T%
							%return hr;")
			Result.set_body (body)
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_unadvise : WIZARD_WRITER_C_FUNCTION is
			-- Unadvise of IConnectionPoint.
		local
			body: STRING
		do
			create Result.make
			Result.set_comment ("Unadvise")
			
			Result.set_name ("Unadvise")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("DWORD dwCookie")
			
			create body.make (1000)
			body.append ("%T%
							%EIF_BOOLEAN_FUNCTION eiffel_function = 0;%N%T%
							%eiffel_function = eif_boolean_function (%"" +
								has_feature_name (source_interface) + "%", type_id);%N%T%
							%EIF_BOOLEAN a_bool = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_INTEGER))eiffel_function)" + 
								"(eif_access (eiffel_object), (EIF_INTEGER)dwCookie);%N%T%
							%if (a_bool != EIF_TRUE)%N%T%T%
								%return CONNECT_E_NOCONNECTION;%N%T%
							%EIF_PROCEDURE eiffel_procedure = 0;%N%T%
							%eiffel_procedure = eif_procedure (%"" +
								remove_feature_name (source_interface) + "%", type_id);%N%T%
							%(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_function)" + 
								"(eif_access (eiffel_object), (EIF_INTEGER)dwCookie);%N%T%
							%return S_OK;")
			Result.set_body (body)
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	inner_class_enum_connections : WIZARD_WRITER_C_FUNCTION is
			-- EnumConnections of IConnectionPoint.
		do
			create Result.make
			Result.set_comment ("EnumConnections")
			
			Result.set_name ("EnumConnections")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("IEnumConnections ** ppEnum")
			
			Result.set_body ("%Treturn E_NOTIMPL;")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

feature -- Miscellaneous

	add_attribute_to_coclass is
			-- Add connection point attribute to coclass.
		local
			an_attribute: WIZARD_WRITER_C_MEMBER
		do
			create an_attribute.make
			an_attribute.set_name (attrubute_name)
			an_attribute.set_result_type (inner_class_name + " *")
			an_attribute.set_comment ("Connection point implemntation for Source Interface " + 
					source_interface.c_type_name + ".")
			coclass_writer.add_member (an_attribute, Private)
		end
		
end -- class WIZARD_SOURCE_INTERFACE_C_SERVER_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
