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
			create ce_function_name.make (100)
			create ec_function_name.make (100)

			create ce_function_signature.make (100)
			create ec_function_signature.make (100)

			create ce_function_body.make (100)
			create ec_function_body.make (100)

			create ce_function_return_type.make (100)
			create ec_function_return_type.make (100)

			create c_type.make (50)
			create c_post_type.make (0)
			create eiffel_type.make (50)

			need_generate_ce := True
			need_generate_ec := True

			dimension_count := an_array_descriptor.dimension_count
			element_descriptor := an_array_descriptor.array_element_descriptor
			element_visitor := element_descriptor.visitor
			an_element_type := element_visitor.vt_type
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

			create c_header_file.make (100)

			if is_void (an_element_type) then
				message_output.add_warning (Current, message_output.void_array)

			elseif is_ptr (an_element_type) or is_safearray (an_element_type) or
					is_user_defined (an_element_type) then
								
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_non_automation_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_array_non_automation")
				ec_function_name.append_integer (local_counter)

				c_type.append (element_visitor.c_type)
				if dimension_count = 1 then
					eiffel_type.append (Array_type)
				else
					eiffel_type.append (Ecom_array_type)
				end
				
				eiffel_type.append (Open_bracket)
				eiffel_type.append (element_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)
				
				ce_function_signature.append (c_type)
				ce_function_signature.append (Asterisk)
				ce_function_signature.append (Space)
				ce_function_signature.append (An_array)
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
				ec_function_signature.append (Comma_space)
				ec_function_signature.append (c_type)
				ec_function_signature.append (Asterisk)
				ec_function_signature.append (Space)
				ec_function_signature.append (Old_keyword)
				
				ec_function_body := ec_array_function_body_non_automation 
						(element_visitor.ec_function_name,
						element_visitor.c_type,
						element_visitor.eiffel_type,
						dimension_count, array_size,
						element_visitor.is_structure)
				
				ec_function_return_type.append (element_visitor.c_type)
				ec_function_return_type.append (Asterisk)
				

			else 
				is_array_basic_type := element_visitor.is_basic_type
				ce_function_name.append ("ccom_ce_array_")
				ce_function_name.append (element_visitor.c_type)
				ce_function_name.append (Underscore)
				ce_function_name.append_integer (local_counter)
				to_legal_name_for_c_function (ce_function_name)

				ec_function_name.append ("ccom_ec_array_automation")
				ec_function_name.append_integer (local_counter)

				c_type := clone  (element_visitor.c_type)
				if dimension_count = 1 then
					eiffel_type.append (Array_type)
				else
					eiffel_type.append (Ecom_array_type)
				end
				eiffel_type.append (Space)
				eiffel_type.append (Open_bracket)
				eiffel_type.append (element_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)

				ce_function_signature.append (c_type)
				ce_function_signature.append (Asterisk)
				ce_function_signature.append (Space)
				ce_function_signature.append (An_array)
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_body := 
						ce_array_function_body_automation (vartype_namer.ce_array_function_name (element_visitor.vt_type), 
							dimension_count, array_size, is_array_basic_type)

				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append (A_ref)
				ec_function_signature.append (Comma_space)
				ec_function_signature.append (c_type)
				ec_function_signature.append (Asterisk)
				ec_function_signature.append (Space)
				ec_function_signature.append (Old_keyword)

				ec_function_body := ec_array_function_body_automation 
					(vartype_namer.ec_array_function_name (element_visitor.vt_type),
					dimension_count, element_visitor.need_generate_ec)

				ec_function_return_type.append (element_visitor.c_type)
				ec_function_return_type.append (Asterisk)
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
			valid_function_name:  not rt_function_name.is_empty
			valid_dim_count: dim_count > 0
			non_void_element_count: element_count /= Void
			valid_element_count: element_count.count = dim_count
		local
			i: INTEGER
			zero_index: STRING
		do
			create Result.make (10000)

			-- EIF_INTEGER  some_element_counts [dim_count];
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
				create zero_index.make (50)
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
			Result.append ("an_array")
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
			non_empty_result: not Result.is_empty
		end

	ce_array_function_body_non_automation 
					(element_ce_function, element_c_type, element_eiffel_type: STRING;
					dim_count: INTEGER; element_count: ARRAY [INTEGER];
					is_element_structure: BOOLEAN): STRING is
			-- C to Eiffel function body for ARRAY (of non_automation data type elements).
		require
			valid_function_name: element_ce_function /= Void and then not element_ce_function.is_empty
			valid_c_type: element_c_type /= Void and then not element_c_type.is_empty
			valid_eiffel_type: element_eiffel_type /= Void and then not element_eiffel_type.is_empty
			valid_dim_count: dim_count > 0
			valid_element_count: element_count /= Void and then element_count.count = dim_count
		local
			i: INTEGER
			zero_index: STRING
		do
			create Result.make (10000)

			-- EIF_INTEGER some_element_counts [dim_count];
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

			-- EIF_OBJECT result, intermediate_array, eif_lower_indices, eif_element_count;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append ("result")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("intermediate_array")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("eif_lower_indices")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("eif_element_count")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_TYPE_ID type_id, int_array_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Space_equal_space)
			Result.append (Minus)
			Result.append (One)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("int_array_id")
			Result.append (Space_equal_space)
			Result.append (Minus)
			Result.append (One)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_PROCEDURE make, put;

			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append ("make")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("put")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- int i;

			Result.append (Int)
			Result.append (Space)
			Result.append ("i")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_INTEGER * lower_indices;

			Result.append (Eif_integer)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append ("lower_indices")
			Result.append (Space_equal_space)
			Result.append (Zero)
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
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			from
				i := 1
				create zero_index.make (50)
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

				-- an_array_element = (element_c_type *)(&(ccom_c_array_element (an_array, i, element_c_type)));
				--                value of ^                                                               value of ^

				Result.append ("an_array_element")
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (element_c_type)

				if is_element_structure then
					Result.append (Asterisk)
				end

				Result.append (Close_parenthesis)
				Result.append (Open_parenthesis)

				if is_element_structure then
					Result.append (Ampersand)
				end

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

				-- put (eif_access (intermediate_array), element_ce_function ((element_c_type)an_array_element), i + 1);
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

				if is_element_structure then
 					Result.append (Asterisk)
				end
				Result.append (Open_parenthesis)
				Result.append (element_c_type)
				if is_element_structure then
					Result.append (Asterisk)
				end
				Result.append (Close_parenthesis)
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

				Result.append ("eif_lower_indices")				
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
				Result.append ("eif_lower_indices")
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

				Result.append ("lower_indices")
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

				Result.append ("lower_indices")
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
				Result.append ("eif_lower_indices")
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space)
				Result.append ("lower_indices")
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
				Result.append ("lower_indices")
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
				Result.append ("eif_lower_indices")
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
			valid_body: not Result.is_empty
		end

	ec_array_function_body_automation (rt_function_name: STRING; dim_count: INTEGER; need_generate: BOOLEAN): STRING is
			--
		require
			non_void_rt_function_name: rt_function_name /= Void
			valid_rt_function_name: not rt_function_name.is_empty
			valid_dim_count: dim_count > 0
		do
			create Result.make (10000)

			-- return ec_mapper.`rt_functuion_name' (`A_ref', `dim_count', `Old_keyword');

			Result.append (Tab)
			Result.append (Return)
			Result.append (Space)
			if need_generate then
				Result.append (Generated_ec_mapper)
			else
				Result.append (Ec_mapper)
			end
			Result.append (Dot)
			Result.append (rt_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (A_ref)
			Result.append (Comma_space)
			Result.append_integer (dim_count)
			Result.append (Comma_space)
			Result.append (Old_keyword)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	ec_array_function_body_non_automation (element_ec_function, element_c_type, element_eiffel_type: STRING;
						dim_count: INTEGER; element_count: ARRAY [INTEGER];
						is_element_structure: BOOLEAN): STRING is
				-- C to Eiffel function body for ARRAY (of non_automation data type elements).
		require
			non_void_element_ec_function: element_ec_function /= Void
			valid_element_ec_function: not element_ec_function.is_empty
			non_void_element_c_type: element_c_type /= Void
			valid_element_c_type: not element_c_type.is_empty
			non_void_element_eiffel_type: element_eiffel_type /= Void
			valid_element_eiffel_type: not element_eiffel_type.is_empty
			valid_dim_count: dim_count > 0
			valid_element_count: element_count /= Void and then element_count.count = dim_count
		do
			create Result.make (10000)
			Result.append (Tab)
			
			-- EIF_OBJECT eif_array;
			
			Result.append (Eif_object)
			Result.append (Space)
			Result.append (Eif_array)
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- EIF_TYPE_ID type_id;
			
			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append (Type_id)
			Result.append (Space_equal_space)
			Result.append (Minus)
			Result.append (One)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- EIF_REFERENCE_FUNCTION item;
			
			Result.append (Eif_reference_function)
			Result.append (Space)
			Result.append (Item_clause)
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- EIF_INTEGER_FUNCTION count;
			
			Result.append (Eif_integer_function)
			Result.append (Space)
			Result.append (Count_word)
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- `element_c_type' * array;
			
			Result.append (element_c_type)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append (Array_word)
			Result.append (Space_equal_space)
			Result.append (Zero)
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
			

			-- if (old != NULL)

			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Old_keyword)
			Result.append (Space)
			Result.append (C_not_equal)
			Result.append (Space)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)

			-- {

			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)

			-- 	memcpy (old, array, a_count * sizeof (`element_c_type'));

			Result.append (Memcpy)
			Result.append (Space_open_parenthesis)
			Result.append (Old_keyword)
			Result.append (Comma_space)
			Result.append (Array_word)
			Result.append (Comma_space)
			Result.append (A_count_word)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append (Sizeof)
			Result.append (Space_open_parenthesis)
			Result.append (element_c_type)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)

			-- 	return NULL;

			Result.append (Return)
			Result.append (Space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- }

			Result.append (Close_curly_brace)
			Result.append (New_line_tab)

			-- else

			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)

			-- 	return array;
			
			Result.append (Return)
			Result.append (Space)
			Result.append (Array_word)
			Result.append (Semicolon)

		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
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

