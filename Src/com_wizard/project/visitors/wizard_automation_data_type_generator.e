indexing
	description: "Wizard Automation Data Type names generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_AUTOMATION_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR


feature -- Basic operations

	process (an_automation_descriptor: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR;
				a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process Automation Data Type
		require
			non_void_descriptor: an_automation_descriptor /= Void
			non_void_visitor: a_visitor /= Void
		local
			a_type: INTEGER
		do
			create ce_function_name.make (0)
			create ec_function_name.make (0)
			create c_type.make (0)
			create eiffel_type.make (0)
			create cecil_type.make (0)

			need_generate_ce := False
			need_generate_ec := False

			a_type := an_automation_descriptor.type
			c_type := vartype_namer.c_name (a_type)
			eiffel_type := vartype_namer.eiffel_name (a_type)

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

			elseif a_type = Vt_void then
				c_type.append ("void")
				is_basic_type := True

			elseif a_type = Vt_r4 then
				cecil_type.append ("EIF_REAL")
				is_basic_type := True

			elseif a_type = Vt_r8 then
				cecil_type.append ("EIF_DOUBLE")
				is_basic_type := True

			elseif is_boolean (a_type) then
				ce_function_name.append ("ccom_ce_boolean")
				ec_function_name.append ("ccom_ec_boolean")

			elseif is_date (a_type) then
				ce_function_name.append ("ccom_ce_date")
				ec_function_name.append ("ccom_ec_date")
				can_free := True

			elseif is_error (a_type) or is_hresult (a_type) then
				ce_function_name.append ("ccom_ce_hresult")
				ec_function_name.append ("ccom_ec_hresult")
				writable := True

			elseif is_variant (a_type) then
				ce_function_name.append ("ccom_ce_variant")
				ec_function_name.append ("ccom_ec_variant")
				is_structure := True

			elseif is_currency (a_type) then
				ce_function_name.append ("ccom_ce_currency")
				ec_function_name.append ("ccom_ec_cyrrency")
				is_structure := True

			elseif is_decimal (a_type) then
				ce_function_name.append ("ccom_ce_decimal")
				ec_function_name.append ("ccom_ec_decimal")
				is_structure := True

			elseif is_bstr (a_type) then
				ce_function_name.append ("ccom_ce_bstr")
				ec_function_name.append ("ccom_ec_bstr")
				can_free := True

			elseif is_dispatch (a_type) then
				ce_function_name.append ("ccom_ce_dispatch")
				ec_function_name.append ("ccom_ec_dispatch")
				is_interface := True

			elseif is_unknown (a_type) then
				ce_function_name.append ("ccom_ce_unknown")
				ec_function_name.append ("ccom_ec_unknown")
				is_interface := True

			elseif is_lpstr (a_type) then
				ce_function_name.append ("ccom_ce_lpstr")
				ec_function_name.append ("ccom_ec_lpstr")
				can_free := True

			elseif is_lpwstr (a_type) then
				ce_function_name.append ("ccom_ce_lpwstr")
				ec_function_name.append ("ccom_ec_lpwstr")
				can_free := True

			elseif is_long_long (a_type) then
				ce_function_name.append ("ccom_ce_long_long")
				ec_function_name.append ("ccom_ec_long_long")
				is_structure := True

			elseif is_unsigned_long_long (a_type) then
				ce_function_name.append ("ccom_ce_u_long_long")
				ec_function_name.append ("ccom_ec_u_long_long")
				is_structure := True
			else
				add_warning (Current, not_supported_data_type)

			end

			vt_type := a_type
			create c_header_file.make (0)
			create c_post_type.make (0)
			set_visitor_atributes (a_visitor)
		end

end -- class WIZARD_AUTOMATION_DATA_TYPE_GENERATOR

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

