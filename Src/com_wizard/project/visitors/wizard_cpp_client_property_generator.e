indexing
	description: "C client property generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_PROPERTY_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

create 
	generate

feature {NONE} -- Basic operations

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; 
					a_property: WIZARD_PROPERTY_DESCRIPTOR; 
					interface_name: STRING; 
					lcid: INTEGER) is
			-- Generate C client access and setting features.
		require
			non_void_component: a_component /= Void
			non_void_coclass_name: a_component.name /= Void
			non_void_property: a_property /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.is_empty
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			visitor := a_property.data_type.visitor

			create_access_feature (a_component, interface_name, lcid, a_property, visitor)

				-- Setting function
			if not a_property.is_read_only then
				create_set_feature (a_component, interface_name, lcid, a_property, visitor)
			end
		ensure then
			c_access_feature_exist: c_access_feature /= Void
			c_setting_feature_exist: not a_property.is_read_only implies c_setting_feature /= Void
		end

feature {NONE} -- Implementation

	create_access_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR; interface_name: STRING; 
						lcid: INTEGER; a_property: WIZARD_PROPERTY_DESCRIPTOR;
						visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Create access feature.
		require
			non_void_component: a_component /= Void
			non_void_interface_name: interface_name /= Void
			non_void_property: a_property/= Void
			valid_interface_name: not interface_name.is_empty
		local
			l_header_file_name: STRING
		do
			-- Access feature (get_  function)
			create c_access_feature.make

			c_access_feature.set_name (external_feature_name (a_property.component_eiffel_name (a_component)))

			l_header_file_name := visitor.c_definition_header_file_name
			if l_header_file_name /= Void and then not l_header_file_name.is_empty then
				set_header_file (l_header_file_name)
			end

			-- Set result type
			if visitor.is_basic_type or visitor.vt_type = Vt_bool or visitor.is_enumeration then
				c_access_feature.set_result_type (visitor.cecil_type)
			else
				c_access_feature.set_result_type ("EIF_REFERENCE")
			end

			-- Set comment
			c_access_feature.set_comment (a_property.description)

			-- Set c access body
			set_access_body (interface_name, lcid, a_property.member_id, a_property.data_type.type, visitor)
		end

	create_set_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR; interface_name: STRING; 
						lcid: INTEGER; a_property: WIZARD_PROPERTY_DESCRIPTOR;
						visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- -- Create set feature.
		require
			non_void_component: a_component /= Void
			non_void_interface_name: interface_name /= Void
			non_void_property: a_property/= Void
			valid_interface_name: not interface_name.is_empty
		local
			a_comment, a_signature, set_feature_name: STRING
		do
			create c_setting_feature.make
			
			create set_feature_name.make (100)
			set_feature_name.append (Set_clause)
			set_feature_name.append (a_property.component_eiffel_name (a_component))
			c_setting_feature.set_name (external_feature_name (set_feature_name))

			-- Set comment
			create a_comment.make (200)
			a_comment.append (a_property.description)
			a_comment.prepend ("Set ")
			c_setting_feature.set_comment (a_comment)

			-- Set signature
			create a_signature.make (200)
			if visitor.is_basic_type or visitor.vt_type = Vt_bool or visitor.is_enumeration then
				a_signature.append (visitor.cecil_type)
			elseif visitor.is_structure or visitor.is_array_basic_type then
				a_signature.append (visitor.c_type)
				a_signature.append (" *")
			elseif visitor.is_structure_pointer then
				a_signature.append (visitor.c_type)
			elseif visitor.is_interface_pointer or visitor.is_coclass_pointer or visitor.is_interface or visitor.is_coclass then
				a_signature.append ("IUnknown *")
			else
				a_signature.append ("EIF_OBJECT")
			end
			a_signature.append (" a_value")
			c_setting_feature.set_signature (a_signature)
			c_setting_feature.set_result_type ("void")

			-- Set setting feature body
			set_setting_body (interface_name, lcid, a_property.member_id, visitor)
		end

	set_access_body (interface_name: STRING; lcid, member_id, type: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set access body
		require
			non_void_visitor: visitor /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.is_empty
			non_void_access_feature: c_access_feature /= Void
		local
			l_body: STRING
			l_var: ARRAYED_LIST [STRING]
		do
			create l_var.make (0)

			create l_body.make (4096)
			l_body.append (check_interface_pointer (interface_name))

			-- Set up "invoke" function call

			l_body.append ("%R%N%TDISPID disp = (DISPID) ")
			l_body.append_integer (member_id)
			l_body.append (";%R%N%TLCID lcid = (LCID) ")
			l_body.append_integer (lcid)
			l_body.append (";%R%N%TDISPPARAMS args = {NULL, NULL, 0, 0};%R%N%TVARIANT pResult; %R%N%TVariantInit (&pResult);%R%N%R%N")
			l_body.append (initialize_excepinfo)
			l_body.append ("%R%N%Tunsigned int nArgErr;%R%N%R%N%Thr = p_")
			l_body.append (interface_name)
			l_body.append ("->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);%R%N%T")

			-- if argument error
			l_body.append (examine_parameter_error ("hr"))
			l_body.append ("%R%N%T")
			l_body.append (examine_hresult_with_pointer ("hr", l_var))

			l_body.append ("%R%N%R%N%T")

			-- return result from each type
			l_body.append (retval_return_value_set_up (visitor))

			c_access_feature.set_body (l_body)
		end

	set_setting_body (interface_name: STRING; lcid, member_id: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- 
		require
			non_void_visitor: visitor /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.is_empty
			non_void_c_setting_feature: c_setting_feature /= Void
		local
			l_body: STRING
			l_var: ARRAYED_LIST [STRING]
			type: INTEGER
		do
			create l_var.make (1)
			type := visitor.vt_type
			l_body := check_interface_pointer (interface_name)

			-- Set up "invoke" function call
			l_body.append ("%R%N%TDISPID disp = (DISPID) ")
			l_body.append_integer (member_id)
			l_body.append (";%R%N%TLCID lcid = (LCID) ")
			l_body.append_integer (lcid)

			-- Set up parameter
			l_body.append (";%R%N%TDISPPARAMS args;%R%N%TVARIANTARG arg;%R%N%R%N%T")

			if not visitor.is_structure then
				if visitor.is_interface_pointer or visitor.is_coclass_pointer then
					if visitor.vt_type = Vt_unknown then
						l_body.append ("IUnknown *")
					else
						l_body.append ("IDispatch *")
					end
				else
					l_body.append (visitor.c_type)
				end
				l_body.append (" tmp_value")
				
				if visitor.is_interface_pointer or visitor.is_coclass_pointer or visitor.is_structure_pointer then
					l_body.append (" = 0")
				end
				l_body.append (";%R%N%T")

				if visitor.vt_type = Vt_dispatch then
					l_body.append ("hr = a_value->QueryInterface (IID_IDispatch, (void**)&tmp_value)")
				elseif
					visitor.vt_type = Vt_unknown
				then
					l_body.append ("tmp_value = a_value")
				else
					l_body.append ("tmp_value = ")
					if is_byref (type) then
						l_var.extend ("tmp_value")
					end

					if visitor.is_basic_type or visitor.is_enumeration  or visitor.is_array_basic_type or visitor.is_structure_pointer then
						l_body.append ("(")
						l_body.append (visitor.c_type)
						l_body.append (")a_value")
					else
						if visitor.need_generate_ec then
							l_body.append (Generated_ec_mapper)
						else
							l_body.append ("rt_ec")
						end

						l_body.append (".")
						l_body.append (visitor.ec_function_name)
						l_body.append (" (a_value)")
					end
				end
				l_body.append (";%R%N%T")
			end

			l_body.append ("arg.vt = ")
			l_body.append_integer (type)
			l_body.append (";%R%N%T")

			if visitor.is_structure then
				l_body.append ("memcpy (&(arg.")
				l_body.append (vartype_namer.variant_field_name (visitor))
				l_body.append ("), a_value, sizeof (")
				l_body.append (visitor.c_type)
				l_body.append ("))")
			else
				l_body.append ("arg.")
				l_body.append (vartype_namer.variant_field_name (visitor))
				l_body.append (" = tmp_value")
			end
			l_body.append (";%R%N%Targs.rgvarg = &arg;%R%N%T")
			l_body.append ("args.rgdispidNamedArgs = NULL;%R%N%T")
			l_body.append ("args.cArgs = 1;%R%N%T")
			l_body.append ("args.cNamedArgs = 0;%R%N%R%N%T")
			l_body.append ("VARIANT pResult; %R%N%TVariantInit (&pResult);%R%N%R%N")
			l_body.append (initialize_excepinfo)
			l_body.append ("%R%N%Tunsigned int nArgErr;")
			l_body.append ("%R%N%R%N%Thr = p_")
			l_body.append (interface_name)
			l_body.append ("->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);%R%N%T")

			-- if argument error
			l_body.append (examine_parameter_error ("hr"))
			l_body.append (examine_hresult_with_pointer ("hr", l_var))

			if not l_var.is_empty then
				l_body.append ("%R%N%TCoTaskMemFree ((void *)")
				l_body.append (l_var.first)
				l_body.append (");")
			end
			l_body.append ("%R%N%T")
			c_setting_feature.set_body (l_body)
		end

end -- class WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

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
