indexing
	description: "Feature Generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_FEATURE_GENERATOR

inherit
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

	WIZARD_GUID_GENERATOR
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	check_interface_pointer (a_interface_name, a_variable_name: STRING): STRING is
			-- Code for interface pointer checking
		require
			non_void_interface_name: a_interface_name /= Void
			valid_interface_name: not a_interface_name.is_empty
		do
			create Result.make (400)
			Result.append ("%THRESULT hr;%N%T")
			Result.append ("if (")
			Result.append (a_variable_name)
			Result.append (" == NULL)%N%T{%N%T%T")
			Result.append ("hr = p_unknown->QueryInterface (")
			Result.append (iid_name (a_interface_name))
			Result.append (", (void **)&")
			Result.append (a_variable_name)
			Result.append (");%N%T")
			Result.append (examine_hresult (Hresult_variable_name))
			Result.append ("%N%T};")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	examine_parameter_error (variable_name: STRING): STRING is
			-- Examine parameter error function
		require
			non_void_variable_name: variable_name /= Void
			valid_variable_name: not variable_name.is_empty
		do
			create Result.make (400)
			Result.append ("%N%Tif (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)%N%T{%N%T%T")
			Result.append ("char * hresult_error = f.c_format_message (hr);%N%T%T")
			Result.append ("char arg_no[20];%N%T%T")
			Result.append ("itoa (nArgErr, arg_no, 10);%N%T%T")
			Result.append ("char * arg_name = %"Argument No: %";%N%T%T")
			Result.append ("int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;%N%T%T")
			Result.append ("char * message;%N%T%T")
			Result.append ("message = (char *)calloc (size, sizeof (char));%N%T%T")
			Result.append ("strcat (message, hresult_error);%N%T%T")
			Result.append ("strcat (message, arg_no);%N%T%T")
			Result.append ("strcat (message, arg_name);%N%T%T")
			Result.append ("com_eraise (message, HRESULT_CODE(hr));%N%T}")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	examine_hresult_with_pointer (variable_name: STRING; pointer_variables: LIST [STRING]): STRING is
			-- Hresult examination function
		require
			non_void_name: variable_name /= Void
			valid_name: not variable_name.is_empty
			non_void_variables: pointer_variables /= Void
		do
			create Result.make (400)
			Result.append ("%T%Tif (FAILED (")
			Result.append (variable_name)
			Result.append ("))%N%T%T{")
			if not pointer_variables.is_empty then
				from
					pointer_variables.start
				until
					pointer_variables.off
				loop
					Result.append ("%N%T%T%TCoTaskMemFree ((void *)")
					Result.append (pointer_variables.item)
					Result.append (");")
					pointer_variables.forth
				end
			end
			Result.append ("%N%T%T%T")
			Result.append (raise_com_error (variable_name))
			Result.append ("%N%T%T};")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	examine_hresult (variable_name: STRING): STRING is
			-- Hresult examination function.
		require
			non_void_name: variable_name /= Void
			valid_name: not variable_name.is_empty
		do
			create Result.make (400)

			Result.append ("%Trt.ccom_check_hresult (" + variable_name + ");")
		ensure
			non_void_examine_hresult: Result /= Void
			valid_examine_hresult: not Result.is_empty
		end

	raise_com_error (variable_name: STRING): STRING is
			-- Code for raising COM exception.
		require
			non_void_name: variable_name /= Void
			valid_name: not variable_name.is_empty
		do
			create Result.make (100)
			Result.append ("com_eraise (f.c_format_message (")
			Result.append (variable_name)
			Result.append ("), EN_COM);%N%T")
		ensure
			non_void_raise: Result /= Void
			valid_raise: not Result.is_empty
		end

	initialize_excepinfo: STRING is
			-- Code to initialize excepinfo
		do
			create Result.make (400)
			Result.append ("%Tmemset(&excepinfo, 0, sizeof(excepinfo));%N%T")
		end

	retval_return_value_set_up (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up return value
		require
			non_void_visitor: visitor /= Void
		local
			type: INTEGER
		do
			type := visitor.vt_type

			create Result.make (500)

			if visitor.is_enumeration or visitor.is_basic_type and type /= Vt_void then
				Result.append (visitor.cecil_type)
				Result.append (" result = (")
				Result.append (visitor.cecil_type)
				Result.append (")")
				Result.append (retval_value_set_up (vartype_namer.variant_field_name (visitor)))
				Result.append (";")

			elseif type = Vt_bool then
				Result.append ("EIF_BOOLEAN result = rt_ce.")
				Result.append (visitor.ce_function_name)
				Result.append (" (")
				Result.append (retval_value_set_up (vartype_namer.variant_field_name (visitor)))
				Result.append (");")

			elseif type = Vt_void or is_hresult (type) or is_error (type) then
				Result := (" ")
			elseif is_variant (type) then
				Result.append ("VARIANT* pVar = (VARIANT*)CoTaskMemAlloc (sizeof (VARIANT));%N%T")
				Result.append ("VariantInit (pVar);%N%T")
				Result.append ("VariantCopy (pVar, &pResult);%N%T")
				Result.append ("EIF_REFERENCE result = rt_ce.ccom_ce_pointed_variant (pVar);%N%T")
				Result.append ("VariantClear (&pResult);%N%T")
			else
				Result.append ("EIF_REFERENCE result = ")
				if visitor.need_generate_ce then
					Result.append (visitor.ce_mapper.variable_name)
				else
					Result.append ("rt_ce")
				end
				Result.append (".")
				Result.append (visitor.ce_function_name)
				Result.append (" (")
				if visitor.is_interface or visitor.is_interface_pointer then
					Result.append ("(")
					Result.append (visitor.c_type)
					Result.append (")")
				end
				Result.append (retval_value_set_up (vartype_namer.variant_field_name (visitor)))
				if visitor.writable then
					Result.append (", NULL")
				end
				Result.append (");")
			end

			if not (type = Vt_void or is_hresult (type) or is_error (type)) then
				Result.append ("%N%Treturn result;")
			end
		ensure
			non_void_retval: Result /= Void
			valid_retval: not Result.is_empty
		end

	retval_value_set_up (attribute_name: STRING): STRING is
			-- Set up code for return variable
		require
			non_void_name: attribute_name /= Void
			valid_name: not attribute_name.is_empty
		do
			create Result.make (100)
			Result.append ("pResult.")
			Result.append (attribute_name)
		ensure
			non_void_argument: Result /= Void
			valid_argument: not Result.is_empty
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
end -- class WIZARD_C_FEATURE_GENERATOR


