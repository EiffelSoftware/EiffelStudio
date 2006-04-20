indexing
	description: "Wizard Pointed Data Type names generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_POINTED_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

	ECOM_VAR_TYPE

feature -- Basic operations

	process (a_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR; a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process Pointed Data Type
		require
			valid_descriptor: a_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			pointed_visitor: WIZARD_DATA_TYPE_VISITOR
			a_type: INTEGER
			local_counter: INTEGER
		do
			is_pointed := True
			pointed_visitor := a_descriptor.pointed_data_type_descriptor.visitor 

			need_free_memory := True
			need_generate_free_memory := True

			if (pointed_visitor.is_interface or pointed_visitor.is_coclass) and (is_iunknown (pointed_visitor.vt_type) or is_idispatch (pointed_visitor.vt_type)) then
				vt_type := pointed_visitor.vt_type
			else
				vt_type := binary_or (pointed_visitor.vt_type, Vt_byref)
			end

			create c_type.make (100)
			c_type.append (pointed_visitor.c_type)
			c_type.append (Space)
			c_type.append (Asterisk)

			create c_post_type.make (10)
			c_post_type.append (pointed_visitor.c_post_type)
			if pointed_visitor.c_definition_header_file_name /= Void then
				c_definition_header_file_name := pointed_visitor.c_definition_header_file_name
			end
			if pointed_visitor.c_declaration_header_file_name /= Void then
				c_declaration_header_file_name := pointed_visitor.c_declaration_header_file_name
			end

			create ce_function_name.make (100)
			create ec_function_name.make (100)
			create free_memory_function_name.make (100)
			local_counter := counter (a_descriptor)

			if pointed_visitor.is_structure then
				is_structure_pointer := True
				eiffel_type := pointed_visitor.eiffel_type.twin

				need_generate_ce := True
				need_generate_ec := True
				
				ce_function_name.append ("ccom_ce_pointed_record_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_record_")
				ec_function_name.append_integer (local_counter)

				need_free_memory := False
				need_generate_free_memory := False
				
				create ce_function_signature.make (100)
				ce_function_signature.append (c_type)
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_record_pointer")

				ce_function_return_type := Eif_reference.twin
				ce_function_body := ce_function_body_record (eiffel_type)

				create ec_function_signature.make (100)
				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append ("eif_ref")

				ec_function_return_type := c_type.twin

				ec_function_body := ec_function_wrapper (eiffel_type, c_type, False)

				can_free := True
				writable := False

			elseif pointed_visitor.is_interface then
				is_interface_pointer := True
				eiffel_type := pointed_visitor.eiffel_type.twin

				ce_function_name.append ("ccom_ce_pointed_interface_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_interface_")
				ec_function_name.append_integer (local_counter)

				need_free_memory := False
				need_generate_free_memory := False


				need_generate_ce := True
				need_generate_ec := True

				create ce_function_signature.make (100)
				ce_function_signature.append (c_type)
				ce_function_signature.append (Space)
				ce_function_signature.append ("a_interface_pointer")

				ce_function_body := ce_function_body_interface 
						(a_descriptor.interface_descriptor.implemented_interface.impl_eiffel_class_name (True))
				ce_function_return_type := Eif_reference.twin

				create ec_function_signature.make (100)
				ec_function_signature.append ("EIF_REFERENCE eif_ref")
				ec_function_return_type := c_type.twin
				ec_function_body := ec_function_wrapper (eiffel_type, c_type, True)

				can_free := True
				writable := False

			elseif pointed_visitor.is_coclass then
				is_coclass_pointer := True
				eiffel_type := pointed_visitor.eiffel_type.twin

				ce_function_name.append ("ccom_ce_pointed_coclass_")
				ce_function_name.append_integer (local_counter)

				ec_function_name.append ("ccom_ec_pointed_coclass_")
				ec_function_name.append_integer (local_counter)

				need_free_memory := False
				need_generate_free_memory := False

				need_generate_ce := True
				need_generate_ec := True

				create ce_function_signature.make (100)
				ce_function_signature.append ("IUnknown * a_interface_pointer")

				ce_function_body := ce_function_body_interface (eiffel_type)
				ce_function_return_type := "EIF_REFERENCE"

				create ec_function_signature.make (100)
				ec_function_signature.append ("EIF_REFERENCE eif_ref")
				ec_function_return_type := c_type.twin
				ec_function_body := ec_function_wrapper (eiffel_type, c_type, True)

				can_free := True
				writable := False

			elseif 
				pointed_visitor.is_basic_type or 
				pointed_visitor.vt_type = Vt_bool or
				pointed_visitor.is_enumeration 
			then
				is_basic_type_ref := True
				a_type := pointed_visitor.vt_type
				create eiffel_type.make (100)
				create ce_function_name.make (100)
				create ec_function_name.make (100)
				can_free := True
				writable := True

				if is_character (a_type) then
					eiffel_type.append ("CHARACTER_REF")
					ec_function_name.append ("ccom_ec_pointed_character")
					ce_function_name.append ("ccom_ce_pointed_character")
				
				elseif is_unsigned_char (a_type) then
					eiffel_type.append ("CHARACTER_REF")
					ec_function_name.append ("ccom_ec_pointed_unsigned_character")
					ce_function_name.append ("ccom_ce_pointed_unsigned_character")

				elseif is_integer4 (a_type) then
					eiffel_type.append ("INTEGER_REF")
					ec_function_name.append ("ccom_ec_pointed_long")
					ce_function_name.append ("ccom_ce_pointed_long")

				elseif is_unsigned_long (a_type) then
					eiffel_type.append ("INTEGER_REF")
					ec_function_name.append ("ccom_ec_pointed_unsigned_long")
					ce_function_name.append ("ccom_ce_pointed_unsigned_long")

				elseif is_int (a_type) then
					eiffel_type.append ("INTEGER_REF")
					ec_function_name.append ("ccom_ec_pointed_integer")
					ce_function_name.append ("ccom_ce_pointed_integer")

				elseif is_unsigned_int (a_type) then
					eiffel_type.append ("INTEGER_REF")
					ec_function_name.append ("ccom_ec_pointed_unsigned_integer")
					ce_function_name.append ("ccom_ce_pointed_unsigned_integer")

				elseif is_integer2 (a_type) then
					eiffel_type.append ("INTEGER_REF")
					ec_function_name.append ("ccom_ec_pointed_short")
					ce_function_name.append ("ccom_ce_pointed_short")

				elseif is_unsigned_short (a_type) then
					eiffel_type.append ("INTEGER_REF")
					ec_function_name.append ("ccom_ec_pointed_unsigned_short")
					ce_function_name.append ("ccom_ce_pointed_unsigned_short")

				elseif is_long_long (a_type) then
					eiffel_type.append ("INTEGER_64_REF")
					ec_function_name.append ("ccom_ec_pointed_long_long")
					ce_function_name.append ("ccom_ce_pointed_long_long")

				elseif is_unsigned_long_long (a_type) then
					eiffel_type.append ("INTEGER_64_REF")
					ec_function_name.append ("ccom_ec_pointed_ulong_long")
					ce_function_name.append ("ccom_ce_pointed_ulong_long")

				elseif is_real (a_type) then 
					eiffel_type.append ("REAL_REF")
					ec_function_name.append ("ccom_ec_pointed_real")
					ce_function_name.append ("ccom_ce_pointed_real")

				elseif is_double (a_type) then
					eiffel_type.append ("DOUBLE_REF")
					ec_function_name.append ("ccom_ec_pointed_double")
					ce_function_name.append ("ccom_ce_pointed_double")

				elseif is_boolean (a_type) then
					eiffel_type.append ("BOOLEAN_REF")
					ec_function_name.append ("ccom_ec_pointed_boolean")
					ce_function_name.append ("ccom_ce_pointed_boolean")

				elseif is_byref (a_type) then
					is_basic_type_ref := False
					eiffel_type.append (Cell_pointer)
					ec_function_name.append ("ccom_ec_pointed_pointer")
					ce_function_name.append ("ccom_ce_pointed_pointer")
					writable := True

				elseif is_void (a_type) or a_type = Vt_empty then
					is_basic_type_ref := False
					eiffel_type.append (Pointer_type)
					is_basic_type := True
					cecil_type := Eif_pointer
					writable := False

				else
					check
						should_not_be_here: False
					end
				end
				free_memory_function_name.append ("ccom_free_memory_pointed_")
				free_memory_function_name.append_integer (local_counter)
				create free_memory_function_signature.make (100)
				free_memory_function_signature.append (c_type)
				free_memory_function_signature.append (" a_pointer")
				free_memory_function_body := "%Tif (a_pointer != NULL)%N%T%T%
												%CoTaskMemFree (a_pointer);"

			elseif is_hresult (pointed_visitor.vt_type) or is_error (pointed_visitor.vt_type) then
				eiffel_type := Ecom_hresult.twin
				writable := True
				ec_function_name := "ccom_ec_pointed_hresult"
				ce_function_name := "ccom_ce_pointed_hresult"
				free_memory_function_name.append ("ccom_free_memory_pointed_")
				free_memory_function_name.append_integer (local_counter)
				create free_memory_function_signature.make (100)
				free_memory_function_signature.append (c_type)
				free_memory_function_signature.append (" a_pointer")
				free_memory_function_body := "%Tif (a_pointer != NULL)%N%T%T%
												%CoTaskMemFree (a_pointer);"

			else
				if pointed_visitor.is_interface_pointer then
					is_interface_pointer_pointer := True
				end

				if pointed_visitor.is_coclass_pointer then
					is_coclass_pointer_pointer := True
				end

				free_memory_function_name.append ("ccom_free_memory_pointed_")
				free_memory_function_name.append_integer (local_counter)
				create free_memory_function_signature.make (100)
				free_memory_function_signature.append (c_type)
				free_memory_function_signature.append (Space)
				free_memory_function_signature.append ("a_pointer")
				free_memory_function_body := "%Tif (a_pointer != NULL)%N%T{%N%T%T"
				if pointed_visitor.need_free_memory then
					if pointed_visitor.need_generate_free_memory then
						free_memory_function_body.append (pointed_visitor.ce_mapper.variable_name)
						free_memory_function_body.append (".")
					end
					free_memory_function_body.append (pointed_visitor.free_memory_function_name)
					free_memory_function_body.append (" (*a_pointer);%N%T%T")
					free_memory_function_body.append ("*a_pointer = NULL;%N%T%T")
				end
				free_memory_function_body.append ("CoTaskMemFree (a_pointer);%N%T};")

				create eiffel_type.make (100)
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

				create ce_function_signature.make (100)
				ce_function_signature.append (c_type)
				ce_function_signature.append (" a_pointer, EIF_OBJECT an_object")
				ce_function_return_type := "EIF_REFERENCE"
				ce_function_body := ce_function_body_cell (c_type, pointed_visitor)
				create ec_function_signature.make (100)
				ec_function_signature.append ("EIF_REFERENCE eif_ref, ")
				ec_function_signature.append (c_type)
				ec_function_signature.append (" old")
				ec_function_return_type := c_type.twin
				ec_function_body := ec_function_body_cell (pointed_visitor)
			end
			set_visitor_atributes (a_visitor)
		end

feature {NONE} -- Implementation

	ce_function_body_record (a_class_name: STRING): STRING is
			-- C to Eiffel function body, if type is pointer to record.
		require
			valid_name: a_class_name /= Void and then not a_class_name.is_empty
		do
			create Result.make (128)
			Result.append ("%Tif (a_record_pointer != NULL)%N%T%Treturn rt_ce.ccom_ce_pointed_record (a_record_pointer, %"")
			Result.append (a_class_name)
			Result.append ("%");%N%Telse%N%T%Treturn NULL;")
		ensure
			valid_result: Result /= Void and then not Result.is_empty
		end
 
	ce_function_body_interface (a_class_name: STRING): STRING is
			-- C to Eiffel function body, if type is pointer to interface.
		require
			valid_name: a_class_name /= Void and then not a_class_name.is_empty
		do
			create Result.make (128)
			Result.append ("%Tif (a_interface_pointer != NULL)%N%T%Treturn rt_ce.ccom_ce_pointed_interface (a_interface_pointer, %"")
			Result.append (a_class_name)
			Result.append ("%");%N%Telse%N%T%Treturn NULL;")
		ensure
			valid_result: Result /= Void and then not Result.is_empty
		end

	ce_function_body_cell (a_c_type: STRING; a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
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
			valid_a_c_type: not a_c_type.is_empty
			non_void_visitor: a_visitor /= Void
		do
			create Result.make (10000)
			Result.append ("%TEIF_TYPE_ID type_id = -1;%N%T")
			Result.append ("EIF_PROCEDURE set_item = 0;%N%T")
			Result.append ("EIF_OBJECT result = 0;%N%T")
			Result.append ("EIF_OBJECT tmp_object = 0;%N%N%T")
			Result.append ("type_id = eif_type_id (%"CELL [")
			Result.append (a_visitor.eiffel_type)
			Result.append ("]%");%N%T")
			Result.append ("set_item = eif_procedure (%"put%", type_id);%N%N%T")
			Result.append ("if ((an_object == NULL) || (eif_access (an_object) == NULL))%N%T")
			Result.append ("{%N%T%T")
			Result.append ("result = eif_create (type_id);%N%T")
			Result.append ("}%N%T")
			Result.append ("else%N%T%T")
			Result.append ("result = an_object;%N%T")
			-- if (*(a_c_type) a_pointer != NULL)
			-- tmp_object = eif_protect ( cpp_object_name.element_ce_function (*(a_c_type) a_pointer));
			--                 			       value of ^               value of ^             value of ^
			
			Result.append ("if (*(" + a_c_type + ") a_pointer != NULL)%N%T%T")
			
			Result.append ("tmp_object = eif_protect (")
			if not a_visitor.need_generate_ce then
				Result.append ("rt_ce")
			else
				Result.append (a_visitor.ce_mapper.variable_name)
			end
			Result.append_character ('.')
			Result.append (a_visitor.ce_function_name)
			Result.append (" (*(")
			Result.append (a_c_type)
			Result.append (") a_pointer")
			if a_visitor.writable then
				Result.append (", NULL")
			end
			Result.append ("));%N%T")
			Result.append ("set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));%N%T")
			Result.append ("if (tmp_object != NULL)%N%T%T")
			Result.append ("eif_wean (tmp_object);%N%T")
			Result.append ("if ((an_object == NULL) || (eif_access (an_object) == NULL))%N%T%T")
			Result.append ("return eif_wean (result);%N%T")
			Result.append ("else%N%T%T")
			Result.append ("return NULL;")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	ec_function_body_cell (a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Eiffel to C function body for CELL type
		require
			non_void_visitor: a_visitor /= Void
		local
			l_c_type: STRING
		do
			create Result.make (2000)
			Result.append ("%TEIF_OBJECT eif_object = 0;%N%T")
			l_c_type := a_visitor.c_type
			Result.append (l_c_type)
			Result.append (" * result = 0;%N%T")
			Result.append ("EIF_REFERENCE cell_item = 0;%N%N%T")
			Result.append ("eif_object = eif_protect (eif_ref);%N%T")
			Result.append ("if (old != NULL)%N%T%T")
			Result.append ("result = old;%N%T")
			Result.append ("else%N%T%T")
			Result.append ("result = (")
			Result.append (l_c_type)
			Result.append (" *) CoTaskMemAlloc (sizeof (")
			Result.append (l_c_type)
			Result.append ("));%N%T")
			Result.append ("cell_item = eif_field (eif_access (eif_object), %"item%", EIF_REFERENCE);%N%T")
			if a_visitor.need_free_memory then
				Result.append ("if (*result != NULL)%N%T%
							%{%N%T%T")
				if a_visitor.need_generate_free_memory then
					Result.append (a_visitor.ce_mapper.variable_name)
					Result.append (".")
				end
				Result.append (a_visitor.free_memory_function_name) 
				Result.append ("(*result);%N%T%T%
								%*result = NULL;%N%T%
							%}%N%T")
			end
			Result.append ("if (cell_item != NULL)%N%T%T")
			Result.append ("*result = ")
			if a_visitor.need_generate_ec then
				Result.append (a_visitor.ec_mapper.variable_name)
			else
				Result.append ("rt_ec")
			end
			Result.append_character ('.')
			Result.append (a_visitor.ec_function_name)
			Result.append (" (cell_item")
			if a_visitor.writable then
				Result.append (", NULL")
			end
			Result.append (");%N%T")
			Result.append ("eif_wean (eif_object);%N%T")
			Result.append ("return result;")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	ec_function_wrapper (eiffel_type_name, c_type_name: STRING; is_interface_wrapper: BOOLEAN): STRING is
			-- Eiffel to C function for wrappers.
		require
			non_void_eiffel_name: eiffel_type_name /= Void
			non_void_c_name: c_type_name /= Void
			valid_eiffel_name: not eiffel_type_name.is_empty
			valid_c_name: not c_type_name.is_empty
		do
			create Result.make (10000)
			Result.append ("%TEIF_OBJECT eif_object = 0;%N%T")
			Result.append ("EIF_POINTER a_pointer = 0;%N%N%T")
			Result.append ("if (eif_ref != NULL)%N%T{%N%T%T")
			Result.append ("eif_object = eif_protect (eif_ref);%N%T%T")
			Result.append ("a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), %"item%", EIF_POINTER);%N%T%T")
			if is_interface_wrapper then
				Result.append (addition_for_interface (c_type_name))
			else
				Result.append (addition_for_structure (eiffel_type_name))
			end
			Result.append ("eif_wean (eif_object);%N%T")
			Result.append ("}%N%T")
			Result.append ("return (")
			Result.append (c_type_name)
			Result.append (") a_pointer;")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	addition_for_structure (eiffel_type_name: STRING): STRING is
			-- Addition for structure in EC function wrapper.
		require
			non_void_eiffel_type: eiffel_type_name /= Void
			valid_eiffel_type: not eiffel_type_name.is_empty
		do
			create Result.make (300)
			Result.append ("%N%T%TEIF_TYPE_ID type_id = eif_type_id (%"")
			Result.append (eiffel_type_name)
			Result.append ("%");%N%T%T")
			Result.append ("EIF_PROCEDURE set_shared =  eif_procedure (%"set_shared%", type_id);%N%T%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));%N%T%T")
		ensure
			non_void_addition: Result /= Void
			valid_addition: not Result.is_empty
		end

	addition_for_interface (c_type_name: STRING): STRING is
			-- Addition for interface in EC function wrapper.
		require
			non_void_c_type: c_type_name /= Void
			valid_c_type: not c_type_name.is_empty
		do
			create Result.make (1000)		
			Result.append ("if (a_pointer == NULL)%N%T%T")
			Result.append ("{%N%T%T")
			Result.append ("EIF_PROCEDURE create_item = 0;%N%T%T%T")
			Result.append ("EIF_TYPE_ID type_id = eif_type (eif_object);%N%T%T%T")
			Result.append ("create_item = eif_procedure (%"create_item%", type_id);%N%T%T%T")
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));%N%T%T")
			Result.append ("a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), %"item%", EIF_POINTER);%N%T%T")
			Result.append ("}%N%T%T")
			Result.append ("((")
			Result.append (c_type_name)
			Result.append (") a_pointer)->AddRef ();%N%T%T")
		ensure
			non_void_addition: Result /= Void
			valid_addition: not Result.is_empty
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
end -- class WIZARD_POINTED_DATA_TYPE_GENERATOR

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

