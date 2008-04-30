indexing
	description: "Invoke generator helper."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_GUIDS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_NAMER_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	ANY

feature -- Access

	excepinfo_setting: STRING is
			-- Fills EXCEPINFO `bstrDescription' and `bstrSource'
		do
			Result := "if (pExcepInfo != NULL)%N%
	%					{%N%
	%						WCHAR * wide_string = 0;%N%
	%						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));%N%
	%						BSTR b_string = SysAllocString (wide_string);%N%
	%						free (wide_string);%N%
	%						pExcepInfo->bstrDescription = b_string;%N%
	%						wide_string = ccom_create_from_string (%"" + environment.project_name + "%");%N%
	%						b_string = SysAllocString (wide_string);%N%
	%						free (wide_string);%N%
	%						pExcepInfo->bstrSource = b_string;%N%
	%						pExcepInfo->wCode = HRESULT_CODE (hr);%N%
	%					}"
		end

feature -- Basic operations

	add_ref_to_interface_variable (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_variable_name: STRING): STRING is
			-- Add `AddRef' to interface.
		require
			non_void_visitor: a_visitor /= Void
			non_void_name: a_variable_name /= Void
			valid_name: not a_variable_name.is_empty
		do
			create Result.make (100)
			if
				a_visitor.is_interface_pointer and
				(a_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or
				a_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append ("(")
				Result.append (a_variable_name)
				Result.append (")->AddRef ();%N%T%T%T%T")
			end

			if
				a_visitor.is_interface_pointer_pointer and
				(a_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or
				a_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append ("(*(")
				Result.append (a_variable_name)
				Result.append ("))->AddRef ();%N%T%T%T%T")
			end
		ensure
			non_void_result: Result /= Void
		end

	interface_descriptor_c_type_name (a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Interface's name.
		require
			non_void_descriptor: a_data_type_descriptor /= Void
			non_void_visitor: a_visitor /= void
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if a_visitor.c_type.substring_index (iunknown_type, 1) /= 0 then
				Result := iunknown_type.twin
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				Result := idispatch_type.twin
			else
				check
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.namespace +
					"::" + pointed_descriptor.interface_descriptor.c_type_name
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	check_failer  (a_argument_count: INTEGER; a_additional_string, a_return_code: STRING): STRING is
			-- Case statement for function descriptor
		require
			non_void_additional_string: a_additional_string /= Void
			non_void_return_code: a_return_code /= Void
			valid_return_code: not a_return_code.is_empty
		do
			create Result.make (200)
			Result.append ("if (FAILED (hr))%N%T%T%T%T{%N%T%T%T%T%T")
			if a_argument_count > 0 then
				Result.append ("CoTaskMemFree (tmp_value);%N%T%T%T%T%T")
			end
			Result.append (a_additional_string)
			Result.append ("%N%T%T%T%T%Treturn ")
			Result.append (a_return_code)
			Result.append (";%N%T%T%T%T}%N%T%T%T")
		end

	interface_descriptor_guid (a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR): ECOM_GUID is
			-- Interface's GUID.
		require
			non_void_descriptor: a_data_type_descriptor /= Void
			non_void_visitor: a_visitor /= void
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if a_visitor.c_type.substring_index (iunknown_type, 1) /= 0 then
				Result := Iunknown_guid
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				Result := Idispatch_guid
			else
				check
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.guid
			end
		ensure
			non_void_guid: Result /= Void
		end

	get_interface_pointer (unknown_name, a_variable_name, a_variant_name, variant_field_name: STRING;
					counter: INTEGER): STRING is
			-- Get intergace pointer from Variant.
		require
			non_void_unknown_name: unknown_name /= Void
			valid_unknown_name: not unknown_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
			non_void_variant_name: a_variant_name /= Void
			valid_variant_name: not a_variant_name.is_empty
			non_void_variant_field_name: variant_field_name /= Void
			valid_variant_field_name: not variant_field_name.is_empty
		do
				create Result.make (300)

				Result.append ("%N%T%T%T%T{%N%T%T%T%T%T")
				Result.append (unknown_name)
				Result.append (" tmp_")
				Result.append (a_variable_name)
				Result.append (" = ")
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (variant_field_name)
				Result.append (";%N%T%T%T%T%Tif (tmp_" + a_variable_name + " != NULL)%N%T%T%T%T%T%T")
				Result.append ("hr = tmp_")
				Result.append (a_variable_name)
				Result.append ("->QueryInterface (tmp_iid_")
				Result.append_integer (counter)
				Result.append (", (void**)(&")
				Result.append (a_variable_name)
				Result.append ("));%N%T%T%T%T}%N%T%T%T%T")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	get_interface_pointer_pointer (unknown_name, a_variable_name, a_variant_name, variant_field_name: STRING;
					counter: INTEGER): STRING is
			-- Get intergace pointer from Variant.
		require
			non_void_unknown_name: unknown_name /= Void
			valid_unknown_name: not unknown_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
			non_void_variant_name: a_variant_name /= Void
			valid_variant_name: not a_variant_name.is_empty
			non_void_variant_field_name: variant_field_name /= Void
			valid_variant_field_name: not variant_field_name.is_empty
		do
				create Result.make (300)
				Result.append ("%N%T%T%T%T{%N%T%T%T%T%T")
				Result.append (unknown_name)
				Result.append ("* tmp_")
				Result.append (a_variable_name)
				Result.append (" = ")
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (variant_field_name)
				Result.append (";%N%T%T%T%T%Tif (tmp_" + a_variable_name + " != NULL)%N%T%T%T%T%T%T")
				Result.append ("if (* tmp_")
				Result.append (a_variable_name)
				Result.append (" != NULL)%N%T%T%T%T%T%T%Thr = (*tmp_")
				Result.append (a_variable_name)
				Result.append (")->QueryInterface (tmp_iid_")
				Result.append_integer (counter)
				Result.append (", (void**)(&tmp_tmp_")
				Result.append (a_variable_name)
				Result.append ("));%N%T%T%T%T}%N%T%T%T%T")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	get_argument_from_variant (a_data_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
				a_variable_name, a_variant_name: STRING;
				counter: INTEGER; a_argument_count: INTEGER): STRING is
			-- Extract data from VARIANT structure.
		require
			non_void_data_descriptor: a_data_descriptor /= Void
			non_void_variable: a_variable_name /= Void
			valid_variable: not a_variable_name.is_empty
			non_void_variant: a_variant_name /= Void
			valid_variant: not a_variant_name.is_empty
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_data_descriptor.visitor
			create Result.make (1000)

			Result.append ("if (")
			Result.append (a_variant_name)
			Result.append ("->vt != ")
			Result.append (l_visitor.vt_type.out)
			Result.append (")%N%T%T%T%T{%N%T%T%T%T%T")
			Result.append ("hr = VariantChangeType (")
			Result.append (a_variant_name)
			Result.append (", ")
			Result.append (a_variant_name)
			Result.append (", VARIANT_NOUSEROVERRIDE, ")
			Result.append (l_visitor.vt_type.out)
			Result.append (");%N%T%T%T%T%T")
			Result.append (check_failer (a_argument_count, "*puArgErr = " + counter.out + ";", "DISP_E_TYPEMISMATCH"))
			Result.append ("%N%T%T%T%T}")
			if (l_visitor.is_interface_pointer or l_visitor.is_coclass_pointer) and
					not (l_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or l_visitor.c_type.substring_index (Idispatch_type, 1) > 0) then
				Result.append (l_visitor.c_type)
				Result.append (" ")
				Result.append (a_variable_name)
				Result.append (" = 0;%N%T%T%T%TIID tmp_iid_")
				Result.append_integer (counter)
				Result.append (" = ")
				Result.append (interface_descriptor_guid (a_data_descriptor, l_visitor).to_definition_string)
				Result.append (";%N%T%T%T%Tif (")
				Result.append (a_variant_name)
				Result.append ("->vt = VT_UNKNOWN)")
				Result.append (get_interface_pointer (Iunknown, a_variable_name, a_variant_name, Variant_punkval, counter))
				Result.append ("else if (")
				Result.append (a_variant_name)
				Result.append ("->vt = VT_DISPATCH)")
				Result.append (get_interface_pointer (Idispatch, a_variable_name, a_variant_name, Variant_pdispval, counter))
				Result.append ("%N%T%T%T%T")
				Result.append (check_failer (a_argument_count, "", "DISP_E_TYPEMISMATCH"))
				Result.append ("%T")
			elseif
				(l_visitor.is_interface_pointer_pointer or l_visitor.is_coclass_pointer_pointer) and
					not (l_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or l_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (l_visitor.c_type)
				Result.append (" ")
				Result.append (a_variable_name)
				Result.append (" = 0;%N%T%T%T%TIID tmp_iid_")
				Result.append_integer (counter)
				Result.append (" = ")
				Result.append (interface_descriptor_guid (a_data_descriptor, l_visitor).to_definition_string)
				Result.append (";%N%T%T%T%T")
				Result.append (interface_descriptor_c_type_name (a_data_descriptor, l_visitor))
				Result.append (" * tmp_tmp_")
				Result.append (a_variable_name)
				Result.append (" = 0;%N%T%T%T%Tif (")
				Result.append (a_variant_name)
				Result.append ("->vt = (VT_UNKNOWN |VT_BYREF))")
				Result.append (get_interface_pointer_pointer (Iunknown, a_variable_name, a_variant_name, Variant_ppunkval, counter))
				Result.append ("else if (")
				Result.append (a_variant_name)
				Result.append ("->vt = (VT_DISPATCH |VT_BYREF))")
				Result.append (get_interface_pointer_pointer (Idispatch, a_variable_name, a_variant_name, Variant_ppdispval, counter))
				Result.append (check_failer (a_argument_count, "", "DISP_E_TYPEMISMATCH"))
				Result.append ("%T")
				Result.append (a_variable_name)
				Result.append (" = &tmp_tmp_")
				Result.append (a_variable_name)
				Result.append (";%N%T%T%T%T")
			elseif l_visitor.is_structure then
				Result.append (l_visitor.c_type)
				Result.append (" ")
				Result.append (a_variable_name)
				Result.append (";%N%T%T%T%Tmemcpy (&")
				Result.append (a_variable_name)
				Result.append (", ")
				if not (l_visitor.vt_type = Vt_variant) then
					Result.append ("&(")
				end
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (vartype_namer.variant_field_name (l_visitor))
				if not (l_visitor.vt_type = Vt_variant) then
					Result.append (")")
				end
				Result.append (", sizeof (")
				Result.append (l_visitor.c_type)
				Result.append ("));%N%T%T%T")
			else
				Result.append (l_visitor.c_type)
				Result.append (" ")
				Result.append (a_variable_name)
				Result.append (" = ")
				Result.append ("(")
				Result.append (l_visitor.c_type)
				Result.append (")")
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (vartype_namer.variant_field_name (l_visitor))
				Result.append (";%N%T%T%T%T")
				Result.append (add_ref_to_interface_variable (l_visitor, a_variable_name))
			end
		ensure
			non_void_argumet: Result /= Void
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
end -- class WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER


