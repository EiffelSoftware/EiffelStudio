indexing
	description: "Wizard Array Data Type names generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
			

class
	WIZARD_ARRAY_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

feature -- Basic operations

	process (an_array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process ARRAY
		require
			valid_descriptor: an_array_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			an_element_type: INTEGER
			dimension_count: INTEGER
			local_counter: INTEGER
			array_size: ARRAY [INTEGER]
			i: INTEGER
			element_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			element_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create ce_function_name.make (0)
			create ec_function_name.make (0)

			create ce_function_signature.make (0)
			create ec_function_signature.make (0)

			create ce_function_body.make (0)
			create ec_function_body.make (0)

			create ce_function_return_type.make (0)
			create ec_function_return_type.make (0)

			create c_type.make (0)
			create c_post_type.make (0)
			create eiffel_type.make (0)

			need_generate_ce := True
			need_generate_ec := False

			dimension_count := an_array_descriptor.dimension_count
			an_element_type := an_array_descriptor.array_element_descriptor.type
			array_size := clone (an_array_descriptor.array_size)

			from
				i := array_size.lower
			until
				i > array_size.upper
			loop
				c_post_type.append (Open_bracket)
				c_post_type.append_integer (array_size.item (i))
				c_post_type.append (Close_bracket)
				i := i + 1
			end

			local_counter := counter (an_array_descriptor)

			ce_function_return_type.append (Eif_reference)

			writable := True

			create c_header_file.make (0)
			if is_character (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_char_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("char")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(CHARACTER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(CHARACTER%)")
				end

				ce_function_signature.append ("char an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_character", 
							dimension_count, array_size, True)

			elseif is_unsigned_char (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_char_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("unsigned char")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(CHARACTER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(CHARACTER%)")
				end

				ce_function_signature.append ("unsigned char an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_character", 
							dimension_count, array_size, True)

			elseif is_integer2 (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_short_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_short")

				c_type.append ("short")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
				end

				ce_function_signature.append ("short an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_short", 
							dimension_count, array_size, True)

			elseif is_unsigned_short (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_short_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_short")

				c_type.append ("unsigned short")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
				end

				ce_function_signature.append ("unsigned short an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_short", 
							dimension_count, array_size, True)

			elseif is_integer4 (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_long_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("long")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
				end

				ce_function_signature.append ("long an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_long", 
							dimension_count, array_size, True)

			elseif is_unsigned_long (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_long_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("unsigned long")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
				end

				ce_function_signature.append ("unsigned long an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_long", 
							dimension_count, array_size, True)

			elseif is_int (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_int_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("int")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
				end

				ce_function_signature.append ("int an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_long", 
							dimension_count, array_size, True)

			elseif is_unsigned_int (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_int_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("unsigned int")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
				end

				ce_function_signature.append ("unsigned int an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_long", 
							dimension_count, array_size, True)

			elseif is_real4 (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_float_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("float")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(REAL%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(REAL%)")
				end

				ce_function_signature.append ("float an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_float", 
							dimension_count, array_size, True)

			elseif is_real8 (an_element_type) then
				is_array_basic_type := True
				ce_function_name.append ("ccom_ce_array_double_")
				ce_function_name.append_integer (local_counter)

				c_type.append ("double")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(DOUBLE%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(DOUBLE%)")
				end

				ce_function_signature.append ("double an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_double", 
							dimension_count, array_size, True)

			elseif is_date (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_date_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_date")

				c_type.append ("DATE")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(DATE_TIME%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(DATE_TIME%)")
				end

				ce_function_signature.append ("DATE an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_date", 
							dimension_count, array_size, False)

			elseif is_error (an_element_type) or is_hresult (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_hresult_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_hresult")

				c_type.append ("HRESULT")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_HRESULT%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_HRESULT%)")
				end

				ce_function_signature.append ("HRESULT an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_hresult", 
							dimension_count, array_size, False)

			elseif is_variant (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_variant_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_variant")

				c_type.append ("VARIANT")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_VARIANT%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_VARIANT%)")
				end

				ce_function_signature.append ("VARIANT an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_variant", 
							dimension_count, array_size, False)

			elseif is_currency (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_currency_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_currency")

				c_type.append ("CURRENCY")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_CURRENCY%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_CURRENCY%)")
				end

				ce_function_signature.append ("CURRENCY an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_currency", 
							dimension_count, array_size, False)

			elseif is_bstr (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_bstr_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_bstr")

				c_type.append ("BSTR")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(STRING%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(STRING%)")
				end

				ce_function_signature.append ("BSTR an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_bstr", 
							dimension_count, array_size, False)

			elseif is_dispatch (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_dispatch_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_dispatch")

				c_type.append ("IDispatch (* ")
				c_post_type.prepend (")")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_GENERIC_DISPINTERFACE%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_GENERIC_DISPINTERFACE%)")
				end

				ce_function_signature.append ("IDispatch (* an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_dispatch", 
							dimension_count, array_size, False)

			elseif is_unknown (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_unknown_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_unknown")

				c_type.append ("IUnknown (* ")
				c_post_type.prepend (")")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_GENERIC_INTERFACE%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_GENERIC_INTERFACE%)")
				end

				ce_function_signature.append ("IUnknown (* an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_unknown", 
							dimension_count, array_size, False)

			elseif is_decimal (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_decimal_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_decimal")

				c_type.append ("DECIMAL")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_DECIMAL%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_DECIMAL%)")
				end

				ce_function_signature.append ("DECIMAL an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_decimal", 
							dimension_count, array_size, False)

			elseif is_boolean (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_boolean_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_boolean")

				c_type.append ("VARIANT_BOOL")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(BOOLEAN%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(BOOLAEN%)")
				end

				ce_function_signature.append ("VARIANT_BOOL an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_boolean", 
							dimension_count, array_size, False)

			elseif is_long_long (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_long_long_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_long_long")

				c_type.append ("LARGE_INTEGER")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_LARGE_INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_LARGE_INTEGER%)")
				end

				ce_function_signature.append ("LARGE_INTEGER an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_long_long", 
							dimension_count, array_size, False)

			elseif is_unsigned_long_long (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_ulong_long_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_ulong_long")

				c_type.append ("ULARGE_INTEGER")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(ECOM_ULARGE_INTEGER%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(ECOM_ULARGE_INTEGER%)")
				end

				ce_function_signature.append ("ULARGE_INTEGER an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_ulong_long", 
							dimension_count, array_size, False)

			elseif is_lpstr (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_lpstr_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_lpstr")

				c_type.append ("LPSTR")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(STRING%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(STRING%)")
				end

				ce_function_signature.append ("LPSTR an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation ("ccom_ce_array_lpstr", 
							dimension_count, array_size, False)

			elseif is_lpwstr (an_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_lpwstr_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_lpwstr")

				c_type.append ("LPWSTR")
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY %(STRING%)")
				else
					eiffel_type.append ("ECOM_ARRAY %(STRING%)")
				end

				ce_function_signature.append ("LPWSTR an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
					ce_array_function_body_automation ("ccom_ce_array_lpwstr", 
					dimension_count, array_size, False)

			elseif is_void (an_element_type) then
				add_warning (Current, void_array)

			elseif is_ptr (an_element_type) or is_safearray (an_element_type) or
					is_user_defined (an_element_type) then
				
				need_generate_ec := True
				element_descriptor := an_array_descriptor.array_element_descriptor
				create element_visitor
				element_visitor.visit (element_descriptor)
				
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_non_automation_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_non_automation")
				ec_function_name.append_integer (local_counter)

				c_type.append (element_visitor.c_type)
				if dimension_count = 1 then
					eiffel_type.append ("ARRAY ")
				else
					eiffel_type.append ("ECOM_ARRAY ")
				end
				
				eiffel_type.append (Open_bracket)
				eiffel_type.append (element_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)
				
				ce_function_signature.append (c_type)
				ce_function_signature.append (" an_array")
				ce_function_signature.append (c_post_type)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")
			
				ce_function_body := ce_array_function_body_non_automation 
						(element_visitor.ce_function_name,
						element_visitor.c_type,
						element_visitor.eiffel_type,
						dimension_count, array_size,
						element_visitor.is_structure)

				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append (A_ref)
				
				ec_function_body := ec_array_function_body_non_automation 
						(element_visitor.ec_function_name,
						element_visitor.c_type,
						element_visitor.eiffel_type,
						dimension_count, array_size,
						element_visitor.is_structure)
				
				ec_function_return_type.append (element_visitor.c_type)
				ec_function_return_type.append (Asterisk)
				
			else
				add_warning (Current, not_supported_data_type)
			end

			vt_type := an_array_descriptor.type
			set_visitor_atributes (a_visitor)
		end

feature {NONE} -- Implementation

	ce_array_function_body_automation (rt_function_name: STRING; dim_count: INTEGER; 
					element_count: ARRAY [INTEGER];
					is_basic_array: BOOLEAN): STRING is
			-- C to Eiffel function body for ARRAY (of automation data type elements).
		require
			non_void_function_name: rt_function_name /= Void
			valid_function_name:  not rt_function_name.empty
			valid_dim_count: dim_count > 0
			non_void_element_count: element_count /= Void
			valid_element_count: element_count.count = dim_count
		local
			i: INTEGER
			zero_index: STRING
		do
			create Result.make (0)

			-- EIF_INTEGER = some_element_counts [dim_count];
			--                               value of ^

			Result.append (Tab)
			Result.append (Eif_integer)
			Result.append (Space)
			Result.append ("some_element_counts")
			Result.append (Space)
			Result.append (Open_bracket)
			Result.append_integer (dim_count)
			Result.append (Close_bracket)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (New_line_tab)

			from
				i := 1
				create zero_index.make (0)
			variant
				dim_count - i + 1
			until
				i > dim_count
			loop

				-- some_element_counts [i - 1] = element_count.item (i);
				--              value of ^          value of ^

				Result.append ("some_element_counts")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append_integer (i - 1)
				Result.append (Close_bracket)
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append_integer (element_count.item (i))
				Result.append (Semicolon)
				Result.append (New_line_tab)

				zero_index.append (Open_bracket)
				zero_index.append_integer (0)
				zero_index.append (Close_bracket)

				i := i + 1
			end
			Result.append (New_line_tab)

			-- return Ce_mapper.rt_function_name (&an_array[0]..[0], dim_count, some_element_counts, an_object);
			--       value of ^                 value of ^          value of ^  value of ^

			Result.append (Return)
			Result.append (Space)
			Result.append (Ce_mapper)
			Result.append (Dot)
			Result.append (rt_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			if not is_basic_array then
				Result.append (Open_parenthesis)
				Result.append (Eif_pointer)
				Result.append (Close_parenthesis)
			end
			Result.append (Ampersand)
			Result.append ("an_array")
			Result.append (zero_index)
			Result.append (Comma)
			Result.append (Space)
			Result.append_integer (dim_count)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("some_element_counts")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("an_object")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.empty
		end

	ce_array_function_body_non_automation 
					(element_ce_function, element_c_type, element_eiffel_type: STRING;
					dim_count: INTEGER; element_count: ARRAY [INTEGER];
					is_element_structure: BOOLEAN): STRING is
			-- C to Eiffel function body for ARRAY (of non_automation data type elements).
		require
			valid_function_name: element_ce_function /= Void and then not element_ce_function.empty
			valid_c_type: element_c_type /= Void and then not element_c_type.empty
			valid_eiffel_type: element_eiffel_type /= Void and then not element_eiffel_type.empty
			valid_dim_count: dim_count > 0
			valid_element_count: element_count /= Void and then element_count.count = dim_count
		local
			i: INTEGER
			zero_index: STRING
		do
			create Result.make (0)

			-- EIF_INTEGER = some_element_counts [dim_count];
			--                               value of ^

			Result.append (Tab)
			Result.append (Eif_integer)
			Result.append (Space)
			Result.append ("some_element_counts")
			Result.append (Space)
			Result.append (Open_bracket)
			Result.append_integer (dim_count)
			Result.append (Close_bracket)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_INTEGER element_number;

			Result.append (Eif_integer)
			Result.append (Space)
			Result.append ("element_number")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append ("result")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("intermediate_array")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("eif_lower_indeces")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("eif_element_count")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_TYPE_ID type_id, int_array_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("int_array_id")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_PROCEDURE make, put;

			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append ("make")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("put")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- int i;

			Result.append (Int)
			Result.append (Space)
			Result.append ("i")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_INTEGER * lower_indeces;

			Result.append (Eif_integer)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append ("lower_indeces")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- element_c_type * an_array_element;
			-- value of ^

			Result.append (element_c_type)
			Result.append (Space)
			if is_element_structure then
				Result.append (Asterisk)
				Result.append (Space)
			end
			Result.append ("an_array_element")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			from
				i := 1
				create zero_index.make (0)
			variant
				dim_count - i + 1
			until
				i > dim_count
			loop

				-- some_element_counts [i-1] = element_count.item (i);
				--              value of ^           value of ^

				Result.append ("some_element_counts")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append_integer (i - 1)
				Result.append (Close_bracket)
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append_integer (element_count.item (i))
				Result.append (Semicolon)
				Result.append (New_line_tab)

				zero_index.append (Open_bracket)
				zero_index.append_integer (0)
				zero_index.append (Close_bracket)

				i := i + 1
			end
			Result.append (New_line_tab)

			-- type_id = eif_type_id ("ARRAY [element_eiffel_type]");
			--                               value of ^

			Result.append ("type_id")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (Array_type)
			Result.append (Space)
			Result.append (Open_bracket)
			Result.append (element_eiffel_type)
			Result.append (Close_bracket)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- make = eif_procedure ("make", type_id);

			Result.append ("make")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_procedure_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append ("make")
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- put = eif_procedure ("put", type_id);

			Result.append ("put")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_procedure_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append ("put")
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- element_number = (EIF_INTEGER)Ce_mapper.ccom_element_number (dim_count, some_element_counts);
			--                             value of ^                                  value of ^

			Result.append ("element_number")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_integer)
			Result.append (Close_parenthesis)
			Result.append (Ce_mapper)
			Result.append (Dot)
			Result.append ("ccom_element_number")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append_integer (dim_count)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("some_element_counts")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- if ((an_object == NULL) || (eif_access (an_object) == NULL))

			Result.append (If_keyword)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Open_parenthesis)
			Result.append (An_object)
			Result.append (Space)
			Result.append (C_equal)
			Result.append (Space)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (C_or)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (An_object)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (C_equal)
			Result.append (Space)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)

			-- {

			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)

			-- intermediate_array = eif_create (type_id);

			Result.append ("intermediate_array")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_create)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- make (eif_access (intermediate_array), 1, element_number);

			Result.append ("make")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("intermediate_array")
			Result.append (Close_parenthesis)
			Result.append (Comma)
			Result.append (Space)
			Result.append_integer (1)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("element_number")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- }

			Result.append (Close_curly_brace)
			Result.append (New_line_tab)

			-- else

			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)

			-- intermidiate_array = an_object;

			Result.append ("intermediate_array")
			Result.append (Space_equal_space)
			Result.append (An_object)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- for (i = 0; i < element_number; i++)

			Result.append (For)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("i")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append_integer (0)
			Result.append (Semicolon)
			Result.append (Space)
			Result.append ("i")
			Result.append (Space)
			Result.append (Less)
			Result.append (Space)
			Result.append ("element_number")
			Result.append (Semicolon)
			Result.append (Space)
			Result.append ("i")
			Result.append (Plus)
			Result.append (Plus)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)

			-- {

			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)

				-- an_array_element = (element_c_type *)&((ccom_c_array_element (an_array, i, element_c_type)));
				--                value of ^                                                               value of ^

				Result.append ("an_array_element")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (element_c_type)
				if is_element_structure then
					Result.append (Space)
					Result.append (Asterisk)
				end
				Result.append (Close_parenthesis)
				if is_element_structure then
					Result.append (Ampersand)
				end
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append ("ccom_c_array_element")
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("an_array")
				Result.append (Comma)
				Result.append (Space)
				Result.append ("i")
				Result.append (Comma)
				Result.append (Space)
				Result.append (element_c_type)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				-- put (eif_access (intermediate_array), element_ce_function ((element_c_type)*an_array_element), i + 1);
				--                                                         value of ^             value of ^

				Result.append ("put")
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("intermediate_array")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append (element_ce_function)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (element_c_type)
				if is_element_structure then
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
				else
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
				end
				Result.append ("an_array_element")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append ("i")
				Result.append (Space)
				Result.append (Plus)
				Result.append (Space)
				Result.append_integer (1)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)

			-- }

			Result.append (Close_curly_brace)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- if ((an_object == NULL) || (eif_access (an_object) == NULL))

			Result.append (If_keyword)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Open_parenthesis)
			Result.append (An_object)
			Result.append (Space)
			Result.append (C_equal)
			Result.append (Space)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (C_or)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (An_object)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (C_equal)
			Result.append (Space)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)

			-- {

			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)
			
			if (dim_count = 1) then

				Result.append ("result")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append ("intermediate_array")
				Result.append (Semicolon)
				Result.append (New_line_tab)

			else

				Result.append ("int_array_id")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_type_id_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append ("ARRAY")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("INTEGER")
				Result.append (Close_bracket)
				Result.append (Double_quote)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("make")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_procedure_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append ("make")
				Result.append (Double_quote)
				Result.append (Comma)
				Result.append (Space)
				Result.append ("int_array_id")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("eif_lower_indeces")				
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_create)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("int_array_id")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("make")
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("eif_lower_indeces")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (1)
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (dim_count)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append (New_line_tab_tab)

				Result.append ("lower_indeces")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_integer)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append (Space)
				Result.append (Calloc)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append_integer (dim_count)
				Result.append (Comma)
				Result.append (Space)
				Result.append (Sizeof)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append (For)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("i")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append_integer (0)
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i")
				Result.append (Space)
				Result.append (Less)
				Result.append (Space)
				Result.append_integer (dim_count)
				Result.append (Semicolon)
				Result.append (Space)
				Result.append ("i")
				Result.append (Plus)
				Result.append (Plus)
				Result.append (Close_parenthesis)
				Result.append (New_line_tab_tab_tab)

				Result.append ("lower_indeces")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append ("i")
				Result.append (Close_bracket)
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append_integer (1)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append (Eif_make_from_c)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("eif_lower_indeces")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append ("lower_indeces")
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (dim_count)
				Result.append (Comma)
				Result.append (Space)
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append (Free)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("lower_indeces")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("eif_element_count")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_create)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("int_array_id")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("make")
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("eif_element_count")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (1)
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (dim_count)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append (Eif_make_from_c)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("eif_element_count")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append ("some_element_counts")
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (dim_count)
				Result.append (Comma)
				Result.append (Space)
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("type_id")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_type_id_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append ("ECOM_ARRAY")
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append (element_eiffel_type)
				Result.append (Close_bracket)
				Result.append (Double_quote)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)	

				Result.append ("make")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_procedure_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append ("make_from_array")
				Result.append (Double_quote)
				Result.append (Comma)
				Result.append (Space)
				Result.append ("type_id")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("result")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Eif_create)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("type_id")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append ("make")
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("result")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append (Eif_access)
				Result.append (Open_parenthesis)
				Result.append ("intermediate_array")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append_integer (dim_count)
				Result.append (Comma)
				Result.append (Space)
				Result.append (Eif_access)
				Result.append (Open_parenthesis)
				Result.append ("eif_lower_indeces")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append (Eif_access)
				Result.append (Open_parenthesis)
				Result.append ("eif_element_count")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)

				Result.append (Eif_wean)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("intermediate_array")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)
			end
			
			Result.append (Return)
			Result.append (Space)
			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("result")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- }

			Result.append (Close_curly_brace)
			Result.append (New_line_tab)
			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)

			Result.append (Return)
			Result.append (Space)
			Result.append (Null)
			Result.append (Semicolon)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	ec_array_function_body_non_automation (element_ec_function, element_c_type, element_eiffel_type: STRING;
						dim_count: INTEGER; element_count: ARRAY [INTEGER];
						is_element_structure: BOOLEAN): STRING is
				-- C to Eiffel function body for ARRAY (of non_automation data type elements).
		require
			non_void_element_ec_function: element_ec_function /= Void
			valid_element_ec_function: not element_ec_function.empty
			non_void_element_c_type: element_c_type /= Void
			valid_element_c_type: not element_c_type.empty
			non_void_element_eiffel_type: element_eiffel_type /= Void
			valid_element_eiffel_type: not element_eiffel_type.empty
			valid_dim_count: dim_count > 0
			valid_element_count: element_count /= Void and then element_count.count = dim_count
		do
			create Result.make (0)
			Result.append (Tab)
			
			-- EIF_OBJECT eif_array;
			
			Result.append (Eif_object)
			Result.append (Space)
			Result.append (Eif_array)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- EIF_TYPE_ID type_id;
			
			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append (Type_id)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- EIF_REFERENCE_FUNCTION item;
			
			Result.append (Eif_reference_function)
			Result.append (Space)
			Result.append (Item_clause)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- EIF_INTEGER_FUNCTION count;
			
			Result.append (Eif_integer_function)
			Result.append (Space)
			Result.append (Count_word)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- `element_c_type' * array;
			
			Result.append (element_c_type)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append (Array_word)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- `element_c_type' an_element;
			
			Result.append (element_c_type)
			Result.append (Space)
			Result.append (An_element)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- int a_count, i;
			
			Result.append (Int)
			Result.append (Space)
			Result.append (A_count_word)
			Result.append (Comma_space)
			Result.append ("i")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)
			
			-- eif_array = eif_protect (a_ref);
			
			Result.append (Eif_array)
			Result.append (Space_equal_space)
			Result.append (Eif_protect)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (A_ref)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			if (dim_count > 1) then
				-- type_id = eif_type_id ("ECOM_ARRAY [`element_eiffel_type']");
				
				Result.append (Type_id)
				Result.append (Space_equal_space)
				Result.append (Eif_type_id_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append (Ecom_array_type)
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append (element_eiffel_type)
				Result.append (Close_bracket)
				Result.append (Double_quote)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
				
				-- item = eif_reference_function ("array_item", type_id);
				
				Result.append (Item_clause)
				Result.append (Space_equal_space)
				Result.append (Eif_reference_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append (Array_item)
				Result.append (Double_quote)
				Result.append (Comma_space)
				Result.append (Type_id)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
				
			else
				-- type_id = eif_type_id ("ARRAY [`element_eiffel_type']");
				
				Result.append (Type_id)
				Result.append (Space_equal_space)
				Result.append (Eif_type_id_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append (Array_type)
				Result.append (Space)
				Result.append (Open_bracket)
				Result.append (element_eiffel_type)
				Result.append (Close_bracket)
				Result.append (Double_quote)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
				
				-- item = eif_reference_function ("item", type_id);

				Result.append (Item_clause)
				Result.append (Space_equal_space)
				Result.append (Eif_reference_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Double_quote)
				Result.append (Item_clause)
				Result.append (Double_quote)
				Result.append (Comma_space)
				Result.append (Type_id)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
								
			end
			
			-- count = eif_integer_function ("count", type_id);
			
			Result.append (Count_word)
			Result.append (Space_equal_space)
			Result.append (Eif_integer_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (Count_word)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- a_count = (int) count (eif_access (eif_array));
			
			Result.append (A_count_word)
			Result.append (Space_equal_space)
			Result.append (Open_parenthesis)
			Result.append (Int)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (Count_word)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_array)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- array = (`element_c_type' *) CoTaskMemAlloc (a_count * sizeof (`element_c_type'));
			
			Result.append (Array_word)
			Result.append (Space_equal_space)
			Result.append (Open_parenthesis)
			Result.append (element_c_type)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (Co_task_mem_alloc)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (A_count_word)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append (Sizeof)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (element_c_type)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- for (i = 0; i < a_count; i++)
			
			Result.append (For)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("i")
			Result.append (Space_equal_space)
			Result.append_integer (0)
			Result.append (Semicolon)
			Result.append (Space)
			Result.append ("i")
			Result.append (Space)
			Result.append (Less)
			Result.append (Space)
			Result.append (A_count_word)
			Result.append (Semicolon)
			Result.append (Space)
			Result.append ("i")
			Result.append (Plus)
			Result.append (Plus)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)
			
			-- {
			
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)
			
			--  	an_element = `element_ec_function' 
			--						(item (eif_access (eif_array), (EIF_INTEGER) (i + 1)));
			
				Result.append (An_element)
				Result.append (Space_equal_space)
				Result.append (element_ec_function)
				Result.append (Space_open_parenthesis)
				Result.append (Item_clause)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Eif_array)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Open_parenthesis)
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("i")
				Result.append (Space)
				Result.append (Plus)
				Result.append (Space)
				Result.append_integer (1)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab)
				
				if is_element_structure then
					-- memcpy (((`element_c_type' *) array + i), &an_element, sizeof (`element_c_type'));
					
					Result.append (Memcpy)
					Result.append (Open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (element_c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
					Result.append (Space)
					Result.append (Array_word)
					Result.append (Space)
					Result.append (Plus)
					Result.append (Space)
					Result.append ("i")
					Result.append (Close_parenthesis)
					Result.append (Comma_space)
					Result.append (Ampersand)
					Result.append (An_element)
					Result.append (Comma_space)
					Result.append (Sizeof)
					Result.append (Space)
					Result.append (Open_parenthesis)
					Result.append (element_c_type)
					Result.append (Close_parenthesis)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)
					
				else
					-- *((`element_c_type' *) array + i) = an_element;
					
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (element_c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
					Result.append (Space)
					Result.append (Array_word)
					Result.append (Space)
					Result.append (Plus)
					Result.append (Space)
					Result.append ("i")
					Result.append (Close_parenthesis)
					Result.append (Space_equal_space)
					Result.append (An_element)
					Result.append (Semicolon)
					Result.append (New_line_tab)
					
				end
			-- }
			
			Result.append (Close_curly_brace)
			Result.append (New_line_tab)
			
			-- eif_wean (eif_array);
			
			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_array)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- return array;
			
			Result.append (Return)
			Result.append (Space)
			Result.append (Array_word)
			Result.append (Semicolon)

		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end
end -- class WIZARD_ARRAY_DATA_TYPE_GENERATOR

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

