indexing
	description: "Feature Generator"
	status: "See notice at end of class";
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

	check_interface_pointer (interface_name: STRING): STRING is
			-- Code for interface pointer checking
		require
			non_void_interface_name: interface_name /= Void 
			valid_interface_name: not interface_name.is_empty 
		do
			create Result.make (400)
			Result.append ("%THRESULT hr;%N%T")
			Result.append ("if (p_")
			Result.append (interface_name)
			Result.append (" == NULL)%N%T{%N%T%T")
			Result.append ("hr = p_unknown->QueryInterface (")
			Result.append (iid_name (interface_name))
			Result.append (", (void **)&p_")
			Result.append (interface_name)
			Result.append (");%N")
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

			Result.append ("%Tif (FAILED (")
			Result.append (variable_name)
			Result.append ("))%N%T{%N%T%T")
			Result.append ("if ((HRESULT_FACILITY (")
			Result.append (variable_name)
			Result.append (") == FACILITY_ITF) && (HRESULT_CODE  (")
			Result.append (variable_name)
			Result.append (") > 1024) && (HRESULT_CODE  (")
			Result.append (variable_name)
			Result.append (") < 1053))%N%T%T%T")
			Result.append ("com_eraise (rt_ec.ccom_ec_lpstr (eename (HRESULT_CODE (")
			Result.append (variable_name)
			Result.append (") - 1024), NULL), HRESULT_CODE (")
			Result.append (variable_name)
			Result.append (") - 1024);%N%T%T")
			Result.append (raise_com_error (variable_name))
			Result.append ("};")
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
			Result.append ("), EN_PROG);%N%T")
		ensure
			non_void_raise: Result /= Void
			valid_raise: not Result.is_empty
		end
		
	initialize_excepinfo: STRING is
			-- Code to initialize excepinfo
		do
			create Result.make (400)
			Result.append ("%Texcepinfo->wCode = 0;%N%T")
			Result.append ("excepinfo->wReserved = 0;%N%T")
			Result.append ("excepinfo->bstrSource = NULL;%N%T")
			Result.append ("excepinfo->bstrDescription = NULL;%N%T")
			Result.append ("excepinfo->bstrHelpFile = NULL;%N%T")
			Result.append ("excepinfo->dwHelpContext = 0;%N%T")
			Result.append ("excepinfo->pvReserved = NULL;%N%T")
			Result.append ("excepinfo->pfnDeferredFillIn = NULL;%N%T")
			Result.append ("excepinfo->scode = 0;%N%T")
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
			else
				Result.append ("EIF_REFERENCE result = ")
				if visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append ("rt_ce")
				end
				Result.append (".")
				if is_variant (type) then
					Result.append ("ccom_ce_pointed_variant")
				else
					Result.append (visitor.ce_function_name)
				end
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

end -- class WIZARD_C_FEATURE_GENERATOR

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

