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
			if a_type = Vt_i1 then
				c_type.append ("char")
				eiffel_type.append ("CHARACTER")
				cecil_type.append ("EIF_CHARACTER")
				is_basic_type := True

			elseif a_type = Vt_i2 then
				c_type.append ("short")
				eiffel_type.append ("INTEGER")
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_i4 then
				c_type.append ("long")
				eiffel_type.append ("INTEGER")
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_int then
				c_type.append ("int")
				eiffel_type.append ("INTEGER")
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_ui1 then
				c_type.append ("unsigned char")
				eiffel_type.append ("CHARACTER")
				cecil_type.append ("EIF_CHARACTER")
				is_basic_type := True

			elseif a_type = Vt_ui2 then
				c_type.append ("unsigned short")
				eiffel_type.append ("INTEGER")
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_ui4 then
				c_type.append ("unsigned long")
				eiffel_type.append ("INTEGER")
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_uint then
				c_type.append ("unsigned int")
				eiffel_type.append ("INTEGER")
				cecil_type.append ("EIF_INTEGER")
				is_basic_type := True

			elseif a_type = Vt_void then
				c_type.append ("void")
				is_basic_type := True

			elseif a_type = Vt_r4 then
				c_type.append ("float")
				eiffel_type.append ("REAL")
				cecil_type.append ("EIF_REAL")
				is_basic_type := True

			elseif a_type = Vt_r8 then
				c_type.append ("double")
				eiffel_type.append ("DOUBLE")
				cecil_type.append ("EIF_DOUBLE")
				is_basic_type := True

			elseif is_boolean (a_type) then
				ce_function_name.append ("ccom_ce_boolean")
				ec_function_name.append ("ccom_ec_boolean")
				c_type.append ("VARIANT_BOOL")
				eiffel_type.append ("BOOLEAN")

			elseif is_date (a_type) then
				ce_function_name.append ("ccom_ce_date")
				ec_function_name.append ("ccom_ec_date")
				c_type.append ("DATE")
				eiffel_type.append ("DATE_TIME")
				can_free := True

			elseif is_error (a_type) or is_hresult (a_type) then
				ce_function_name.append ("ccom_ce_hresult")
				ec_function_name.append ("ccom_ec_hresult")
				c_type.append ("HRESULT")
				eiffel_type.append ("ECOM_HRESULT")
				writable := True

			elseif is_variant (a_type) then
				ce_function_name.append ("ccom_ce_variant")
				ec_function_name.append ("ccom_ec_variant")
				c_type.append ("VARIANT")
				eiffel_type.append ("ECOM_VARIANT")
				is_structure := True

			elseif is_currency (a_type) then
				ce_function_name.append ("ccom_ce_currency")
				ec_function_name.append ("ccom_ec_cyrrency")
				c_type.append ("CURRENCY")
				eiffel_type.append ("ECOM_CURRENCY")
				is_structure := True

			elseif is_decimal (a_type) then
				ce_function_name.append ("ccom_ce_decimal")
				ec_function_name.append ("ccom_ec_decimal")
				c_type.append ("DECIMAL")
				eiffel_type.append ("ECOM_DECIMAL")
				is_structure := True

			elseif is_bstr (a_type) then
				ce_function_name.append ("ccom_ce_bstr")
				ec_function_name.append ("ccom_ec_bstr")
				c_type.append ("BSTR")
				eiffel_type.append ("STRING")
				can_free := True

			elseif is_dispatch (a_type) then
				ce_function_name.append ("ccom_ce_dispatch")
				ec_function_name.append ("ccom_ec_dispatch")
				c_type.append ("IDispatch * ")
				eiffel_type.append ("ECOM_GENERIC_DISPINTERFACE")
				is_interface := True

			elseif is_unknown (a_type) then
				ce_function_name.append ("ccom_ce_unknown")
				ec_function_name.append ("ccom_ec_unknown")
				c_type.append ("IUnknown * ")
				eiffel_type.append ("ECOM_GENERIC_INTERFACE")
				is_interface := True

			elseif is_lpstr (a_type) then
				ce_function_name.append ("ccom_ce_lpstr")
				ec_function_name.append ("ccom_ec_lpstr")
				c_type.append ("LPSTR")
				eiffel_type.append ("STRING")
				can_free := True

			elseif is_lpwstr (a_type) then
				ce_function_name.append ("ccom_ce_lpwstr")
				ec_function_name.append ("ccom_ec_lpwstr")
				c_type.append ("LPWSTR")
				eiffel_type.append ("STRING")
				can_free := True

			elseif is_long_long (a_type) then
				ce_function_name.append ("ccom_ce_long_long")
				ec_function_name.append ("ccom_ec_long_long")
				c_type.append ("LARGE_INTEGER")
				eiffel_type.append ("ECOM_LARGE_INTEGER")
				is_structure := True

			elseif is_unsigned_long_long (a_type) then
				ce_function_name.append ("ccom_ce_u_long_long")
				ec_function_name.append ("ccom_ec_u_long_long")
				c_type.append ("ULARGE_INTEGER")
				eiffel_type.append ("ECOM_ULARGE_INTEGER")
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

