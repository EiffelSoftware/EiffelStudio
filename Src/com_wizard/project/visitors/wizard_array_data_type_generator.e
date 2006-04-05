indexing
	description: "Wizard Array Data Type names generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
			

class
	WIZARD_ARRAY_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

feature -- Basic operations

	process (a_array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR; a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process ARRAY
		require
			valid_descriptor: a_array_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			l_element_type: INTEGER
			l_count: INTEGER
			l_counter: INTEGER
			l_size: ARRAY [INTEGER]
			i: INTEGER
			l_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			l_c_cast_type, l_eiffel_cast_type: STRING
			l_call_generated_ec: BOOLEAN
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

			l_count := a_array_descriptor.dimension_count
			l_descriptor := a_array_descriptor.array_element_descriptor
			l_visitor := l_descriptor.visitor
			l_element_type := l_visitor.vt_type
			l_size := a_array_descriptor.array_size.twin
			need_generate_ce := True
			need_generate_ec := True
			
			l_call_generated_ec := l_visitor.vt_type /= Vt_record

			from
				i := l_size.lower
			until
				i > l_size.upper
			loop
				c_post_type.append ("[")
				c_post_type.append_integer (l_size.item (i))
				c_post_type.append ("]")
				i := i + 1
			end
			l_counter := counter (a_array_descriptor)
			ce_function_return_type.append ("EIF_REFERENCE")
			writable := True

			if is_void (l_element_type) then
				message_output.add_warning ("ARRAY of type void is not supported")
			elseif is_ptr (l_element_type) or is_safearray (l_element_type) or is_user_defined (l_element_type) then
				is_array_basic_type := False
				ce_function_name.append ("ccom_ce_array_non_automation_")
				ce_function_name.append_integer (l_counter)

				ec_function_name.append ("ccom_ec_array_non_automation")
				ec_function_name.append_integer (l_counter)

				c_type.append (l_visitor.c_type)
				if l_count = 1 then
					eiffel_type.append (Array_type)
				else
					eiffel_type.append (Ecom_array_type)
				end
				
				eiffel_type.append (Open_bracket)
				eiffel_type.append (l_visitor.eiffel_type)
				eiffel_type.append (Close_bracket)
				
				ce_function_signature.append (c_type)
				ce_function_signature.append ("* an_array, EIF_OBJECT an_object")			
				ce_function_body := ce_array_function_body_non_automation (l_visitor, l_count, l_size)
				ec_function_signature.append ("EIF_REFERENCE a_ref, ")
				ec_function_signature.append (c_type)
				ec_function_signature.append ("* old ")
				ec_function_body := ec_array_function_body_non_automation (l_visitor, l_count, l_size)
				ec_function_return_type.append (l_visitor.c_type)
				ec_function_return_type.append ("*")
			else 
				is_array_basic_type := l_visitor.is_basic_type
				ce_function_name.append ("ccom_ce_array_")
				ce_function_name.append (l_visitor.c_type)
				ce_function_name.append ("_")
				ce_function_name.append_integer (l_counter)
				to_legal_name_for_c_function (ce_function_name)

				ec_function_name.append ("ccom_ec_array_automation")
				ec_function_name.append_integer (l_counter)

				c_type := l_visitor.c_type.twin
				if l_count = 1 then
					eiffel_type.append ("ARRAY")
				else
					eiffel_type.append ("ECOM_ARRAY")
				end
				eiffel_type.append (" [")
				eiffel_type.append (l_visitor.eiffel_type)
				eiffel_type.append ("]")

				ce_function_signature.append (c_type)
				ce_function_signature.append ("* an_array, EIF_OBJECT an_object")
				ce_function_body := ce_array_function_body_automation (vartype_namer.ce_array_function_name (l_visitor.vt_type), l_count, l_size, is_array_basic_type)
				ec_function_signature.append ("EIF_REFERENCE a_ref, ")
				ec_function_signature.append (c_type)
				ec_function_signature.append ("* old")
				if not l_call_generated_ec then
					-- Generating conversion for a record, use runtime function that takes a void* as argument
					l_c_cast_type := "void*"
					create l_eiffel_cast_type.make (50)
					l_eiffel_cast_type.append (l_visitor.c_type)
					l_eiffel_cast_type.append ("*")
				end
				ec_function_body := ec_array_function_body_automation (vartype_namer.ec_array_function_name (l_visitor.vt_type), l_count, l_c_cast_type, l_eiffel_cast_type)
				ec_function_return_type.append (l_visitor.c_type)
				ec_function_return_type.append ("*")
			end

			c_definition_header_file_name := l_visitor.c_definition_header_file_name
			vt_type := a_array_descriptor.type
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
		do
			create Result.make (10000)
			Result.append ("%TEIF_INTEGER some_element_counts [")
			Result.append_integer (dim_count)
			Result.append ("];%N%N%T")
			from
				i := 1
			variant
				dim_count - i + 1
			until
				i > dim_count
			loop

				-- some_element_counts [i - 1] = element_count.item (i);
				--              value of ^          value of ^

				Result.append ("some_element_counts")
				Result.append (" [")
				Result.append_integer (i - 1)
				Result.append ("] = ")
				Result.append_integer (element_count.item (i))
				Result.append (";%N%T")
				i := i + 1
			end
			Result.append ("%N%T")

			-- return Ce_mapper.rt_function_name (&an_array[0]..[0], dim_count, some_element_counts, an_object);
			--       value of ^                 value of ^          value of ^  value of ^

			Result.append ("return rt_ce.")
			Result.append (rt_function_name)
			Result.append (" (")
			if not is_basic_array then
				Result.append ("(EIF_POINTER)")
			end
			Result.append ("an_array")
			Result.append (", ")
			Result.append_integer (dim_count)
			Result.append (", some_element_counts, an_object);")
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.is_empty
		end

	ce_array_function_body_non_automation (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_dim_count: INTEGER; a_elements_count: ARRAY [INTEGER]): STRING is
			-- C to Eiffel function body for ARRAY (of non_automation data type elements).
		require
			non_void_visitor: a_visitor /= Void
			valid_dim_count: a_dim_count > 0
			valid_element_count: a_elements_count /= Void and then a_elements_count.count = a_dim_count
		local
			i: INTEGER
			l_is_structure: BOOLEAN
			l_c_type, l_eiffel_type: STRING
		do
			create Result.make (2000)
			Result.append ("%TEIF_INTEGER some_element_counts [")
			Result.append_integer (a_dim_count)
			Result.append ("];%N%T")
			Result.append ("EIF_INTEGER element_number;%N%T")
			Result.append ("EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;%N%T")
			Result.append ("EIF_TYPE_ID type_id = -1, int_array_id = -1;%N%T")
			Result.append ("EIF_PROCEDURE make = 0, put = 0;%N%T")
			Result.append ("int i;%N%T")
			Result.append ("EIF_INTEGER * lower_indices = 0;%N%T")
			l_c_type := a_visitor.c_type
			Result.append (l_c_type)
			Result.append (" ")
			l_is_structure :=  a_visitor.is_structure
			if l_is_structure then
				Result.append ("* ")
			end
			Result.append (" an_array_element = 0;%N%N%T")
			from
				i := 1
			variant
				a_dim_count - i + 1
			until
				i > a_dim_count
			loop
				Result.append ("some_element_counts [")
				Result.append_integer (i - 1)
				Result.append ("] = ")
				Result.append_integer (a_elements_count.item (i))
				Result.append (";%N%T")
				i := i + 1
			end
			Result.append ("type_id = eif_type_id (%"ARRAY [")
			l_eiffel_type := a_visitor.eiffel_type
			Result.append (l_eiffel_type)
			Result.append ("]%");%N%T")
			Result.append ("make = eif_procedure (%"make%", type_id);%N%T")
			Result.append ("put = eif_procedure (%"put%", type_id);%N%T")
			Result.append ("element_number = (EIF_INTEGER)rt_ce.ccom_element_number (")
			Result.append_integer (a_dim_count)
			Result.append (", some_element_counts);%N%T")
			Result.append ("if ((an_object == NULL) || (eif_access (an_object) == NULL))%N%T{%N%T%T")
			Result.append ("intermediate_array = eif_create (type_id);%N%T%T")
			Result.append ("make (eif_access (intermediate_array), 1, element_number);%N%T}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("intermidiate_array = an_object;%N%N%T")
			Result.append ("for (i = 0; i < element_number; i++)%N%T{%N%T%T")
			Result.append ("an_array_element = (")
			Result.append (l_c_type)
			if l_is_structure then
				Result.append ("*")
			end
			Result.append (")(")
			if l_is_structure then
				Result.append ("&")
			end
			Result.append ("(ccom_c_array_element (an_array, i, ")
			Result.append (l_c_type)
			Result.append (")));%N%T%T")
			Result.append (";%N%T")
			Result.append (";%N%T")
			Result.append ("put (eif_access (intermediate_array), ")
			Result.append (a_visitor.ce_mapper.variable_name)
			Result.append_character ('.')
			Result.append (a_visitor.ce_function_name)
			Result.append (" (")
			if l_is_structure then
				Result.append ("*")
			end
			Result.append (")an_array_element), i, + 1);%N%T}%N%N%T")
			Result.append ("if ((an_object == NULL) || (eif_access (an_object) == NULL))%N%T{%N%T%T")
			if (a_dim_count = 1) then
				Result.append ("result = intermediate_array;%N%T")
			else
				Result.append ("int_array_id = eif_type_id (%"ARRAY [INTEGER]%");%N%T%T")
				Result.append ("make = eif_procedure (%"make%", int_array_id);%N%T%T")
				Result.append ("eif_lower_indices = eif_create (int_array_id);%N%T%T")
				Result.append ("make (eif_access (eif_lower_indices), 1, ")
				Result.append_integer (a_dim_count)
				Result.append (";%N%N%T%T")
				Result.append ("lower_indices = (EIF_INTEGER *) calloc (")
				Result.append_integer (a_dim_count)
				Result.append (", sizeof (EIF_INTEGER));%N%T%T")
				Result.append ("for (i = 0; i < ")
				Result.append_integer (a_dim_count)
				Result.append ("; i++)%N%T%T%T")
				Result.append ("lower_indices [i] = 1;%N%T%T")
				Result.append ("eif_make_from_c (eif_access (eif_lower_indices), lower_indices, ")
				Result.append_integer (a_dim_count)
				Result.append (", EIF_INTEGER);%N%T%T")
				Result.append ("free (lower_indices);%%N%T%T")
				Result.append ("eif_element_count = eif_create (int_array_id);%N%T%T")
				Result.append ("make (eif_access (eif_element_count), 1, ")
				Result.append_integer (a_dim_count)
				Result.append (");%N%T%T")
				Result.append ("eif_make_from_c (eif_access (eif_element_count), some_element_counts, ")
				Result.append_integer (a_dim_count)
				Result.append (", EIF_INTEGER);%N%T%T")
				Result.append ("type_id = eif_type_id (%"ECOM_ARRAY [")
				Result.append (l_eiffel_type)
				Result.append ("]%");%N%T%T")
				Result.append ("make = eif_procedure (%"make_from_array%", type_id);%N%T%T")
				Result.append ("result = eif_create (type_id);%N%T%T")
				Result.append ("make (eif_access (result), eif_access (intermediate_array), ")
				Result.append_integer (a_dim_count)
				Result.append (", eif_access (eif_lower_indices), eif_access (eif_element_count));%N%T%T")
				Result.append ("eif_wean (intermediate_array);%N%T%T")
			end
			Result.append ("return eif_wean (result);%N%T}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("return NULL;")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	ec_array_function_body_automation (a_rt_function_name: STRING; a_dim_count: INTEGER; a_c_cast_type, a_eiffel_cast_type: STRING): STRING is
			--
		require
			non_void_rt_function_name: a_rt_function_name /= Void
			valid_rt_function_name: not a_rt_function_name.is_empty
			valid_dim_count: a_dim_count > 0
		do
			create Result.make (200)
			Result.append ("%Treturn ")
			if a_eiffel_cast_type /= Void then
				Result.append ("(")
				Result.append (a_eiffel_cast_type)
				Result.append (") (")
			end
			Result.append ("rt_ec.")
			Result.append (a_rt_function_name)
			Result.append (" (a_ref, ")
			Result.append_integer (a_dim_count)
			Result.append (", ")
			if a_c_cast_type /= Void then
				Result.append ("(")
				Result.append (a_c_cast_type)
				Result.append (")")
			end
			Result.append ("old)")
			if a_eiffel_cast_type /= Void then
				Result.append (");")
			else
				Result.append (";")
			end
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	ec_array_function_body_non_automation (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_dim_count: INTEGER; a_elements_count: ARRAY [INTEGER]): STRING is
				-- C to Eiffel function body for ARRAY (of non_automation data type elements).
		require
			non_void_visitor: a_visitor /= Void
			valid_dim_count: a_dim_count > 0
			valid_element_count: a_elements_count /= Void and then a_elements_count.count = a_dim_count
		local
			l_c_type: STRING
		do
			create Result.make (2000)
			Result.append ("%TEIF_OBJECT eif_array = 0;%N%T")
			Result.append ("EIF_TYPE_ID type_id = -1;%N%T")			
			Result.append ("EIF_REFERENCE_FUNCTION item = 0;%N%T")
			Result.append ("EIF_INTEGER_FUNCTION count = 0;%N%T")
			l_c_type := a_visitor.c_type
			Result.append (l_c_type)
			Result.append ("* array = 0;%N%T")
			Result.append (l_c_type)
			Result.append (" an_element;%N%T")
			Result.append ("int a_count, i;%N%N%T")
			Result.append ("eif_array = eif_protect (a_ref);%N%T")
			if (a_dim_count > 1) then
				Result.append ("type_id = eif_type_id (%"ECOM_ARRAY [")
				Result.append (a_visitor.eiffel_type)
				Result.append ("]%");%N%T")
				Result.append ("item = eif_reference_function (%"array_item%", type_id);%N%T")
			else
				Result.append ("type_id = eif_type_id (%"ARRAY [")
				Result.append (a_visitor.eiffel_type)
				Result.append ("]%");%N%T")
				Result.append ("item = eif_reference_function (%"item%", type_id);%N%T")
			end
			Result.append ("count = eif_integer_function (%"count%", type_id);%N%T")
			Result.append ("a_count = (int) count (eif_access (eif_array));%N%T")
			Result.append ("array = (")
			Result.append (l_c_type)
			Result.append (" *) CoTaskMemAlloc (a_count * sizeof (")
			Result.append (l_c_type)
			Result.append ("));%N%T")
			Result.append ("array = (")
			Result.append (l_c_type)
			Result.append (" *) CoTaskMemAlloc (a_count * sizeof (")
			Result.append (l_c_type)
			Result.append ("));%N%T")
			Result.append ("for (i = 0; i < a_count; i++)%N%T{%N%T%T")
			Result.append ("an_element = ")
			Result.append (a_visitor.ec_mapper.variable_name)
			Result.append_character ('.')
			Result.append (a_visitor.ec_function_name)
			Result.append (" (item (eif_access (eif_array), (EIF_INTEGER) (i + 1)));%N%T")
			if a_visitor.is_structure then
				Result.append ("memcpy (((")
				Result.append (l_c_type)
				Result.append (" *) array + i), &an_element, sizeof (")
				Result.append (l_c_type)
				Result.append ("));%N%T")
			else
				Result.append ("*((")
				Result.append (l_c_type)
				Result.append (" *) array + i) = an_element;%N%T")
			end
			Result.append ("}%N%T")
			Result.append ("eif_wean (eif_array);%N%T")
			Result.append ("if (old != NULL)%N%T{%N%T%T")
			Result.append ("memcpy (old, array, a_count * sizeof (")
			Result.append (l_c_type)
			Result.append ("));%N%T%T")
			Result.append ("return NULL;%N%T}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("return array;")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
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
end -- class WIZARD_ARRAY_DATA_TYPE_GENERATOR

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

