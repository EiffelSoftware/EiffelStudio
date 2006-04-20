indexing
	description: "C client property generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

feature {NONE} -- Implementation

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_property: WIZARD_PROPERTY_DESCRIPTOR; a_interface_name, a_variable_name: STRING; a_lcid: INTEGER) is
			-- Generate C client access and setting features.
		require
			non_void_component: a_component /= Void
			non_void_coclass_name: a_component.name /= Void
			non_void_property: a_property /= Void
			non_void_interface_name: a_interface_name /= Void
			valid_interface_name: not a_interface_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_property.data_type.visitor

			create_access_feature (a_component, a_interface_name, a_variable_name, a_lcid, a_property, l_visitor)

				-- Setting function
			if not a_property.is_read_only then
				create_set_feature (a_component, a_interface_name, a_variable_name, a_lcid, a_property, l_visitor)
			end
		ensure then
			c_access_feature_exist: c_access_feature /= Void
			c_setting_feature_exist: not a_property.is_read_only implies c_setting_feature /= Void
		end

	create_access_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_interface_name, a_variable_name: STRING; 
						a_lcid: INTEGER; a_property: WIZARD_PROPERTY_DESCRIPTOR;
						a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Create access feature.
		require
			non_void_component: a_component /= Void
			non_void_interface_name: a_interface_name /= Void
			non_void_variable_name: a_variable_name /= Void
			non_void_property: a_property/= Void
			valid_interface_name: not a_interface_name.is_empty
			valid_variable_name: not a_variable_name.is_empty
		local
			l_header_file_name: STRING
		do
			-- Access feature (get_  function)
			create c_access_feature.make

			c_access_feature.set_name (external_feature_name (a_property.component_eiffel_name (a_component)))

			l_header_file_name := a_visitor.c_definition_header_file_name
			if l_header_file_name /= Void and then not l_header_file_name.is_empty then
				set_header_file (l_header_file_name)
			end

			-- Set result type
			if a_visitor.is_basic_type or a_visitor.vt_type = Vt_bool or a_visitor.is_enumeration then
				c_access_feature.set_result_type (a_visitor.cecil_type)
			else
				c_access_feature.set_result_type ("EIF_REFERENCE")
			end

			-- Set comment
			c_access_feature.set_comment (a_property.description)

			-- Set c access body
			set_access_body (a_interface_name, a_variable_name, a_lcid, a_property.member_id, a_visitor)
		end

	create_set_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_interface_name, a_variable_name: STRING; 
						a_lcid: INTEGER; a_property: WIZARD_PROPERTY_DESCRIPTOR;
						a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- -- Create set feature.
		require
			non_void_component: a_component /= Void
			non_void_interface_name: a_interface_name /= Void
			non_void_property: a_property/= Void
			valid_interface_name: not a_interface_name.is_empty
		local
			l_comment, l_signature, l_setter_name: STRING
		do
			create c_setting_feature.make
			
			create l_setter_name.make (100)
			l_setter_name.append (Set_clause)
			l_setter_name.append (a_property.component_eiffel_name (a_component))
			c_setting_feature.set_name (external_feature_name (l_setter_name))

			-- Set comment
			create l_comment.make (200)
			l_comment.append (a_property.description)
			l_comment.prepend ("Set ")
			c_setting_feature.set_comment (l_comment)

			-- Set signature
			create l_signature.make (200)
			if a_visitor.is_basic_type or a_visitor.vt_type = Vt_bool or a_visitor.is_enumeration then
				l_signature.append (a_visitor.cecil_type)
			elseif a_visitor.is_structure or a_visitor.is_array_basic_type then
				l_signature.append (a_visitor.c_type)
				l_signature.append (" *")
			elseif a_visitor.is_structure_pointer then
				l_signature.append (a_visitor.c_type)
			elseif a_visitor.is_interface_pointer or a_visitor.is_coclass_pointer or a_visitor.is_interface or a_visitor.is_coclass then
				l_signature.append ("IUnknown *")
			else
				l_signature.append ("EIF_OBJECT")
			end
			l_signature.append (" a_value")
			c_setting_feature.set_signature (l_signature)
			c_setting_feature.set_result_type ("void")

			-- Set setting feature body
			set_setting_body (a_interface_name, a_variable_name, a_lcid, a_property.member_id, a_visitor)
		end

	set_access_body (a_interface_name, a_variable_name: STRING; a_lcid, a_member_id: INTEGER; a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set access body
		require
			non_void_visitor: a_visitor /= Void
			non_void_interface_name: a_interface_name /= Void
			valid_interface_name: not a_interface_name.is_empty
			non_void_access_feature: c_access_feature /= Void
		local
			l_body: STRING
			l_var: ARRAYED_LIST [STRING]
		do
			create l_var.make (0)

			create l_body.make (4096)
			l_body.append (check_interface_pointer (a_interface_name, a_variable_name))

			-- Set up "invoke" function call

			l_body.append ("%N%TDISPID disp = (DISPID) ")
			l_body.append_integer (a_member_id)
			l_body.append (";%N%TLCID lcid = (LCID) ")
			l_body.append_integer (a_lcid)
			l_body.append (";%N%TDISPPARAMS args = {NULL, NULL, 0, 0};%N%TVARIANT pResult; %N%TVariantInit (&pResult);%N%N")
			l_body.append (initialize_excepinfo)
			l_body.append ("%N%Tunsigned int nArgErr;%N%N%Thr = ")
			l_body.append (a_variable_name)
			l_body.append ("->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);%N%T")

			-- if argument error
			l_body.append (examine_parameter_error ("hr"))
			l_body.append ("%N%T")
			l_body.append (examine_hresult_with_pointer ("hr", l_var))

			l_body.append ("%N%N%T")

			-- return result from each type
			l_body.append (retval_return_value_set_up (a_visitor))

			c_access_feature.set_body (l_body)
		end

	set_setting_body (a_interface_name, a_variable_name: STRING; a_lcid, a_member_id: INTEGER; a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- 
		require
			non_void_visitor: a_visitor /= Void
			non_void_interface_name: a_interface_name /= Void
			valid_interface_name: not a_interface_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
			non_void_c_setting_feature: c_setting_feature /= Void
		local
			l_body: STRING
			l_var: ARRAYED_LIST [STRING]
			type: INTEGER
		do
			create l_var.make (1)
			type := a_visitor.vt_type
			l_body := check_interface_pointer (a_interface_name, a_variable_name)

			-- Set up "invoke" function call
			l_body.append ("%N%TDISPID disp = (DISPID) ")
			l_body.append_integer (a_member_id)
			l_body.append (";%N%TLCID lcid = (LCID) ")
			l_body.append_integer (a_lcid)

			-- Set up parameter
			l_body.append (";%N%TDISPPARAMS args;%N%TVARIANTARG arg;%N%N%T")

			if not a_visitor.is_structure then
				if a_visitor.is_interface_pointer or a_visitor.is_coclass_pointer then
					if a_visitor.vt_type = Vt_unknown then
						l_body.append ("IUnknown *")
					else
						l_body.append ("IDispatch *")
					end
				else
					l_body.append (a_visitor.c_type)
				end
				l_body.append (" tmp_value")
				
				if a_visitor.is_interface_pointer or a_visitor.is_coclass_pointer or a_visitor.is_structure_pointer then
					l_body.append (" = 0")
				end
				l_body.append (";%N%T")

				if a_visitor.vt_type = Vt_dispatch then
					l_body.append ("hr = a_value->QueryInterface (IID_IDispatch, (void**)&tmp_value)")
				elseif
					a_visitor.vt_type = Vt_unknown
				then
					l_body.append ("tmp_value = a_value")
				else
					l_body.append ("tmp_value = ")
					if is_byref (type) then
						l_var.extend ("tmp_value")
					end

					if a_visitor.is_basic_type or a_visitor.is_enumeration  or a_visitor.is_array_basic_type or a_visitor.is_structure_pointer then
						l_body.append ("(")
						l_body.append (a_visitor.c_type)
						l_body.append (")a_value")
					else
						if a_visitor.need_generate_ec then
							l_body.append (a_visitor.ec_mapper.variable_name)
						else
							l_body.append ("rt_ec")
						end

						l_body.append (".")
						l_body.append (a_visitor.ec_function_name)
						l_body.append (" (a_value)")
					end
				end
				l_body.append (";%N%T")
			end

			l_body.append ("arg.vt = ")
			l_body.append_integer (type)
			l_body.append (";%N%T")

			if a_visitor.is_structure then
				l_body.append ("memcpy (&(arg.")
				l_body.append (vartype_namer.variant_field_name (a_visitor))
				l_body.append ("), a_value, sizeof (")
				l_body.append (a_visitor.c_type)
				l_body.append ("))")
			else
				l_body.append ("arg.")
				l_body.append (vartype_namer.variant_field_name (a_visitor))
				l_body.append (" = tmp_value")
			end
			l_body.append (";%N%Targs.rgvarg = &arg;%N%T")
			l_body.append ("args.rgdispidNamedArgs = NULL;%N%T")
			l_body.append ("args.cArgs = 1;%N%T")
			l_body.append ("args.cNamedArgs = 0;%N%N%T")
			l_body.append ("VARIANT pResult; %N%TVariantInit (&pResult);%N%N")
			l_body.append (initialize_excepinfo)
			l_body.append ("%N%Tunsigned int nArgErr;")
			l_body.append ("%N%N%Thr = ")
			l_body.append (variable_name (a_interface_name))
			l_body.append ("->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);%N%T")

			-- if argument error
			l_body.append (examine_parameter_error ("hr"))
			l_body.append (examine_hresult_with_pointer ("hr", l_var))

			if not l_var.is_empty then
				l_body.append ("%N%TCoTaskMemFree ((void *)")
				l_body.append (l_var.first)
				l_body.append (");")
			end
			l_body.append ("%N%T")
			c_setting_feature.set_body (l_body)
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
end -- class WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

