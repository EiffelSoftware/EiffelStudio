indexing
	description: "Generator of dispinterface functions for client."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

	WIZARD_DISPATCH_FUNCTION_HELPER

	WIZARD_SHARED_GENERATION_ENVIRONMENT

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; 
				a_interface_name, a_variable_name, a_guid: STRING; a_lcid: INTEGER; 
				a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate function.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_interface_name: a_interface_name /= Void
			non_void_guid: a_guid /= Void
			non_void_variable_name: a_variable_name /= Void
		local
			ccom_func_name: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create ccom_feature_writer.make
			create {ARRAYED_LIST [STRING]} c_header_files.make (20)
			func_desc := a_descriptor

			-- Set function name used in ccom
			if a_descriptor.is_renamed_in (a_component_descriptor) then
				ccom_func_name := external_feature_name (a_descriptor.component_eiffel_name (a_component_descriptor))
			else
				ccom_func_name := external_feature_name (a_descriptor.interface_eiffel_name)
			end
			ccom_feature_writer.set_name (ccom_func_name)

			ccom_feature_writer.set_comment (func_desc.description)

			l_visitor := a_descriptor.return_type.visitor

			if does_routine_have_result (a_descriptor) then
				set_return_type (l_visitor)
			else
				ccom_feature_writer.set_result_type ("void")
			end

			if func_desc.argument_count > 0 then
				set_signature
			end

			if (l_visitor.vt_type = Vt_variant) then
				l_visitor.set_ce_function_name ("ccom_ce_pointed_variant")
			end
			ccom_feature_writer.set_body (feature_body (a_interface_name, a_variable_name, a_guid, a_lcid, l_visitor, a_descriptor.invoke_kind))
		ensure
			function_descriptor_set: func_desc /= Void
		end

feature {NONE} -- Access

	free_arguments: ARRAYED_LIST [STRING]

feature {NONE} -- Implementation

	set_signature is
			-- Set ccom client feature signature
		require
			non_void_feature_writer: ccom_feature_writer /= Void
		do
			ccom_feature_writer.set_signature (cecil_signature (func_desc))
		end

	feature_body (a_interface_name, a_variable_name, a_guid: STRING; a_lcid: INTEGER; a_visitor: WIZARD_DATA_TYPE_VISITOR; a_invoke_kind: INTEGER): STRING is
			-- Ccom client feature body for dispatch interface
		require
			non_void_interface_name: a_interface_name /= Void
			valid_interface_name: not a_interface_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
			non_void_guid: a_guid /= Void
			valid_guid: not a_guid.is_empty
		local
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_return_value, l_invoke_flag: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			l_is_out: BOOLEAN
			l_counter, l_type_id, l_count: INTEGER
			l_type: WIZARD_DATA_TYPE_DESCRIPTOR
		do
			create {ARRAYED_LIST [STRING]} free_arguments.make (20)
			create l_return_value.make (2000)
			create Result.make (2000)
			
			Result.append (check_interface_pointer (a_interface_name, a_variable_name))
			Result.append ("%N%TDISPID disp = (DISPID) ")
			Result.append_integer (func_desc.member_id)
			Result.append (";%N%TLCID lcid = (LCID) ")
			Result.append_integer (a_lcid)
			Result.append (";%N%TDISPPARAMS dispparams;%N%Tmemset(&dispparams, 0, sizeof(dispparams));%N%T")
			Result.append ("VARIANT pResult; %N%TVariantInit (&pResult);%N%T%N")
			Result.append (initialize_excepinfo)
			Result.append ("%N%Tunsigned int nArgErr;%N%T")

			-- Set up arguments
			l_count := func_desc.argument_count
			if l_count > 0 then
				Result.append ("dispparams.cArgs = ")
				Result.append_integer (l_count)
				Result.append (";%N%TVARIANTARG args[")
				Result.append_integer (l_count)
				Result.append ("];%N%T")

				l_arguments := func_desc.arguments
				from
					l_arguments.start
					l_counter := l_count - 1
				until
					l_arguments.after or else l_counter = -1
				loop
					l_type := l_arguments.item.type
					l_visitor := l_type.visitor
					
					-- Since VARIANT is treated as VARIANT *,
					-- we need to check what it was originally,
					-- to find out whether if [in] or [in, out] parameter.
					if is_variant (l_type.type) then
						l_type_id := l_type.type
					else
						l_type_id := l_visitor.vt_type
					end			
					if is_byref (l_type_id) then
						l_is_out := True  
						if is_paramflag_fin (l_arguments.item.flags) then
							Result.append (inout_parameter_set_up (l_arguments.item.name, l_counter, l_visitor))
						else
							Result.append (out_parameter_set_up (l_arguments.item.name, l_counter, l_visitor))
						end
						if not l_visitor.is_array_basic_type and not l_visitor.is_structure_pointer and not
						 		l_visitor.is_interface_pointer and not l_visitor.is_coclass_pointer then
							l_return_value.append (out_return_value_set_up (l_arguments.item.name, l_counter,  l_visitor))
						end
					else
						Result.append (in_parameter_set_up (l_arguments.item.name, l_counter, l_visitor))
					end
					l_visitor := Void
					l_arguments.forth
					l_counter := l_counter - 1			
				end

				Result.append ("%N%Tdispparams.rgvarg = args;")
			end

			Result.append ("%N%N%Thr = ")
			Result.append (variable_name (a_interface_name))
			if a_invoke_kind = invoke_func then
				l_invoke_flag := "DISPATCH_METHOD"
			elseif a_invoke_kind = invoke_propertyget then
				l_invoke_flag := "DISPATCH_PROPERTYGET"
			elseif a_invoke_kind = invoke_propertyput then
				l_invoke_flag := "DISPATCH_PROPERTYPUT"
			elseif a_invoke_kind = invoke_propertyputref then
				l_invoke_flag := "DISPATCH_PROPERTYPUTREF"
			else
				check
					should_not_be_here: False
				end
			end
			Result.append ("->Invoke (disp, IID_NULL, lcid, ")
			Result.append (l_invoke_flag)
			Result.append (", &dispparams, &pResult, excepinfo, &nArgErr);%N%T")

			-- if argument error
			Result.append (examine_parameter_error ("hr"))
			Result.append ("%N")
			Result.append (examine_hresult_with_pointer ("hr", free_arguments))

			if l_is_out then
				Result.append ("%N%T")
				Result.append (l_return_value)
			end

			from
				l_counter := 0
			until
				l_counter = l_count
			loop
				Result.append ("%N%TVariantClear(&args[")
				Result.append_integer (l_counter)
				Result.append ("]);")
				l_counter := l_counter + 1
			end

			from
				free_arguments.start
			until
				free_arguments.after
			loop
				Result.append ("%N%TCoTaskMemFree ((void *)")
				Result.append (free_arguments.item)
				Result.append (");")
				free_arguments.forth
			end

			Result.append ("%N%T")
			Result.append (retval_return_value_set_up (a_visitor))
		end

	out_return_value_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up return value for "out" parameter
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
			valid_position: position >= 0
		local
			type: INTEGER
		do
			type := visitor.vt_type
			create Result.make (1000)

			Result.append ("%N%T")
			if not visitor.is_basic_type and not visitor.is_enumeration then
				if visitor.need_generate_ce then
					Result.append (visitor.ce_mapper.variable_name)
				else
					Result.append ("rt_ce")
				end
				Result.append (".")
				Result.append (visitor.ce_function_name)
			end
			Result.append (" (")

			if is_unsigned_long (type) then
				Result.append ("(long *)")
			elseif is_unsigned_int (type) then
				Result.append ("(int *)")
			elseif is_unsigned_short (type) then
				Result.append ("(short *)")
			elseif is_unsigned_char (type) then
				Result.append ("(char *)")
			else
				Result.append ("(")
				Result.append (visitor.c_type)
				Result.append (")")
			end

			Result.append (out_value_set_up (position, vartype_namer.variant_field_name (visitor)))
			Result.append (", ")
			Result.append (name)
			Result.append (");")
		end

	out_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "out" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			l_string: STRING
			l_type: INTEGER
		do
			l_type := visitor.vt_type
			create Result.make (10000)
			if visitor.is_basic_type or visitor.is_enumeration then
				create l_string.make (200)
				l_string.append (name)
				Result.append ("%N%T")
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), l_string, visitor))

			else
				Result.append ("%N%T")
				Result.append (argument_type_set_up (position, l_type))

				if visitor.is_array_basic_type or visitor.is_structure_pointer or visitor.is_interface_pointer or visitor.is_coclass_pointer then
					Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), name, visitor))	
				else
					Result.append (visitor.c_type)
					Result.remove (Result.count)
					Result.append ("tmp_")
					Result.append (name)
					Result.append (" = 0;%N%T")

					create l_string.make (100)
					l_string.append ("&tmp_")
					l_string.append (name)
					Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), l_string, visitor))	
				end
			end
		end

	inout_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "in" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			l_value: STRING
		do
			if is_error (visitor.vt_type) or is_hresult (visitor.vt_type) then
				create Result.make (500)
				Result.append ("%N%T")
				Result.append (argument_type_set_up (position, visitor.vt_type))

				create l_value.make (500)
				l_value.append ("rt_ec.")
				l_value.append (visitor.ec_function_name)
				l_value.append (" (eif_access (")
				l_value.append (name)
				l_value.append ("), NULL)")
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), l_value, visitor))
			else
				Result := in_parameter_set_up (name, position, visitor)
			end
		end

	in_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "in" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			l_value: STRING
			l_type: INTEGER
		do
			l_type := visitor.vt_type
			create Result.make (1000)

			Result.append ("%N%TVariantInit(&args[")
			Result.append_integer (position)
			Result.append ("]);%N%T")

			if not (is_variant (l_type) and visitor.is_structure) then
				-- We are assigning variants directly into the `args' array
				-- so there is no need to setup the type
				Result.append (argument_type_set_up (position, l_type))
			end
			
			if visitor.is_basic_type or visitor.is_enumeration or is_hresult (visitor.vt_type) or is_error (visitor.vt_type) then
				create l_value.make (100)
				l_value.append (name)
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), l_value, visitor))

			elseif (l_type = Vt_bool) then
				create l_value.make (100)
				l_value.append ("rt_ec.")
				l_value.append (visitor.ec_function_name)
				l_value.append (" (")
				l_value.append (name)
				l_value.append (")")
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), l_value, visitor))

			elseif visitor.is_basic_type_ref then
				create l_value.make (100)
				l_value.append ("tmp_")
				l_value.append (name)
				free_arguments.put_front (l_value)
				Result.append ("%N%T")
				Result.append (visitor.c_type)
				Result.append (" ")
				Result.append (l_value)
				Result.append (";%N%T")
				Result.append (l_value)
				Result.append (" = (")
				Result.append (visitor.c_type)
				Result.append (")rt_ec.")
				Result.append (visitor.ec_function_name)
				Result.append (" (eif_access (")
				Result.append (name)
				Result.append (")")
				if visitor.writable then
					Result.append (", NULL")
				end
				Result.append (");%N%T")
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), l_value, visitor))

			elseif is_variant (l_type) and visitor.is_structure then
				Result.append ("%N%TVariantCopy(&args[")
				Result.append_integer (position)
				Result.append ("], ")
				Result.append (name)
				Result.append (");%N%T")

			elseif visitor.is_array_basic_type or visitor.is_structure_pointer then
				Result.append ("%N%T")
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), name, visitor))

			elseif visitor.is_interface_pointer or visitor.is_coclass_pointer then
				Result.append ("%N%T")
				Result.append (add_ref_in_interface_pointer (name))
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), name, visitor))

			elseif visitor.is_structure then
				Result.append ("%N%T")
				if is_decimal (visitor.vt_type) then
					Result.append ("CURRENCY tmp_cy;%N%T")
					Result.append ("VarCyFromDec (")
					Result.append (name)
					Result.append (", &tmp_cy);%N%T")
					Result.append ("VarDecFromCy (tmp_cy, &(args[")
					Result.append_integer (position)
					Result.append ("].decVal));")
				else
					create l_value.make (100)
					l_value.append ("*")
					l_value.append (name)
					Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), l_value, visitor))
				end
			else
				if is_byref (l_type) then
					create l_value.make (100)
					l_value.append ("tmp_")
					l_value.append (name)
					free_arguments.put_front (l_value)
					Result.append ("%N%T")
					Result.append (visitor.c_type)
					Result.append (" ")
					Result.append (l_value)
					Result.append (";%N%T")
					Result.append (l_value)
					Result.append (" = ")
					if visitor.need_generate_ec then
						Result.append (visitor.ec_mapper.variable_name)
					else
						Result.append ("rt_ec")
					end
					Result.append (".")
					Result.append (visitor.ec_function_name)
					Result.append (" (eif_access (")
					Result.append (name)
					Result.append (")")
					if visitor.writable then
						Result.append (", NULL")
					end
					Result.append (");%N%T")
				else
					create l_value.make (500)
					if visitor.need_generate_ec then
						l_value.append (visitor.ec_mapper.variable_name)
					else
						l_value.append ("rt_ec")
					end
					l_value.append (".")
					l_value.append (visitor.ec_function_name)
					l_value.append (" (eif_access (")
					l_value.append (name)
					l_value.append ("))")
				end
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), l_value, visitor))
			end
		end
		
	out_value_set_up (position: INTEGER; attribute_name: STRING): STRING is
			-- Set up code for argument variable
		require
			valid_position: position >= 0
			non_void_attribute_name: attribute_name /= Void
			valid_name: not attribute_name.is_empty
		do
			create Result.make (100)
			Result.append ("args [")
			Result.append_integer (position)
			Result.append ("].")
			Result.append (attribute_name)
		end
			
	argument_type_set_up (position, type: INTEGER): STRING is
			-- Code to set parameter type for dispatch function call
		require
			valid_position: position >= 0
		do
			create Result.make (100)
			Result.append ("args [")
			Result.append_integer (position)
			Result.append ("].vt = ")
			Result.append_integer (type)
			Result.append (";%N%T")
		ensure
			non_void_argument_type: Result /= Void
			valid_argument_type: not Result.is_empty
		end

	argument_value_set_up (position: INTEGER; attribute_name, value: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set parameter value for dispatch function call
		require
			non_void_visitor: visitor /= Void
			non_void_name: attribute_name /= Void
			valid_name: not attribute_name.is_empty
			non_void_value: value /= Void
			valid_value: not value.is_empty
		do
			Result := out_value_set_up (position, attribute_name)
			Result.append (" = (")

			if visitor.is_coclass_pointer or visitor.is_interface_pointer then
				if is_iunknown (visitor.vt_type) then
					Result.append ("IUnknown *")
				else
					Result.append ("IDispatch *")
				end
			elseif visitor.is_coclass_pointer_pointer or visitor.is_interface_pointer_pointer then
				if is_iunknown (visitor.vt_type) then
					Result.append ("IUnknown **")
				else
					Result.append ("IDispatch **")
				end
			else
				Result.append (visitor.c_type)
			end
			Result.append (")")
			Result.append (value)
			Result.append (";%N%T")
		ensure
			non_void_argument_value: Result /= Void
			valid_argument_value: not Result.is_empty
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
end -- class WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR

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

