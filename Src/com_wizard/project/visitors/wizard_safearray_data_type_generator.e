indexing
	description: "SAFEARRAY data type Generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SAFEARRAY_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

feature -- Basic operations

	process (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process SAFEARRAY
		require
			valid_descriptor: a_safearray_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			an_element_type: INTEGER
		do
			create ce_function_name.make (0)
			create ec_function_name.make (0)
			create c_type.make (0)
			create c_post_type.make (0)
			create eiffel_type.make (0)

			need_generate_ce := False
			need_generate_ec := False

			an_element_type := a_safearray_descriptor.array_element_descriptor.type
			vt_type := binary_or (an_element_type, Vt_array)

			if is_unsigned_char (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_char")
				ec_function_name.append ("ccom_ec_safearray_char")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(CHARACTER%)")

			elseif is_integer2 (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_short")
				ec_function_name.append ("ccom_ec_safearray_short")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")

			elseif is_integer4 (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_long")
				ec_function_name.append ("ccom_ec_safearray_long")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")

			elseif is_real4 (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_float")
				ec_function_name.append ("ccom_ec_safearray_float")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(REAL%)")

			elseif is_real8 (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_double")
				ec_function_name.append ("ccom_ec_safearray_double")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(DOUBLE%)")

			elseif is_boolean (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_boolean")
				ec_function_name.append ("ccom_ec_safearray_boolean")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(BOOLEAN%)")

			elseif is_date (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_date")
				ec_function_name.append ("ccom_ec_safearray_date")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(DATE_TIME%)")

			elseif is_error (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_hresult")
				ec_function_name.append ("ccom_ec_safearray_hresult")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_HRESULT%)")

			elseif is_variant (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_variant")
				ec_function_name.append ("ccom_ec_safearray_variant")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_VARIANT%)")

			elseif is_currency (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_currency")
				ec_function_name.append ("ccom_ec_safearray_currency")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_CURRENCY%)")

			elseif is_bstr (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_bstr")
				ec_function_name.append ("ccom_ec_safearray_bstr")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(STRING%)")

			elseif is_dispatch (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_dispatch")
				ec_function_name.append ("ccom_ec_safearray_dispatch")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_GENERIC_DISPINTERFACE%)")

			elseif is_unknown (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_unknown")
				ec_function_name.append ("ccom_ec_safearray_unknown")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_GENERIC_INTERFACE%)")

			elseif is_decimal (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_decimal")
				ec_function_name.append ("ccom_ec_safearray_decimal")
				c_type.append ("SAFEARRAY * ")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_DECIMAL%)")

			else
				message_output.add_warning (Current, message_output.Unknown_type_of_safearray_element)
			end
			set_visitor_atributes (a_visitor)
		end

end -- class WIZARD_SAFEARRAY_DATA_TYPE_GENERATOR

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

