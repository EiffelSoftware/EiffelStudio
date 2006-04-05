indexing
	description: "Wizard Automation Data Type names generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_AUTOMATION_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR


feature -- Basic operations

	process (an_automation_descriptor: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR; a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process Automation Data Type
		require
			non_void_descriptor: an_automation_descriptor /= Void
			non_void_visitor: a_visitor /= Void
		local
			a_type: INTEGER
		do
			create ce_function_name.make (100)
			create ec_function_name.make (100)
			create c_type.make (50)
			create eiffel_type.make (50)
			create cecil_type.make (50)

			need_generate_ce := False
			need_generate_ec := False

			need_free_memory := False
			need_generate_free_memory := False

			a_type := an_automation_descriptor.type
			c_type := vartype_namer.c_name (a_type)
			eiffel_type := vartype_namer.eiffel_name (a_type)
			vt_type := a_type

			if a_type = Vt_i1 then
				cecil_type.append ("EIF_CHARACTER")
				is_basic_type := True

			elseif a_type = Vt_i2 then
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_i4 then
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_int then
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_ui1 then
				cecil_type.append ("EIF_CHARACTER")
				is_basic_type := True

			elseif a_type = Vt_ui2 then
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_ui4 then
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_uint then
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_i8 then
				cecil_type.append ("EIF_INTEGER_64")
				is_basic_type := True 
				
			elseif a_type = Vt_ui8 then
				cecil_type.append ("EIF_INTEGER_64")
				is_basic_type := True 
				
			elseif a_type = Vt_void or a_type = Vt_empty then
				is_basic_type := True

			elseif a_type = Vt_r4 then
				cecil_type.append ("EIF_REAL")
				is_basic_type := True

			elseif a_type = Vt_r8 then
				cecil_type.append ("EIF_DOUBLE")
				is_basic_type := True

			elseif a_type = Vt_bool then
				cecil_type.append ("EIF_BOOLEAN")
				ce_function_name.append ("ccom_ce_boolean")
				ec_function_name.append ("ccom_ec_boolean")

			elseif is_date (a_type) then
				ce_function_name.append ("ccom_ce_date")
				ec_function_name.append ("ccom_ec_date")
				can_free := True

			elseif is_error (a_type) or is_hresult (a_type) then
				ce_function_name.append ("ccom_ce_hresult")
				ec_function_name.append ("ccom_ec_hresult")

			elseif is_variant (a_type) then
				ce_function_name.append ("ccom_ce_variant")
				ec_function_name.append ("ccom_ec_variant")
				is_structure := True

			elseif is_currency (a_type) then
				ce_function_name.append ("ccom_ce_currency")
				ec_function_name.append ("ccom_ec_currency")
				is_structure := True

			elseif is_decimal (a_type) then
				ce_function_name.append ("ccom_ce_decimal")
				ec_function_name.append ("ccom_ec_decimal")
				is_structure := True

			elseif is_bstr (a_type) then
				ce_function_name.append ("ccom_ce_bstr")
				ec_function_name.append ("ccom_ec_bstr")
				can_free := True
				need_free_memory := True
				free_memory_function_name := "rt_ce.free_memory_bstr"

			elseif is_idispatch (a_type) then
				ce_function_name.append ("ccom_ce_pointed_dispatch")
				ec_function_name.append ("ccom_ec_dispatch")
				is_interface_pointer := True

			elseif is_iunknown (a_type) then
				ce_function_name.append ("ccom_ce_pointed_unknown")
				ec_function_name.append ("ccom_ec_unknown")
				is_interface_pointer := True

			elseif is_lpstr (a_type) then
				ce_function_name.append ("ccom_ce_lpstr")
				ec_function_name.append ("ccom_ec_lpstr")
				can_free := True
				writable := True

			elseif is_lpwstr (a_type) then
				ce_function_name.append ("ccom_ce_lpwstr")
				ec_function_name.append ("ccom_ec_lpwstr")
				can_free := True
				writable := True
			else
				message_output.add_warning ("Data type is not supported")
			end

			create c_definition_header_file_name.make (0)
			create c_post_type.make (0)
			set_visitor_atributes (a_visitor)
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
end -- class WIZARD_AUTOMATION_DATA_TYPE_GENERATOR

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

