indexing
	description: "SAFEARRAY data type Generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SAFEARRAY_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

feature -- Basic operations

	process (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR; a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process SAFEARRAY
		require
			valid_descriptor: a_safearray_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			an_element_type, local_counter: INTEGER
			element_visitor: WIZARD_DATA_TYPE_VISITOR
			tmp_string: STRING
			user_defined_element_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			pointed_data_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			element_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR
		do
			create ce_function_name.make (100)
			create ec_function_name.make (100)
			create c_type.make (100)
			create c_post_type.make (100)
			create eiffel_type.make (100)

			need_generate_ce := False
			need_generate_ec := False
			need_free_memory := True
			need_generate_free_memory := False
			free_memory_function_name := "rt_ce.free_memory_safearray"

			an_element_type := a_safearray_descriptor.array_element_descriptor.type
			vt_type := binary_or (an_element_type, Vt_array)

			element_visitor := a_safearray_descriptor.array_element_descriptor.visitor 

			c_type.append ("SAFEARRAY * ")
			local_counter := counter (a_safearray_descriptor)

			if is_unsigned_char (an_element_type) or is_character (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_char")
				ec_function_name.append ("ccom_ec_safearray_char")
				eiffel_type.append ("ECOM_ARRAY %(CHARACTER%)")
			elseif is_integer2 (an_element_type) or is_unsigned_short (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_short")
				ec_function_name.append ("ccom_ec_safearray_short")
				eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
			elseif is_integer4 (an_element_type) or is_unsigned_long (an_element_type) or element_visitor.is_enumeration or is_int (an_element_type) or is_unsigned_int (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_long")
				ec_function_name.append ("ccom_ec_safearray_long")
				eiffel_type.append ("ECOM_ARRAY %(INTEGER%)")
			elseif is_long_long (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_int64")
				ec_function_name.append ("ccom_ec_safearray_int64")
				eiffel_type.append ("ECOM_ARRAY %(INTEGER_64%)")
			elseif is_unsigned_long_long (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_int64")
				ec_function_name.append ("ccom_ec_safearray_uint64")
				eiffel_type.append ("ECOM_ARRAY %(INTEGER_64%)")
			elseif is_real (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_float")
				ec_function_name.append ("ccom_ec_safearray_float")
				eiffel_type.append ("ECOM_ARRAY %(REAL%)")
			elseif is_double (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_double")
				ec_function_name.append ("ccom_ec_safearray_double")
				eiffel_type.append ("ECOM_ARRAY %(DOUBLE%)")
			elseif is_boolean (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_boolean")
				ec_function_name.append ("ccom_ec_safearray_boolean")
				eiffel_type.append ("ECOM_ARRAY %(BOOLEAN%)")
			elseif is_date (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_date")
				ec_function_name.append ("ccom_ec_safearray_date")
				eiffel_type.append ("ECOM_ARRAY %(DATE_TIME%)")
			elseif is_error (an_element_type) or is_hresult (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_hresult")
				ec_function_name.append ("ccom_ec_safearray_hresult")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_HRESULT%)")
			elseif is_variant (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_variant")
				ec_function_name.append ("ccom_ec_safearray_variant")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_VARIANT%)")
			elseif is_currency (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_currency")
				ec_function_name.append ("ccom_ec_safearray_currency")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_CURRENCY%)")
			elseif is_bstr (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_bstr")
				ec_function_name.append ("ccom_ec_safearray_bstr")
				eiffel_type.append ("ECOM_ARRAY %(STRING%)")
			elseif is_idispatch (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_dispatch")
				ec_function_name.append ("ccom_ec_safearray_dispatch")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_AUTOMATION_INTERFACE%)")
			elseif is_iunknown (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_unknown")
				ec_function_name.append ("ccom_ec_safearray_unknown")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_UNKNOWN_INTERFACE%)")
			elseif is_decimal (an_element_type) then
				ce_function_name.append ("ccom_ce_safearray_decimal")
				ec_function_name.append ("ccom_ec_safearray_decimal")
				eiffel_type.append ("ECOM_ARRAY %(ECOM_DECIMAL%)")
			elseif element_visitor.is_interface_pointer or element_visitor.is_coclass_pointer then
				need_generate_ce := True
				need_generate_ec := True
				pointed_data_type_descriptor ?= a_safearray_descriptor.array_element_descriptor
				check
					non_void_pointed_descriptor: pointed_data_type_descriptor /= Void
				end
				eiffel_type.append (Ecom_array_type)
				eiffel_type.append (Space)
				eiffel_type.append (Open_bracket)
				eiffel_type.append (element_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)
				ce_function_name.append ("ccom_ce_safearray_interface")
				ce_function_name.append_integer (local_counter)
				ce_function_signature := c_type.twin
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_safearray")
				ce_function_return_type := Eif_reference.twin
				ce_function_body := safearray_interface_ce_function_body (pointed_data_type_descriptor)
				ec_function_name.append ("ccom_ec_safearray_interface")
				ec_function_name.append_integer (local_counter)
				ec_function_return_type := c_type.twin
				ec_function_signature := Eif_reference.twin
				ec_function_signature.append (Space)
				ec_function_signature.append ("a_ref")
				ec_function_body := safearray_interface_ec_function_body (pointed_data_type_descriptor)
			elseif element_visitor.is_structure then
				need_generate_ce := True
				need_generate_ec := True
				user_defined_element_descriptor ?= a_safearray_descriptor.array_element_descriptor
				check 
					non_void_user_defined_element_descriptor: user_defined_element_descriptor /= Void
				end
				eiffel_type.append (Ecom_array_type)
				eiffel_type.append (Space)
				eiffel_type.append (Open_bracket)
				eiffel_type.append (element_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)
				ce_function_name.append ("ccom_ce_safearray_structure")
				ce_function_name.append_integer (local_counter)
				ce_function_signature := c_type.twin
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_safearray")
				ce_function_return_type := Eif_reference.twin
				ce_function_body := safearray_record_ce_function_body (user_defined_element_descriptor)
				ec_function_name.append ("ccom_ec_safearray_structure")
				ec_function_name.append_integer (local_counter)
				ec_function_return_type := c_type.twin
				ec_function_signature := Eif_reference.twin
				ec_function_signature.append (Space)
				ec_function_signature.append ("a_ref")
				ec_function_body := safearray_record_ec_function_body (user_defined_element_descriptor)
			elseif is_safearray (an_element_type) then
				need_generate_ce := True
				need_generate_ec := True
				element_safearray_descriptor ?= a_safearray_descriptor.array_element_descriptor
				check 
					non_void_safearray_element_descriptor: element_safearray_descriptor /= Void
				end
				eiffel_type.append (Ecom_array_type)
				eiffel_type.append (Space)
				eiffel_type.append (Open_bracket)
				eiffel_type.append (element_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)
				ce_function_name.append ("ccom_ce_safearray_safearray")
				ce_function_name.append_integer (local_counter)
				ce_function_signature := c_type.twin
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_safearray")
				ce_function_return_type := Eif_reference.twin
				ce_function_body := safearray_safearray_ce_function_body (element_safearray_descriptor)
				ec_function_name.append ("ccom_ec_safearray_safearray")
				ec_function_name.append_integer (local_counter)
				ec_function_return_type := c_type.twin
				ec_function_signature := Eif_reference.twin
				ec_function_signature.append (Space)
				ec_function_signature.append ("a_ref")
				ec_function_body := safearray_safearray_ec_function_body (element_safearray_descriptor)
			else
				create tmp_string.make (100)
				tmp_string.append ("Unknown type of SAFEARRAY element: ")
				tmp_string.append (element_visitor.c_type)
				message_output.add_warning (tmp_string)
			end
			set_visitor_atributes (a_visitor)
		end

	safearray_record_ec_function_body (a_record_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR): STRING is
			-- Body of EC conversion function for SAFEARRAY of structure.
		require
			non_void_record_descriptor: a_record_descriptor /= Void
		local
			l_element_c_type, l_element_eiffel_type, tmp_string: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			library_guid, element_guid: ECOM_GUID
			library_guid_str, element_guid_str: STRING
			major_ver_number, minor_ver_number, a_lcid: INTEGER
		do
			l_visitor := a_record_descriptor.visitor
			check
				is_structure: l_visitor.is_structure
			end
			l_element_c_type := l_visitor.c_type
			l_element_eiffel_type := l_visitor.eiffel_type
			library_guid := a_record_descriptor.library_descriptor.guid
			library_guid_str := library_guid.to_definition_string
			element_guid := a_record_descriptor.library_descriptor.descriptors.item (a_record_descriptor.type_descriptor_index).guid
			element_guid_str := element_guid.to_definition_string
			major_ver_number := a_record_descriptor.library_descriptor.major_version_number
			minor_ver_number := a_record_descriptor.library_descriptor.minor_version_number
			a_lcid := a_record_descriptor.library_descriptor.lcid

			create tmp_string.make (100)
			tmp_string.append_integer (major_ver_number)
			tmp_string.append (Comma_space)
			tmp_string.append_integer (minor_ver_number)
			tmp_string.append (Comma_space)
			tmp_string.append_integer (a_lcid)

			create Result.make (2048)
			Result.append ("%TEIF_OBJECT eif_safe_array = 0, eif_element = 0;%N%T")
			Result.append ("EIF_TYPE_ID ecom_array_tid = -1, int_array_tid = -1, eif_element_tid = -1;%N%T")
			Result.append ("EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;%N%T")
			Result.append ("EIF_INTEGER * tmp_index = 0;%N%T")
			Result.append ("int dimensions = 0, loop_control = 0, i = 0;%N%T")
			Result.append ("EIF_POINTER_FUNCTION f_to_c = 0;%N%T")
			Result.append ("EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;%N%T")
			Result.append ("SAFEARRAYBOUND * array_bound = 0;%N%T")
			Result.append ("SAFEARRAY * c_safe_array = 0;%N%T")
			Result.append ("EIF_REFERENCE_FUNCTION f_array_item = 0;%N%T")
			Result.append ("EIF_PROCEDURE p_array_create = 0, p_array_put = 0, p_set_shared = 0;%N%T")
			Result.append ("long * c_index = 0;%N%T")
			Result.append (l_element_c_type)
			Result.append (" * an_element = 0;%N%T")
			Result.append ("HRESULT hr;%N%T")
			Result.append ("IRecordInfo * pRecInfo = 0;%N%T")
			Result.append ("%N%T")
			Result.append ("eif_safe_array = eif_protect (a_ref);%N%T")
			Result.append ("ecom_array_tid = eif_type_id (%"ECOM_ARRAY %(")
			Result.append (l_element_eiffel_type)
			Result.append ("%)%");%N%T")
			Result.append ("int_array_tid = eif_type_id (%"ARRAY %(INTEGER%)%");%N%T")
			Result.append ("eif_element_tid = eif_type_id (%"")
			Result.append (l_element_eiffel_type)
			Result.append ("%");%N%T")
			Result.append ("dimensions = (int) eif_field (eif_access (eif_safe_array), %"dimension_count%", EIF_INTEGER);%N%T")
			Result.append ("f_to_c = eif_pointer_function (%"to_c%", int_array_tid);%N%T")
			Result.append ("tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), %"lower_indices%", EIF_REFERENCE));%N%T")
			Result.append ("lower_indexes = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1)));%N%T")
			Result.append ("%N%T")
			Result.append ("tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), %"element_counts%", EIF_REFERENCE));%N%T")
			Result.append ("element_counts = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2)));%N%T")
			Result.append ("%N%T")
			Result.append ("tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), %"upper_indices%", EIF_REFERENCE));%N%T")
			Result.append ("upper_indexes = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3)));%N%T")
			Result.append ("%N%T")
			Result.append ("array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));%N%T")
			Result.append ("for (i = 0; i < dimensions; i++)%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("array_bound %(i%).lLbound = (long) lower_indexes %(dimensions - i - 1%);%N%T%T")
			Result.append ("array_bound %(i%).cElements = (long) element_counts %(dimensions - i - 1%);%N%T")
			Result.append ("%>%N%T")
			Result.append ("GUID library_guid = ")
			Result.append (library_guid_str)
			Result.append (";%N%T")
			Result.append ("GUID element_guid = ")
			Result.append (element_guid_str)
			Result.append (";%N%T")
			Result.append ("hr = GetRecordInfoFromGuids (library_guid, ")
			Result.append (tmp_string)
			Result.append (", element_guid, &pRecInfo);%N%T")
			Result.append ("if (FAILED (hr))")
			Result.append ("%<%N%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T")
			Result.append ("%>%N%T")
			Result.append ("c_safe_array = SafeArrayCreateEx (VT_RECORD, dimensions, array_bound, pRecInfo);%N%T")
			Result.append ("if (c_safe_array == NULL)%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("enomem ();%N%T")
			Result.append ("%>%N%T")
			Result.append ("f_array_item = eif_reference_function (%"item%", ecom_array_tid);%N%T")
			Result.append ("p_array_create = eif_procedure (%"make%", int_array_tid);%N%T")
			Result.append ("p_array_put = eif_procedure (%"put%", int_array_tid);%N%T")
			Result.append ("p_set_shared = eif_procedure (%"set_shared%", eif_element_tid);%N%T")
			Result.append ("eif_index = eif_create (int_array_tid);%N%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)%N%T%T")
			Result.append ("(eif_access (eif_index), 1, dimensions);%N%T")
			Result.append ("c_index = (long *) malloc (dimensions *sizeof (long));%N%T")
			Result.append ("tmp_index = (EIF_INTEGER *) malloc (dimensions * sizeof (EIF_INTEGER));%N%T")
			Result.append ("memcpy (tmp_index, lower_indexes, (dimensions * sizeof (EIF_INTEGER)));%N%T")
			Result.append ("%N%T")
			Result.append ("do%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);%N%T%T")
			Result.append ("for (i = 0; i < dimensions; i++)%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("c_index [i] = (long) tmp_index [dimensions - i - 1];%N%T%T")
			Result.append ("%>%N%T%T")
			Result.append ("eif_element = eif_protect ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)%N%T%T%T")
			Result.append ("(eif_access (eif_safe_array), eif_access (eif_index)));%N%T%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE)) p_set_shared) (eif_access (eif_element));%N%T%T")
			Result.append ("an_element = (")
			Result.append (l_element_c_type)
			Result.append (" *) eif_field (eif_access (eif_element), %"item%", EIF_POINTER);%N%T%T")
			Result.append ("eif_wean (eif_element);%N%T%T")
			Result.append ("hr = SafeArrayPutElement (c_safe_array, c_index, an_element);%N%T%T")
			Result.append ("if (FAILED (hr))%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T")
			Result.append ("%>%N%T%T")
			Result.append ("loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);%N%T")
			Result.append ("%> while (loop_control != 0);%N%T")
			Result.append ("free (array_bound);%N%T")
			Result.append ("free (c_index);%N%T")
			Result.append ("free (tmp_index);%N%T")
			Result.append ("eif_wean (tmp_object1);%N%T")
			Result.append ("eif_wean (tmp_object2);%N%T")
			Result.append ("eif_wean (tmp_object3);%N%T")
			Result.append ("eif_wean (eif_index);%N%T")
			Result.append ("eif_wean (eif_safe_array);%N%T")
			Result.append ("return c_safe_array;")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
		end

	safearray_safearray_ec_function_body (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR): STRING is
			-- Body of EC conversion function for SAFEARRAY of SAFEARRAY.
		require
			non_void_safearray_descriptor: a_safearray_descriptor /= Void
		local
			l_element_c_type, l_element_eiffel_type, tmp_string: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			major_ver_number, minor_ver_number, a_lcid: INTEGER
		do
			l_visitor := a_safearray_descriptor.visitor
			l_element_c_type := l_visitor.c_type
			l_element_eiffel_type := l_visitor.eiffel_type

			create tmp_string.make (100)
			tmp_string.append_integer (major_ver_number)
			tmp_string.append (Comma_space)
			tmp_string.append_integer (minor_ver_number)
			tmp_string.append (Comma_space)
			tmp_string.append_integer (a_lcid)

			create Result.make (2048)
			Result.append ("%TEIF_OBJECT eif_safe_array = 0, eif_element = 0;%N%T")
			Result.append ("EIF_TYPE_ID ecom_array_tid = -1, int_array_tid = -1;%N%T")
			Result.append ("EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;%N%T")
			Result.append ("EIF_INTEGER * tmp_index = 0;%N%T")
			Result.append ("int dimensions = 0, loop_control = 0, i = 0;%N%T")
			Result.append ("EIF_POINTER_FUNCTION f_to_c = 0;%N%T")
			Result.append ("EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;%N%T")
			Result.append ("SAFEARRAYBOUND * array_bound = 0;%N%T")
			Result.append ("SAFEARRAY * c_safe_array = 0;%N%T")
			Result.append ("EIF_REFERENCE_FUNCTION f_array_item = 0;%N%T")
			Result.append ("EIF_PROCEDURE p_array_create = 0, p_array_put = 0;%N%T")
			Result.append ("long * c_index = 0;%N%T")
			Result.append (l_element_c_type)
			Result.append (" an_element = 0;%N%T")
			Result.append ("HRESULT hr;%N%T")
			Result.append ("%N%T")
			Result.append ("eif_safe_array = eif_protect (a_ref);%N%T")
			Result.append ("ecom_array_tid = eif_type_id (%"ECOM_ARRAY %(")
			Result.append (l_element_eiffel_type)
			Result.append ("%)%");%N%T")
			Result.append ("int_array_tid = eif_type_id (%"ARRAY %(INTEGER%)%");%N%T")
			Result.append ("dimensions = (int) eif_field (eif_access (eif_safe_array), %"dimension_count%", EIF_INTEGER);%N%T")
			Result.append ("f_to_c = eif_pointer_function (%"to_c%", int_array_tid);%N%T")
			Result.append ("tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), %"lower_indices%", EIF_REFERENCE));%N%T")
			Result.append ("lower_indexes = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1)));%N%T								")
			Result.append ("%N%T")
			Result.append ("tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), %"element_counts%", EIF_REFERENCE));%N%T")
			Result.append ("element_counts = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2)));%N%T								")
			Result.append ("%N%T")
			Result.append ("tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), %"upper_indices%", EIF_REFERENCE));%N%T")
			Result.append ("upper_indexes = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3)));%N%T								")
			Result.append ("%N%T")
			Result.append ("array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));%N%T")
			Result.append ("for (i = 0; i < dimensions; i++)%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("array_bound %(i%).lLbound = (long) lower_indexes %(dimensions - i - 1%);%N%T%T")
			Result.append ("array_bound %(i%).cElements = (long) element_counts %(dimensions - i - 1%);%N%T")
			Result.append ("%>%N%T")
			Result.append ("c_safe_array = SafeArrayCreateEx (")
			Result.append_integer (l_visitor.vt_type)
			Result.append (", dimensions, array_bound, NULL);%N%T")
			Result.append ("if (c_safe_array == NULL)%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("enomem ();%N%T")
			Result.append ("%>%N%T")
			Result.append ("f_array_item = eif_reference_function (%"item%", ecom_array_tid);%N%T")
			Result.append ("p_array_create = eif_procedure (%"make%", int_array_tid);%N%T")
			Result.append ("p_array_put = eif_procedure (%"put%", int_array_tid);%N%T")
			Result.append ("eif_index = eif_create (int_array_tid);%N%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)%N%T%T")
			Result.append ("(eif_access (eif_index), 1, dimensions);%N%T")
			Result.append ("c_index = (long *) malloc (dimensions *sizeof (long));%N%T")
			Result.append ("tmp_index = (EIF_INTEGER *) malloc (dimensions * sizeof (EIF_INTEGER));%N%T")
			Result.append ("memcpy (tmp_index, lower_indexes, (dimensions * sizeof (EIF_INTEGER)));%N%T")
			Result.append ("%N%T")
			Result.append ("do%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);%N%T%T")
			Result.append ("for (i = 0; i < dimensions; i++)%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("c_index [i] = (long) tmp_index [dimensions - i - 1];%N%T%T")
			Result.append ("%>%N%T%T")
			Result.append ("eif_element = eif_protect ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)%N%T%T%T")
			Result.append ("(eif_access (eif_safe_array), eif_access (eif_index)));%N%T%T")
			Result.append ("an_element = ")

			if l_visitor.need_generate_ec then
				Result.append (l_visitor.ec_mapper.variable_name)
			else
				Result.append ("rt_ec")
			end
			Result.append (".")
			Result.append (l_visitor.ec_function_name)
			Result.append (" (eif_access (eif_element));%N%T%T")
			Result.append ("eif_wean (eif_element);%N%T%T")
			Result.append ("hr = SafeArrayPutElement (c_safe_array, c_index, an_element);%N%T%T")
			Result.append ("if (FAILED (hr))%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T")
			Result.append ("%>%N%T%T")
			Result.append ("loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);%N%T")
			Result.append ("%> while (loop_control != 0);%N%T")
			Result.append ("free (array_bound);%N%T")
			Result.append ("free (c_index);%N%T")
			Result.append ("free (tmp_index);%N%T")
			Result.append ("eif_wean (tmp_object1);%N%T")
			Result.append ("eif_wean (tmp_object2);%N%T")
			Result.append ("eif_wean (tmp_object3);%N%T")
			Result.append ("eif_wean (eif_index);%N%T")
			Result.append ("eif_wean (eif_safe_array);%N%T")
			Result.append ("return c_safe_array;")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
		end


	safearray_interface_ec_function_body (an_interface_pointer_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR): STRING is
			-- Body of EC conversion function for SAFEARRAY of interface.
		require
			non_void_interface_descriptor: an_interface_pointer_descriptor /= Void
		local
			l_element_c_type, l_element_eiffel_type: STRING
			tmp_string, tmp_element_ec_function: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			library_guid, element_guid: ECOM_GUID
			library_guid_str, element_guid_str: STRING
			major_ver_number, minor_ver_number, a_lcid: INTEGER
			an_interface_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
		do
			l_visitor := an_interface_pointer_descriptor.visitor
			check
				is_interface_pointer: l_visitor.is_interface_pointer
			end
			an_interface_descriptor ?= an_interface_pointer_descriptor.pointed_data_type_descriptor
			check
				non_void_interface_descriptor: an_interface_descriptor /= Void
			end

			l_element_c_type := l_visitor.c_type
			l_element_eiffel_type := l_visitor.eiffel_type
			library_guid := an_interface_descriptor.library_descriptor.guid
			library_guid_str := library_guid.to_definition_string
			element_guid := an_interface_descriptor.library_descriptor.descriptors.item (an_interface_descriptor.type_descriptor_index).guid
			element_guid_str := element_guid.to_definition_string
			major_ver_number := an_interface_descriptor.library_descriptor.major_version_number
			minor_ver_number := an_interface_descriptor.library_descriptor.minor_version_number
			a_lcid := an_interface_descriptor.library_descriptor.lcid
			create tmp_element_ec_function.make (100)
			if l_visitor.need_generate_ce then
				tmp_element_ec_function.append (l_visitor.ec_mapper.variable_name)
			else
				tmp_element_ec_function.append ("rt_ce")
			end
			tmp_element_ec_function.append_character ('.')
			tmp_element_ec_function.append (l_visitor.ec_function_name)


			create tmp_string.make (100)
			tmp_string.append_integer (major_ver_number)
			tmp_string.append (Comma_space)
			tmp_string.append_integer (minor_ver_number)
			tmp_string.append (Comma_space)
			tmp_string.append_integer (a_lcid)

			create Result.make (2048)
			Result.append ("%TEIF_OBJECT eif_safe_array = 0, eif_element = 0;%N%T")
			Result.append ("EIF_TYPE_ID ecom_array_tid = -1, int_array_tid = -1, eif_element_tid = -1;%N%T")
			Result.append ("EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;%N%T")
			Result.append ("EIF_INTEGER * tmp_index = 0;%N%T")
			Result.append ("int dimensions = 0, loop_control = 0, i = 0;%N%T")
			Result.append ("EIF_POINTER_FUNCTION f_to_c = 0;%N%T")
			Result.append ("EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;%N%T")
			Result.append ("SAFEARRAYBOUND * array_bound = 0;%N%T")
			Result.append ("SAFEARRAY * c_safe_array = 0;%N%T")
			Result.append ("EIF_REFERENCE_FUNCTION f_array_item = 0;%N%T")
			Result.append ("EIF_PROCEDURE p_array_create = 0, p_array_put = 0;%N%T")
			Result.append ("long * c_index = 0;%N%T")
			Result.append (l_element_c_type)
			Result.append (" an_element = 0;%N%T")
			Result.append ("HRESULT hr;%N%T")
			Result.append ("%N%T")
			Result.append ("eif_safe_array = eif_protect (a_ref);%N%T")
			Result.append ("ecom_array_tid = eif_type_id (%"ECOM_ARRAY %(")
			Result.append (l_element_eiffel_type)
			Result.append ("%)%");%N%T")
			Result.append ("int_array_tid = eif_type_id (%"ARRAY %(INTEGER%)%");%N%T")
			Result.append ("eif_element_tid = eif_type_id (%"")
			Result.append (l_element_eiffel_type)
			Result.append ("%");%N%T")
			Result.append ("dimensions = (int) eif_field (eif_access (eif_safe_array), %"dimension_count%", EIF_INTEGER);%N%T")
			Result.append ("f_to_c = eif_pointer_function (%"to_c%", int_array_tid);%N%T")
			Result.append ("tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), %"lower_indices%", EIF_REFERENCE));%N%T")
			Result.append ("lower_indexes = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1)));%N%T")
			Result.append ("%N%T")
			Result.append ("tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), %"element_counts%", EIF_REFERENCE));%N%T")
			Result.append ("element_counts = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2)));%N%T")
			Result.append ("%N%T")
			Result.append ("tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), %"upper_indices%", EIF_REFERENCE));%N%T")
			Result.append ("upper_indexes = (EIF_INTEGER *) ((FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3)));%N%T")
			Result.append ("%N%T")
			Result.append ("array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));%N%T")
			Result.append ("for (i = 0; i < dimensions; i++)%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("array_bound %(i%).lLbound = (long) lower_indexes %(dimensions - i - 1%);%N%T%T")
			Result.append ("array_bound %(i%).cElements = (long) element_counts %(dimensions - i - 1%);%N%T")
			Result.append ("%>%N%T")
			Result.append ("GUID element_guid = ")
			Result.append (element_guid_str)
			Result.append (";%N%T")
			Result.append ("c_safe_array = SafeArrayCreateEx (VT_UNKNOWN, dimensions, array_bound, &element_guid);%N%T")
			Result.append ("if (c_safe_array == NULL)%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("enomem ();%N%T")
			Result.append ("%>%N%T")
			Result.append ("f_array_item = eif_reference_function (%"item%", ecom_array_tid);%N%T")
			Result.append ("p_array_create = eif_procedure (%"make%", int_array_tid);%N%T")
			Result.append ("p_array_put = eif_procedure (%"put%", int_array_tid);%N%T")
			Result.append ("eif_index = eif_create (int_array_tid);%N%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)%N%T%T")
			Result.append ("(eif_access (eif_index), 1, dimensions);%N%T")
			Result.append ("c_index = (long *) malloc (dimensions *sizeof (long));%N%T")
			Result.append ("tmp_index = (EIF_INTEGER *) malloc (dimensions * sizeof (EIF_INTEGER));%N%T")
			Result.append ("memcpy (tmp_index, lower_indexes, (dimensions * sizeof (EIF_INTEGER)));%N%T")
			Result.append ("%N%T")
			Result.append ("do%N%T")
			Result.append ("%<%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);%N%T%T")
			Result.append ("for (i = 0; i < dimensions; i++)%N%T%T")
			Result.append ("%<%N%T%T%T	")
			Result.append ("c_index [i] = (long) tmp_index [dimensions - i - 1];%N%T%T")
			Result.append ("%>%N%T%T")
			Result.append ("eif_element = eif_protect ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)%N%T%T%T")
			Result.append ("(eif_access (eif_safe_array), eif_access (eif_index)));%N%T%T")
			Result.append ("an_element = (")
			Result.append (l_element_c_type)
			Result.append (") ")
			Result.append (tmp_element_ec_function)
			Result.append ("(eif_access (eif_element));%N%T%T")
			Result.append ("eif_wean (eif_element);%N%T%T")
			Result.append ("hr = SafeArrayPutElement (c_safe_array, c_index, an_element);%N%T%T")
			Result.append ("if (FAILED (hr))%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T")
			Result.append ("%>%N%T%T")
			Result.append ("loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);%N%T")
			Result.append ("%> while (loop_control != 0);%N%T")
			Result.append ("free (array_bound);%N%T")
			Result.append ("free (c_index);%N%T")
			Result.append ("free (tmp_index);%N%T")
			Result.append ("eif_wean (tmp_object1);%N%T")
			Result.append ("eif_wean (tmp_object2);%N%T")
			Result.append ("eif_wean (tmp_object3);%N%T")
			Result.append ("eif_wean (eif_index);%N%T")
			Result.append ("eif_wean (eif_safe_array);%N%T")
			Result.append ("return c_safe_array;")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
		end


	safearray_interface_ce_function_body (a_interface_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR): STRING is
			-- Body of EC conversion function for SAFEARRAY of interface.
		require
			non_void_interface_descriptor: a_interface_descriptor /= Void
		local
			l_element_c_type, l_element_eiffel_type, l_element_ce_function: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_interface_descriptor.visitor
			check
				is_interface_pointer: l_visitor.is_interface_pointer
			end
			l_element_c_type := l_visitor.c_type
			l_element_eiffel_type := l_visitor.eiffel_type
			l_element_ce_function := l_visitor.ce_function_name

			create Result.make (2048)
			Result.append ("%TEIF_INTEGER dim_count = 0;%N%T")
			Result.append ("EIF_INTEGER * lower_indices = 0;%N%T")
			Result.append ("EIF_INTEGER * upper_indices = 0;%N%T")
			Result.append ("EIF_INTEGER * element_counts = 0;%N%T")
			Result.append ("EIF_INTEGER * index = 0;%N%T")
			Result.append ("long * sa_indices = 0;%N%T")
			Result.append ("int i = 0;%N%T")
			Result.append ("long tmp_long = 0;%N%T")
			Result.append ("HRESULT hr = 0;%N%T")
			Result.append ("EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;%N%T")
			Result.append ("EIF_TYPE_ID int_array_id = -1, type_id = -1;%N%T")
			Result.append ("EIF_PROCEDURE make = 0, put = 0;%N%T")
			Result.append (l_element_c_type)
			Result.append (" sa_element = 0;%N%T")
			Result.append ("EIF_OBJECT eif_array_element = 0;%N%N%T")
			Result.append ("if (a_safearray != NULL)%N%T")
			Result.append ("{%N%T%T")
			Result.append ("dim_count = (EIF_INTEGER) SafeArrayGetDim (a_safearray);%N%T%T")
			Result.append ("lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("upper_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("element_counts = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("index = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("sa_indices = (long *) calloc (dim_count, sizeof (long));%N%N%T%T")
			Result.append ("for (i = 0; i < dim_count; i++)%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);%N%T%T%T")
			Result.append ("if (SUCCEEDED (hr))%N%T%T%T%T")
			Result.append ("lower_indices%(i%) = (EIF_INTEGER)tmp_long;%N%T%T%T")
			Result.append ("else%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);%N%T%T%T")
			Result.append ("if (SUCCEEDED (hr))%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("upper_indices%(i%) = (EIF_INTEGER)tmp_long;%N%T%T%T%T")
			Result.append ("element_counts%(i%) = upper_indices%(i%) - lower_indices%(i%) + 1;%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("else%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("%>%N%N%T%T")
			Result.append ("// Create array of lower indices%N%T%T")
			Result.append ("int_array_id = eif_type_id (%"ARRAY %(INTEGER%)%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", int_array_id);%N%T%T")
			Result.append ("eif_lower_indices = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append (" (eif_access (eif_lower_indices), 1, dim_count);%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);%N%T%T")
			Result.append ("// Create array of element counts%N%T%T")
			Result.append ("eif_element_counts = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append ("(eif_access (eif_element_counts), 1, dim_count);%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);%N%T%T")
			Result.append ("// Create array of indices%N%T%T")
			Result.append ("eif_index = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append (" (eif_access (eif_index), 1, dim_count);%N%T%T")
			Result.append ("type_id = eif_type_id (%"ECOM_ARRAY %(")
			Result.append (l_element_eiffel_type)
			Result.append ("%)%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", type_id);%N%T%T")
			Result.append ("put = eif_procedure (%"put%", type_id);%N%T%T")
			Result.append ("result = eif_create (type_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)%N%T%T%T")
			Result.append (" (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));%N%T%T")
			Result.append ("// Initialize `result' to contents of SAFEARRAY%N%T%T")
			Result.append ("memcpy (index, lower_indices, dim_count * sizeof(EIF_INTEGER));%N%T%T")
			Result.append ("do%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);%N%T%T%T")
			Result.append ("for (i = 0; i < dim_count; i++)%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("sa_indices %(i%) = index %(dim_count - 1 - i%);%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);%N%T%T%T")
			Result.append ("if (hr != S_OK)%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("eif_array_element = eif_protect (")
			if l_visitor.need_generate_ce then
				Result.append (l_visitor.ce_mapper.variable_name)
			else
				Result.append ("rt_ce")
			end
			Result.append (".")
			Result.append (l_element_ce_function)
			Result.append ("(sa_element));%N%T%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put) (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));%N%T%T%T")
			Result.append ("eif_wean (eif_array_element);%N%T%T")
			Result.append ("%> while (rt_ce.ccom_safearray_next_index (dim_count, lower_indices, upper_indices, index));%N%T%T")
			Result.append ("// free memory%N%T%T")
			Result.append ("free (lower_indices);%N%T%T")
			Result.append ("free (element_counts);%N%T%T")
			Result.append ("free (upper_indices);%N%T%T")
			Result.append ("free (index);%N%T%T")
			Result.append ("free (sa_indices);%N%T%T")
			Result.append ("eif_wean (eif_lower_indices);%N%T%T")
			Result.append ("eif_wean (eif_element_counts);%N%T%T")
			Result.append ("eif_wean (eif_index);%N%T%T")
			Result.append ("return eif_wean (result);%N%T")
			Result.append ("}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("return NULL;")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
		end

	safearray_record_ce_function_body (a_record_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR): STRING is
			-- Body of EC conversion function for SAFEARRAY of records.
		require
			non_void_record_descriptor: a_record_descriptor /= Void
		local
			l_element_c_type, l_element_eiffel_type: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_record_descriptor.visitor
			check
				l_visitor.is_structure
			end
			l_element_c_type := l_visitor.c_type
			l_element_eiffel_type := l_visitor.eiffel_type

			create Result.make (2048)
			Result.append ("%TEIF_INTEGER dim_count = 0;%N%T")
			Result.append ("EIF_INTEGER * lower_indices = 0;%N%T")
			Result.append ("EIF_INTEGER * upper_indices = 0;%N%T")
			Result.append ("EIF_INTEGER * element_counts = 0;%N%T")
			Result.append ("EIF_INTEGER * index = 0;%N%T")
			Result.append ("long * sa_indices = 0;%N%T")
			Result.append ("int i = 0;%N%T")
			Result.append ("long tmp_long = 0;%N%T")
			Result.append ("HRESULT hr = 0;%N%T")
			Result.append ("EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;%N%T")
			Result.append ("EIF_TYPE_ID int_array_id = -1, type_id = -1, element_id = -1;%N%T")
			Result.append ("EIF_PROCEDURE make = 0, put = 0;%N%T")
			Result.append (l_element_c_type)
			Result.append ("* sa_element = 0;%N%T")
			Result.append ("EIF_OBJECT eif_array_element = 0;%N%N%T")
			Result.append ("if (a_safearray != NULL)%N%T")
			Result.append ("{%N%T%T")
			Result.append ("dim_count = (EIF_INTEGER) SafeArrayGetDim (a_safearray);%N%T%T")
			Result.append ("lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("upper_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("element_counts = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("index = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("sa_indices = (long *) calloc (dim_count, sizeof (long));%N%N%T%T")
			Result.append ("for (i = 0; i < dim_count; i++)%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);%N%T%T%T")
			Result.append ("if (SUCCEEDED (hr))%N%T%T%T%T")
			Result.append ("lower_indices%(i%) = (EIF_INTEGER)tmp_long;%N%T%T%T")
			Result.append ("else%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);%N%T%T%T")
			Result.append ("if (SUCCEEDED (hr))%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("upper_indices%(i%) = (EIF_INTEGER)tmp_long;%N%T%T%T%T")
			Result.append ("element_counts%(i%) = upper_indices%(i%) - lower_indices%(i%) + 1;%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("else%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("%>%N%N%T%T")
			Result.append ("// Create array of lower indices%N%T%T")
			Result.append ("int_array_id = eif_type_id (%"ARRAY %(INTEGER%)%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", int_array_id);%N%T%T")
			Result.append ("eif_lower_indices = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append (" (eif_access (eif_lower_indices), 1, dim_count);%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);%N%T%T")
			Result.append ("// Create array of element counts%N%T%T")
			Result.append ("eif_element_counts = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append (" (eif_access (eif_element_counts), 1, dim_count);%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);%N%T%T")
			Result.append ("// Create array of indices%N%T%T")
			Result.append ("eif_index = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append (" (eif_access (eif_index), 1, dim_count);%N%T%T")
			Result.append ("type_id = eif_type_id (%"ECOM_ARRAY %(")
			Result.append (l_element_eiffel_type)
			Result.append ("%)%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", type_id);%N%T%T")
			Result.append ("put = eif_procedure (%"put%", type_id);%N%T%T")
			Result.append ("result = eif_create (type_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)%N%T%T")
			Result.append (" (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));%N%T%T")
			Result.append ("// Initialize `result' to contents of SAFEARRAY%N%T%T")
			Result.append ("memcpy (index, lower_indices, dim_count * sizeof(EIF_INTEGER));%N%T%T")
			Result.append ("element_id = eif_type_id (%"")
			Result.append (l_element_eiffel_type)
			Result.append ("%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", element_id);%N%T%T")
			Result.append ("do%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);%N%T%T%T")
			Result.append ("for (i = 0; i < dim_count; i++)%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("sa_indices %(i%) = index %(dim_count - 1 - i%);%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("eif_array_element = eif_create (element_id);%N%T%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE))make) (eif_access (eif_array_element));%N%T%T%T")
			Result.append ("sa_element = (")
			Result.append (l_element_c_type)
			Result.append (" *) eif_field (eif_access (eif_array_element), %"item%", EIF_POINTER);%N%T%T%T")
			Result.append ("hr = SafeArrayGetElement (a_safearray, sa_indices, sa_element);%N%T%T%T")
			Result.append ("if (hr != S_OK)%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,EIF_REFERENCE))put) %N%T%T%T%T")
			Result.append ("(eif_access (result), eif_access (eif_array_element), eif_access (eif_index));%N%T%T%T")
			Result.append ("eif_wean (eif_array_element);%N%T%T")
			Result.append ("%> while (rt_ce.ccom_safearray_next_index (dim_count, lower_indices, upper_indices, index));%N%T%T")
			Result.append ("// free memory%N%T%T")
			Result.append ("free (lower_indices);%N%T%T")
			Result.append ("free (element_counts);%N%T%T")
			Result.append ("free (upper_indices);%N%T%T")
			Result.append ("free (index);%N%T%T")
			Result.append ("free (sa_indices);%N%T%T")
			Result.append ("eif_wean (eif_lower_indices);%N%T%T")
			Result.append ("eif_wean (eif_element_counts);%N%T%T")
			Result.append ("eif_wean (eif_index);%N%T%T")
			Result.append ("return eif_wean (result);%N%T")
			Result.append ("}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("return NULL;")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
		end

	safearray_safearray_ce_function_body (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR): STRING is
			-- Body of EC conversion function for SAFEARRAY of safearrays.
		require
			non_void_safearray_descriptor: a_safearray_descriptor /= Void
		local
			l_element_c_type, l_element_eiffel_type, l_element_ce_function: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_safearray_descriptor.visitor
			check
				is_safearray: is_array (l_visitor.vt_type)
			end
			l_element_c_type := l_visitor.c_type
			l_element_eiffel_type := l_visitor.eiffel_type
			l_element_ce_function := l_visitor.ce_function_name

			create Result.make (2048)
			Result.append ("%TEIF_INTEGER dim_count = 0;%N%T")
			Result.append ("EIF_INTEGER * lower_indices = 0;%N%T")
			Result.append ("EIF_INTEGER * upper_indices = 0;%N%T")
			Result.append ("EIF_INTEGER * element_counts = 0;%N%T")
			Result.append ("EIF_INTEGER * index = 0;%N%T")
			Result.append ("long * sa_indices = 0;%N%T")
			Result.append ("int i = 0;%N%T")
			Result.append ("long tmp_long = 0;%N%T")
			Result.append ("HRESULT hr = 0;%N%T")
			Result.append ("EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;%N%T")
			Result.append ("EIF_TYPE_ID int_array_id = -1, type_id = -1, element_id = -1;%N%T")
			Result.append ("EIF_PROCEDURE make = 0, put = 0;%N%T") 
			Result.append (l_element_c_type)
			Result.append (" sa_element = 0;%N%T")
			Result.append ("EIF_OBJECT eif_array_element = 0;%N%N%T")
			Result.append ("if (a_safearray != NULL)%N%T")
			Result.append ("{%N%T%T")
			Result.append ("dim_count = (EIF_INTEGER) SafeArrayGetDim (a_safearray);%N%T%T")
			Result.append ("lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("upper_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("element_counts = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("index = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));%N%T%T")
			Result.append ("sa_indices = (long *) calloc (dim_count, sizeof (long));%N%N%T%T")
			Result.append ("for (i = 0; i < dim_count; i++)%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);%N%T%T%T")
			Result.append ("if (SUCCEEDED (hr))%N%T%T%T%T")
			Result.append ("lower_indices%(i%) = (EIF_INTEGER)tmp_long;%N%T%T%T")
			Result.append ("else%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);%N%T%T%T")
			Result.append ("if (SUCCEEDED (hr))%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("upper_indices%(i%) = (EIF_INTEGER)tmp_long;%N%T%T%T%T")
			Result.append ("element_counts%(i%) = upper_indices%(i%) - lower_indices%(i%) + 1;%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("else%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("%>%N%N%T%T")
			Result.append ("// Create array of lower indices%N%T%T")
			Result.append ("int_array_id = eif_type_id (%"ARRAY %(INTEGER%)%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", int_array_id);%N%T%T")
			Result.append ("eif_lower_indices = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append ("  (eif_access (eif_lower_indices), 1, dim_count);%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);%N%T%T")
			Result.append ("// Create array of element counts%N%T%T")
			Result.append ("eif_element_counts = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append ("  (eif_access (eif_element_counts), 1, dim_count);%N%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);%N%T%T")
			Result.append ("// Create array of indices%N%T%T")
			Result.append ("eif_index = eif_create (int_array_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)%N%T%T%T")
			Result.append ("  (eif_access (eif_index), 1, dim_count);%N%T%T")
			Result.append ("type_id = eif_type_id (%"ECOM_ARRAY %(")
			Result.append (l_element_eiffel_type)
			Result.append ("%)%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", type_id);%N%T%T")
			Result.append ("put = eif_procedure (%"put%", type_id);%N%T%T")
			Result.append ("result = eif_create (type_id);%N%T%T")
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)%N%T%T%T")
			Result.append ("  (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));%N%T%T")
			Result.append ("// Initialize `result' to contents of SAFEARRAY%N%T%T")
			Result.append ("memcpy (index, lower_indices, dim_count * sizeof(EIF_INTEGER));%N%T%T")
			Result.append ("element_id = eif_type_id (%"")
			Result.append (l_element_eiffel_type)
			Result.append ("%");%N%T%T")
			Result.append ("make = eif_procedure (%"make%", element_id);%N%T%T")
			Result.append ("do%N%T%T")
			Result.append ("%<%N%T%T%T")
			Result.append ("eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);%N%T%T%T")
			Result.append ("for (i = 0; i < dim_count; i++)%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("sa_indices %(i%) = index %(dim_count - 1 - i%);%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);%N%T%T%T")
			Result.append ("if (hr != S_OK)%N%T%T%T")
			Result.append ("%<%N%T%T%T%T")
			Result.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T%T%T")
			Result.append ("%>%N%T%T%T")
			Result.append ("eif_array_element = eif_protect (")
			if l_visitor.need_generate_ce then
				Result.append (l_visitor.ce_mapper.variable_name)
			else
				Result.append ("rt_ce")
			end
			Result.append (".")
			Result.append (l_element_ce_function)
			Result.append (" (sa_element));%N%T%T%T")
			Result.append ("FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put) (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));%N%T%T%T")
			Result.append ("eif_wean (eif_array_element);%N%T%T")
			Result.append ("%> while (rt_ce.ccom_safearray_next_index (dim_count, lower_indices, upper_indices, index));%N%T%T")
			Result.append ("// free memory%N%T%T")
			Result.append ("free (lower_indices);%N%T%T")
			Result.append ("free (element_counts);%N%T%T")
			Result.append ("free (upper_indices);%N%T%T")
			Result.append ("free (index);%N%T%T")
			Result.append ("free (sa_indices);%N%T%T")
			Result.append ("eif_wean (eif_lower_indices);%N%T%T")
			Result.append ("eif_wean (eif_element_counts);%N%T%T")
			Result.append ("eif_wean (eif_index);%N%T%T")
			Result.append ("return eif_wean (result);%N%T")
			Result.append ("}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("return NULL;")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
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
end -- class WIZARD_SAFEARRAY_DATA_TYPE_GENERATOR

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

