indexing
	description: "Wizard Pointed Data Type names generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_POINTED_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

	ECOM_VAR_TYPE

feature -- Basic operations

	process (a_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR; 
					a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process Pointed Data Type
		require
			valid_descriptor: a_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			pointed_visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			a_type: INTEGER
			local_counter: INTEGER
		do
			create pointed_visitor
			pointed_visitor.visit (a_descriptor.pointed_data_type_descriptor)

			vt_type := binary_or (pointed_visitor.vt_type, Vt_byref)
			c_type := clone (pointed_visitor.c_type)
			c_type.append (Space)
			c_type.append (Asterisk)

			c_post_type := clone (pointed_visitor.c_post_type)
			c_header_file := clone (pointed_visitor.c_header_file)

			create ce_function_name.make (0)
			create ec_function_name.make (0)
			local_counter := counter (a_descriptor)

			if pointed_visitor.is_structure then
				is_structure_pointer := True
				eiffel_type := clone (pointed_visitor.eiffel_type)

				need_generate_ce := True
				need_generate_ec := True

				ce_function_name.append ("ccom_ce_pointed_record_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_record_")
				ec_function_name.append_integer (local_counter)

				create ce_function_signature.make (0)
				ce_function_signature.append (c_type)
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_record_pointer")

				ce_function_return_type := clone (Eif_reference)
				ce_function_body := ce_function_body_record (eiffel_type)

				create ec_function_signature.make (0)
				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append ("eif_ref")

				ec_function_return_type := clone (c_type)

				ec_function_body := ec_function_wrapper (eiffel_type, c_type)

				can_free := True
				writable := False

			elseif pointed_visitor.is_interface then
				is_interface_pointer := True
				eiffel_type := clone (pointed_visitor.eiffel_type)

				ce_function_name.append ("ccom_ce_pointed_interface_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_interface_")
				ec_function_name.append_integer (local_counter)


				need_generate_ce := True
				need_generate_ec := True

				create ce_function_signature.make (0)
				ce_function_signature.append (c_type)
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_interface_pointer")

				ce_function_body := ce_function_body_interface (eiffel_type)
				ce_function_return_type := clone (Eif_reference)

				create ec_function_signature.make (0)
				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append ("eif_ref")

				ec_function_return_type := clone (c_type)

				ec_function_body := ec_function_wrapper (eiffel_type, c_type)

				can_free := True
				writable := False

			elseif pointed_visitor.is_coclass then
				is_coclass_pointer := True
				eiffel_type := clone (pointed_visitor.eiffel_type)

				ce_function_name.append ("ccom_ce_pointed_coclass_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_coclass_")
				ec_function_name.append_integer (local_counter)


				need_generate_ce := True
				need_generate_ec := True

				create ce_function_signature.make (0)
				ce_function_signature.append (c_type)
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_interface_pointer")

				ce_function_body := ce_function_body_interface (eiffel_type)
				ce_function_return_type := clone (Eif_reference)

				create ec_function_signature.make (0)
				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append ("eif_ref")

				ec_function_return_type := clone (c_type)

				ec_function_body := ec_function_wrapper (eiffel_type, c_type)

				can_free := True
				writable := False

			elseif pointed_visitor.is_basic_type or pointed_visitor.vt_type = Vt_bool  
			then
				is_basic_type_ref := True
				pointed_descriptor := a_descriptor.pointed_data_type_descriptor
				a_type := pointed_visitor.vt_type
				create eiffel_type.make (0)
				create ce_function_name.make (0)
				create ec_function_name.make (0)
				can_free := True
				writable := True

				if is_character (a_type) or is_unsigned_char (a_type) then
					eiffel_type.append (Character_ref_type)
					ec_function_name.append ("ccom_ec_pointed_character")
					ce_function_name.append ("ccom_ce_pointed_character")
					
				elseif is_integer4 (a_type) or is_unsigned_long (a_type) 
							or is_int (a_type) or is_unsigned_int (a_type) then
					eiffel_type.append (Integer_ref_type)
					ec_function_name.append ("ccom_ec_pointed_long")
					ce_function_name.append ("ccom_ce_pointed_long")

				elseif is_integer2 (a_type) or is_unsigned_short (a_type) then
					eiffel_type.append (Integer_ref_type)
					ec_function_name.append ("ccom_ec_pointed_short")
					ce_function_name.append ("ccom_ce_pointed_short")

				elseif is_real4 (a_type) then 
					eiffel_type.append (Real_ref_type)
					ec_function_name.append ("ccom_ec_pointed_real")
					ce_function_name.append ("ccom_ce_pointed_real")

				elseif is_real8 (a_type) then
					eiffel_type.append (Double_ref_type)
					ec_function_name.append ("ccom_ec_pointed_double")
					ce_function_name.append ("ccom_ce_pointed_double")

				elseif is_boolean (a_type) then
					eiffel_type.append (Boolean_ref_type)
					ec_function_name.append ("ccom_ec_pointed_boolean")
					ce_function_name.append ("ccom_ce_pointed_boolean")

				elseif is_void (a_type) then
					is_basic_type_ref := False
					if is_byref (a_type ) then
						eiffel_type.append (Cell_pointer)
						ec_function_name.append ("ccom_ec_pointed_pointer")
						ce_function_name.append ("ccom_ce_pointed_pointer")
						writable := True
					else
						eiffel_type.append (Pointer_type)
						is_basic_type := True
						cecil_type := (Eif_pointer)
						writable := False
					end
				end

			elseif pointed_visitor.is_enumeration then
				is_basic_type_ref := True

				create eiffel_type.make (0)
				eiffel_type.append (Integer_ref_type)
				writable := True

				create ce_function_name.make (0)
				create ec_function_name.make (0)
				ec_function_name.append ("ccom_ec_pointed_long")
				ce_function_name.append ("ccom_ce_pointed_long")

			else
				if pointed_visitor.is_interface_pointer then
					is_interface_pointer_pointer := True
				end

				if pointed_visitor.is_coclass_pointer then
					is_coclass_pointer_pointer := True
				end

				create eiffel_type.make (0)
				eiffel_type.append ("CELL")
				eiffel_type.append (Space)
				eiffel_type.append (Open_bracket)
				eiffel_type.append (pointed_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)

				need_generate_ce := True
				need_generate_ec := True

				can_free := True
				writable := True

				ce_function_name.append ("ccom_ce_pointed_cell_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_cell_")
				ec_function_name.append_integer (local_counter)

				create ce_function_signature.make (0)
				ce_function_signature.append (c_type)
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_pointer")
				ce_function_signature.append (Comma_space)
				ce_function_signature.append (Eif_object)
				ce_function_signature.append (Space)
				ce_function_signature.append ("an_object")

				ce_function_return_type := clone (Eif_reference)
				ce_function_body := ce_function_body_cell (c_type, pointed_visitor.ce_function_name, 
					pointed_visitor.eiffel_type, pointed_visitor.can_free, 
					pointed_visitor.need_generate_ce, pointed_visitor.writable)

				create ec_function_signature.make (0)
				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append ("eif_ref")
				ec_function_signature.append (Comma_space)
				ec_function_signature.append (c_type)
				ec_function_signature.append (Space)
				ec_function_signature.append (Old_keyword)

				ec_function_return_type := clone (c_type)

				ec_function_body := ec_function_body_cell (pointed_visitor.eiffel_type, pointed_visitor.c_type, 
					pointed_visitor.ec_function_name, pointed_visitor.need_generate_ec, pointed_visitor.writable)

			end
			set_visitor_atributes (a_visitor)
		end

feature {NONE} -- Implementation

	ce_function_body_record (a_class_name: STRING): STRING is
			-- C to Eiffel function body, if type is pointer to record.
		require
			valid_name: a_class_name /= Void and then not a_class_name.empty
		do
			create Result.make (0)

			Result.append (tab)
			Result.append (Return)
			Result.append (Space)
			Result.append (Ce_mapper)
			Result.append (Dot)
			Result.append ("ccom_ce_pointed_record")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("a_record_pointer")
			Result.append (Comma)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append (a_class_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			valid_result: Result /= Void and then not Result.empty
		end
 
	ce_function_body_interface (a_class_name: STRING): STRING is
			-- C to Eiffel function body, if type is pointer to interface.
		require
			valid_name: a_class_name /= Void and then not a_class_name.empty
		do
			create Result.make (0)

			Result.append (tab)
			Result.append (Return)
			Result.append (Space)
			Result.append (Ce_mapper)
			Result.append (Dot)
			Result.append ("ccom_ce_pointed_interface")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("a_interface_pointer")
			Result.append (Comma)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append (a_class_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			valid_result: Result /= Void and then not Result.empty
		end

	ce_function_body_cell (a_c_type, element_ce_function, element_eiffel_name: STRING;
					can_free_pointer, need_generate_ce_element, a_writable: BOOLEAN): STRING is
			-- C to Eiffel function body, for types pointed to all types 
			-- other then records and interfaces.
			--		Parameters
			-- `a_c_type' C type needs to be converted.
			-- `element_ce_function' name of C to Eiffel function for pointed to type.
			-- `element_eiffel_name' Eiffel name of pointed to type.
			-- `can_free_pointer' - Can pointer be freed after conversion?
			-- `a_writable' - Is pointed type writable?
		require
			non_void_a_c_type: a_c_type /= Void
			valid_a_c_type: not a_c_type.empty
			non_void_element_ce_function: element_ce_function /= Void
			valid_element_ce_function: not element_ce_function.empty
			non_void_element_eiffel_name: element_eiffel_name /= Void
			valid_element_eiffel_name: not element_eiffel_name.empty
		do
			create Result.make (0)
			Result.append (Tab)

			-- EIF_TYPE_ID type_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_PROCEDURE set_item;

			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append ("set_item")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_OBJECT result;
			--

			Result.append (Eif_object)
			Result.append (Space)
			Result.append ("result")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- type_id = eif_type_id ("CELL [element_eiffel_name]");
			--                             value of ^

			Result.append ("type_id")
			Result.append (Space_equal_space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (Cell_type)
			Result.append (Space)
			Result.append (Open_bracket)
			Result.append (element_eiffel_name)
			Result.append (Close_bracket)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- set_item = eif_procedure ("set_item", type_id);
			-- 

			Result.append ("set_item")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_procedure_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append ("set_item")
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (space)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- if ((an_object == NULL) || (eif_access (an_object) == NULL))

			Result.append (If_keyword)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Open_parenthesis)
			Result.append ("an_object")
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
			Result.append ("an_object")
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

			-- result = eif_create (type_id);

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
			Result.append (New_line_tab)

			-- }

			Result.append (Close_curly_brace)
			Result.append (New_line_tab)

			-- else

			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)

			-- result = an_object;

			Result.append ("result")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append ("an_object")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- set_item (eif_access (result), cpp_object_name.element_ce_function (*(a_c_type) a_pointer));
			--                              value of ^     value of ^             value of ^

			Result.append ("set_item")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("result")
			Result.append (Close_parenthesis)
			Result.append (Comma)
			Result.append (Space)

			if not need_generate_ce_element then
				Result.append (Ce_mapper)
				Result.append (Dot)
			end
			Result.append (element_ce_function)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Asterisk)
			Result.append (Open_parenthesis)
			Result.append (a_c_type)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append ("a_pointer")
			if a_writable then
				Result.append (Comma_space)
				Result.append (Null)
			end
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- CoTaskMemFree (a_pointer);
			--   ^   Only called if can_free_element is True

			if can_free_pointer then
				Result.append (Co_task_mem_free)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("a_pointer")
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
			end

			-- if ((an_object == NULL) || (eif_access (an_object) == NULL))

			Result.append (If_keyword)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Open_parenthesis)
			Result.append ("an_object")
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
			Result.append ("an_object")
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (C_equal)
			Result.append (Space)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)

			-- return eif_wean (result);

			Result.append (Return)
			Result.append (Space)
			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("result")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- else

			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)

			-- return NULL;

			Result.append (Return)
			Result.append (Space)
			Result.append (Null)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	ec_function_body_cell (element_eiffel_type, element_c_type, element_ec_function: STRING;
					need_generate_element_ec_function: BOOLEAN;
					element_writable: BOOLEAN): STRING is
			-- Eiffel to C function body for CELL type
			-- 
		require
			non_void_element_eiffel_type: element_eiffel_type /= Void
			non_void_element_c_type: element_c_type /= Void
			non_void_element_ec_function: element_ec_function /= Void

			valid_element_eiffel_type: not element_eiffel_type.empty
			valid_element_c_type: not element_c_type.empty
			valid_element_ec_function: not element_ec_function.empty
		do
			create Result.make (0)
			Result.append (Tab)

			-- EIF_TYPE_ID type_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_OBJECT eif_object;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append ("eif_object")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_REFERENCE_FUNCTION item;

			Result.append (Eif_reference_function)
			Result.append (Space)
			Result.append ("item")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- element_c_type * result;
			-- value of ^
			--

			Result.append (element_c_type)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append ("result")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- eif_object = eif_protect (eif_ref);

			Result.append ("eif_object")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_protect)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("eif_ref")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- type_id = eif_type_id ("CELL [element_eiffel_name]");
			--                          value of ^

			Result.append ("type_id")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (Cell_type)
			Result.append (Space)
			Result.append (Open_bracket)
			Result.append (element_eiffel_type)
			Result.append (Close_bracket)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- item = eif_reference_function ("item", type_id);

			Result.append ("item")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_reference_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append ("item")
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("type_id")
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
			Result.append (New_line_tab_tab)

			-- 	result = old;

			Result.append (C_result)
			Result.append (Space_equal_space)
			Result.append (Old_keyword)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- else

			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)

			-- 	result = (element_c_type *) CoTaskMemAlloc (sizeof (element_c_type));
			--       value of ^                              value of ^

			Result.append (C_result)
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (element_c_type)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (Co_task_mem_alloc)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Sizeof)
			Result.append (Space_open_parenthesis)
			Result.append (element_c_type)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- *result = cpp_object.element_ec_function (item (eif_access (eif_object)));
			--                      value of ^

			Result.append (Asterisk)
			Result.append ("result")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			if not need_generate_element_ec_function then
				Result.append (Ec_mapper)
				Result.append (Dot)
			end
			Result.append (element_ec_function)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("item")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("eif_object")
			Result.append (Close_parenthesis)
			if element_writable then
				Result.append (Comma_space)
				Result.append (Null)
			end
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eif_wean (eif_object);

			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("eif_object")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- return result;

			Result.append (Return)
			Result.append (Space)
			Result.append ("result")
			Result.append (Semicolon)

		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	ec_function_wrapper (eiffel_type_name, c_type_name: STRING): STRING is
			-- Eiffel to C function for wrappers.
		require
			non_void_eiffel_name: eiffel_type_name /= Void
			non_void_c_name: c_type_name /= Void
			valid_eiffel_name: not eiffel_type_name.empty
			valid_c_name: not c_type_name.empty
		do
			create Result.make (0)
			Result.append (Tab)

			-- EIF_TYPE_ID type_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_OBJECT eif_object;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append ("eif_object")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_POINTER_FUNCTION item;
			-- 
			Result.append (Eif_pointer_function)
			Result.append (Space)
			Result.append ("item")
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- eif_object = eif_protect (eif_ref);

			Result.append ("eif_object")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_protect)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("eif_ref")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- type_id = eif_type_id (`eiffel_type_name');

			Result.append ("type_id")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (eiffel_type_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- item = eif_pointer_function ("item", type_id);

			Result.append ("item")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_pointer_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append ("item")
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- return (`c_type_name') item (eif_wean (eif_object));

			Result.append (Return)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (c_type_name)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append ("item")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("eif_object")
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end


end -- class WIZARD_POINTED_DATA_TYPE_GENERATOR

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

