indexing
	description: "Coclass c server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_C_SERVER_GENERATOR
	
inherit
	WIZARD_COCLASS_C_GENERATOR

	WIZARD_COMPONENT_C_SERVER_GENERATOR
		redefine
			generate,
			constructor_addition,
			destructor_addition
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	WIZARD_SOURCE_INTERFACE_HELPER
		export
			{NONE} all
		end

feature -- Access

	default_dispinterface (a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_INTERFACE_DESCRIPTOR is
			-- Default dispinterface.
		do
			from
				a_coclass.interface_descriptors.start
			until
				a_coclass.interface_descriptors.after
			loop
				if a_coclass.interface_descriptors.item.c_type_name.is_equal (default_dispinterface_name (a_coclass)) then
					Result := a_coclass.interface_descriptors.item
				end
				a_coclass.interface_descriptors.forth
			end
		end

	source: BOOLEAN
			-- Is coclass source of events?

feature -- Basic operations

	generate (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c server for coclass.
		local
			a_class_object: WIZARD_CLASS_OBJECT_GENERATOR
			tmp_string: STRING
		do
			Precursor {WIZARD_COMPONENT_C_SERVER_GENERATOR} (a_coclass)
			create interface_names.make

			if shared_wizard_environment.out_of_process_server then
				create tmp_string.make (500)
				tmp_string.append (a_coclass.c_type_name)
				tmp_string.append (Underscore)
				tmp_string.append (Factory)
				tmp_string.append (Header_file_extension)
				cpp_class_writer.add_import (tmp_string)
			end

			-- Add clsid of the coclass
			cpp_class_writer.add_other (clsid_declaration (a_coclass.c_type_name))
			cpp_class_writer.add_other_source (clsid_definition (a_coclass.c_type_name, a_coclass.guid))

			process_interfaces	(a_coclass)			

			if dispatch_interface then
				dispatch_interface_features (a_coclass)
			else
				-- Add type library id
				cpp_class_writer.add_other_source (libid_definition 
						(a_coclass.type_library_descriptor.name, 
						a_coclass.type_library_descriptor.guid))
			end
			cpp_class_writer.add_parent ("IProvideClassInfo2", Void, Public)

			if source then
				cpp_class_writer.add_parent ("IConnectionPointContainer", Void, Public)
				add_source_functions (a_coclass)
			end

			standard_functions (a_coclass)
			cpp_class_writer.add_function (get_class_info_function (a_coclass), Public)
			cpp_class_writer.add_function (get_guid_function (a_coclass), Public)

			check
				valid_cpp_class_writer: cpp_class_writer.can_generate
			end

			-- Generate code and save name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void

			-- Generate code for class object factory.
			create a_class_object
			a_class_object.generate (a_coclass)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_c_server
		end

feature {NONE} -- Implementation

	process_interfaces (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process inherited interfaces
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR
		do
			create interface_processor.make (a_coclass_descriptor, Current)
			if (dispinterface_names = Void) then
				create dispinterface_names.make
			end
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
			source := interface_processor.source
		end


	default_dispinterface_name (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		do
			if 
				a_coclass_descriptor.default_dispinterface_name /= Void and then
				not a_coclass_descriptor.default_dispinterface_name.empty
			then
				Result := clone (a_coclass_descriptor.default_dispinterface_name)
			elseif (dispinterface_names /= Void) then
				Result := clone (dispinterface_names.first)
			end
		end

	default_source_dispinterface_name (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		do
			if 
				a_coclass_descriptor.source_interface_descriptors /= Void and then
				not a_coclass_descriptor.source_interface_descriptors.empty
			then
				from 
					a_coclass_descriptor.source_interface_descriptors.start
				until
					a_coclass_descriptor.source_interface_descriptors.after or
					Result /= Void
				loop
					if
						a_coclass_descriptor.source_interface_descriptors.item.dispinterface or
						a_coclass_descriptor.source_interface_descriptors.item.dual
					then
						Result := clone (a_coclass_descriptor.source_interface_descriptors.item.name)
					end
					a_coclass_descriptor.source_interface_descriptors.forth
				end
			end
		end

	constructor_addition (a_coclass: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Constructor addition.
		do
			create Result.make (0)
			if 
				a_coclass.source_interface_descriptors /= Void and then
				not a_coclass.source_interface_descriptors.empty
			then
				from
					a_coclass.source_interface_descriptors.start
				until
					a_coclass.source_interface_descriptors.after
				loop
					Result.append ("%N%T" + 
							connection_point_attrubute_name 
								(a_coclass.source_interface_descriptors.item, cpp_class_writer) + 
							" = new " + connection_point_inner_class_name 
								(a_coclass.source_interface_descriptors.item, cpp_class_writer) + 
							" (this, eiffel_object, type_id);")
					a_coclass.source_interface_descriptors.forth
				end
			end
		end

	destructor_addition (a_coclass: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Destructor addition.
		do
			create Result.make (0)
			if 
				a_coclass.source_interface_descriptors /= Void and then
				not a_coclass.source_interface_descriptors.empty
			then
				from
					a_coclass.source_interface_descriptors.start
				until
					a_coclass.source_interface_descriptors.after
				loop
					Result.append ("%N%Tdelete " + connection_point_attrubute_name 
								(a_coclass.source_interface_descriptors.item, cpp_class_writer) + ";")
					a_coclass.source_interface_descriptors.forth
				end
			end
		end

	add_constructor (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add constructor.
		local
			constructor_writer: WIZARD_WRITER_CPP_CONSTRUCTOR
			a_signature, a_constructor_body: STRING
		do
			create constructor_writer.make

			create a_signature.make (100)
			a_signature.append (Eif_type_id)
			a_signature.append (Space)
			a_signature.append (Type_id_variable_name)

			constructor_writer.set_signature (a_signature)

			create a_constructor_body.make (1000)
			a_constructor_body.append (Tab)
			a_constructor_body.append (Type_id)
			a_constructor_body.append (Space_equal_space)
			a_constructor_body.append (Type_id_variable_name)
			a_constructor_body.append (Semicolon)
			a_constructor_body.append (constructor_body (a_coclass))
			constructor_writer.set_body (a_constructor_body)
		
			check
				valid_constructor_writer: constructor_writer.can_generate
			end

			cpp_class_writer.add_constructor (constructor_writer)

			check
				writer_added: cpp_class_writer.constructors.has (constructor_writer)
			end
		end

	add_query_interface (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add function 'QueryInterface'
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			func_writer.set_name (Query_interface)
			func_writer.set_comment ("Query Interface.")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature (Query_interface_signature)

			create tmp_body.make (10000)
			tmp_body.append (Tab)

			if not a_coclass_descriptor.interface_descriptors.empty then
				tmp_body.append (case_body_in_query_interface 
					(a_coclass_descriptor.interface_descriptors.first.c_type_name,
					a_coclass_descriptor.interface_descriptors.first.namespace,
					Iunknown_clsid))
			else
				tmp_body.append (case_body_in_query_interface 
					("IProvideClassInfo2", Void, Iunknown_clsid))
			end

			tmp_body.append (Space)
			tmp_body.append (case_body_in_query_interface 
				("IProvideClassInfo2", Void, iid_name ("IProvideClassInfo")))

			tmp_body.append (Space)
			tmp_body.append (case_body_in_query_interface 
				("IProvideClassInfo2", Void, iid_name ("IProvideClassInfo2")))

			if dispatch_interface then
				tmp_body.append (Space)
				tmp_body.append (case_body_in_query_interface 
						(default_dispinterface_name (a_coclass_descriptor),
						a_coclass_descriptor.interface_descriptors.first.namespace, 
						iid_name (Idispatch_type)))

			end

			from
				a_coclass_descriptor.interface_descriptors.start
			until
				a_coclass_descriptor.interface_descriptors.off
			loop
				if
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Iunknown_type) and 
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Idispatch_type)
				then
					tmp_body.append (Space)
					tmp_body.append (case_body_in_query_interface 
							(a_coclass_descriptor.interface_descriptors.item.c_type_name,
							a_coclass_descriptor.interface_descriptors.item.namespace,
							iid_name (a_coclass_descriptor.interface_descriptors.item.c_type_name)))
				end
				a_coclass_descriptor.interface_descriptors.forth
			end
			
			if source then
				tmp_body.append (Space)
				tmp_body.append (case_body_in_query_interface 
						("IConnectionPointContainer",
						Void, iid_name ("IConnectionPointContainer")))				
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

	add_source_functions (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add source functions.
		require
			source: source
			non_void_coclass: a_coclass /= Void
		do
			cpp_class_writer.add_function (enum_connection_points_function, Public)
			cpp_class_writer.add_function (find_connection_point_function (a_coclass), Public)
		end
		
	enum_connection_points_function: WIZARD_WRITER_C_FUNCTION is
			-- EnumConnectionPoints
		require
			source: source
		local
			body: STRING
		do
			create Result.make
			Result.set_name ("EnumConnectionPoints")
			Result.set_comment ("EnumConnectionPoints of IConnectionPointContainer.")
			Result.set_result_type (Std_method_imp)
			Result.set_signature ("/* [out] */ IEnumConnectionPoints ** ppEnum")
			
			create body.make (100)
			body.append ("%Treturn E_NOTIMPL;")
			Result.set_body (body)
		ensure
			non_void_function: Result /= Void
			can_generate: Result.can_generate
		end
	
	find_connection_point_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- FindConnectionPoin
		require
			source: source
			non_void_coclass: a_coclass_descriptor /= Void
		local
			body: STRING
		do
			create Result.make
			Result.set_name ("FindConnectionPoint")
			Result.set_comment ("FindConnectionPoint of IConnectionPointContainer.")
			Result.set_result_type (Std_method_imp)
			Result.set_signature ("/* [in] */ REFIID riid, /* [out] */ IConnectionPoint ** ppCP")
			
			create body.make (100)
			body.append (Tab)
			from
				a_coclass_descriptor.source_interface_descriptors.start
			until
				a_coclass_descriptor.source_interface_descriptors.after
			loop
				body.append (case_body_in_find_connection_point 
						(a_coclass_descriptor.source_interface_descriptors.item, 
						iid_name (a_coclass_descriptor.source_interface_descriptors.item.c_type_name)))
				a_coclass_descriptor.source_interface_descriptors.forth
			end
			body.append ("%N%T{%N%T%T*ppCP = NULL;%N%T%Treturn CONNECT_E_NOCONNECTION;%N%T}%N%T")
			body.append ("(*ppCP)->AddRef ();%N%T")
			body.append ("return S_OK;")
			Result.set_body (body)
		ensure
			non_void_function: Result /= Void
			can_generate: Result.can_generate
		end

	case_body_in_find_connection_point (an_interface: WIZARD_INTERFACE_DESCRIPTOR; interface_id: STRING): STRING is
			-- Case body in FindConnectionPoint function implemenatation.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_id: interface_id /= Void
			valid_interface_id: not interface_id.empty
		do
			create Result.make (200)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Riid)
			Result.append (C_equal)
			Result.append (interface_id)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append ("* ppCP")
			Result.append (Space_equal_space)

			Result.append (connection_point_attrubute_name (an_interface, cpp_class_writer))
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Else_keyword)
			Result.append (Space)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	get_class_info_function (a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- GetClassInfo of IProvideClassInfo.
		do
			create Result.make
			Result.set_comment ("GetClassInfo")
			
			Result.set_name ("GetClassInfo")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("ITypeInfo ** ppti")
			
			Result.set_body ("%Tif (ppti == NULL)%N%T%T%
									%return E_POINTER;%N%T%
								%ITypeLib * ptl = NULL;%N%T%
								%HRESULT hr = LoadRegTypeLib (" + libid_name (a_coclass.type_library_descriptor.name) + ", 1, 0, 0, &ptl);%N%T%
								%if (SUCCEEDED (hr))%N%T%
								%{%N%T%T%
									%hr = ptl->GetTypeInfoOfGuid (" + clsid_name (a_coclass.name) + ", ppti);%N%T%T%
									%ptl->Release ();%N%T%
								%}%N%T%
								%return hr;")
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end
		
	get_guid_function (a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- GetGUID of IProvideClassInfo.
		local
			body, source_name: STRING
		do
			create Result.make
			Result.set_comment ("GetGUID")
			
			Result.set_name ("GetGUID")
			Result.set_result_type (Std_method_imp)
			
			Result.set_signature ("DWORD dwKind, GUID * pguid")
			
			create body.make (200)
			body.append ("%Tif ((dwKind != GUIDKIND_DEFAULT_SOURCE_DISP_IID) ||(!pguid))%N%T%T%
									%return E_INVALIDARG;%N%T")
			body.append ("*pguid = ")
			source_name := default_source_dispinterface_name (a_coclass)
			if
				source_name /= Void and then
				not source_name.empty
			then
				body.append (iid_name (source_name))
			else
				body.append ("IID_NULL")
			end
								
			body.append (";%N%Treturn S_OK;")
			Result.set_body (body)
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
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
