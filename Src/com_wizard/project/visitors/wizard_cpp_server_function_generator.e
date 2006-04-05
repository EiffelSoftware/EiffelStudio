indexing
	description: "Cpp server function generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR

feature -- Basic operations

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			--Generate C server feature
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_coclass: a_component /= Void
		do
			func_desc := a_descriptor
			component_desc := a_component
			coclass_name := a_component.name

			create ccom_feature_writer.make
			create {ARRAYED_LIST [STRING]} c_header_files.make (20)

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment (func_desc.description)

			set_vtable_function_return_type
			ccom_feature_writer.set_signature (vtable_signature)
			ccom_feature_writer.set_body (body)
		ensure
			function_descriptor_set: func_desc /= Void
			non_void_writer: ccom_feature_writer /= Void
			valid_writer: ccom_feature_writer.can_generate
		end

feature {NONE} -- Access

	component_desc: WIZARD_COMPONENT_DESCRIPTOR
			-- Component.
	
	coclass_name: STRING
			-- Coclass name

feature {NONE} -- Implementation

	is_function: BOOLEAN
			-- Is feature a function?

	is_return_hresult: BOOLEAN is
			-- Is function returning HRESULT?
		do
			Result := func_desc.return_type.visitor.vt_type = Vt_hresult
		end

	is_return_data: BOOLEAN is
			-- Is function returning data?
		do
			Result := not is_return_hresult and
					not (func_desc.return_type.visitor.vt_type = Vt_void or
					func_desc.return_type.visitor.vt_type = Vt_empty or
					func_desc.return_type.visitor.vt_type = Vt_null)
		end

	cecil_call: STRING
			-- 
	
	arguments: STRING 
			-- 
	
	variables: STRING
			-- 
	
	return_value: STRING
			-- 
	
	free_object: STRING
			-- 
	
	protect_object: STRING
			-- 

	return_type: STRING
			-- 
	
	body: STRING is
			-- Feature body
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (2000)
			if is_return_hresult then
				Result.append (Ecatch)
			end
			create cecil_call.make (1000)
			create return_value.make (1000)
			create free_object.make (1000)
			create variables.make (1000)
			
			if func_desc.argument_count > 0 or is_return_data then
				generate_cecil_call_code
				Result.append ("%N%T")
				Result.append (variables)
				Result.append ("%N%T")
				Result.append (cecil_call)
				Result.append ("%N%T")

				if protect_object /= Void then
					Result.append (protect_object)
					Result.append ("%N%T")
				end

				Result.append (return_value)
				Result.append (free_object)			
			else
				Result.append (empty_argument_procedure_body)
			end

			Result.append ("%N%T")

			if is_return_hresult then
				Result.append ("END_ECATCH;%N%Treturn S_OK;")
			elseif is_return_data then
				Result.append ("return (")
				Result.append (func_desc.return_type.visitor.c_type)
				Result.append (")")

				if func_desc.return_type.visitor.is_basic_type or func_desc.return_type.visitor.is_enumeration then
					Result.append ("tmp_value;")
				else
					l_visitor := func_desc.return_type.visitor
					if l_visitor.need_generate_ec then
						Result.append (l_visitor.ec_mapper.variable_name)
					else
						Result.append ("rt_ec")
					end
					Result.append (".")
					Result.append (func_desc.return_type.visitor.ec_function_name)
					Result.append (" (tmp_value")
					if func_desc.return_type.visitor.writable then
						Result.append (", NULL")
					end
					Result.append (");")
				end
			end
		end

	generate_cecil_call_code is
			-- Generate CECIL call code.
		require
			has_arguments_or_return_type: not func_desc.arguments.is_empty or is_return_data
		local
			cursor: CURSOR
		do
			create arguments.make (100)
			create cecil_call.make (1000)
			arguments.append (" (eif_access (eiffel_object)")

			if func_desc.argument_count > 0 then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.after
				loop
					cursor := func_desc.arguments.cursor
					
					process_argument (func_desc.arguments.item)

					func_desc.arguments.go_to (cursor)
					func_desc.arguments.forth
				end
			end

			arguments.append (");")

			if is_return_data then
				cecil_call.append (cecil_function_declaration (func_desc.return_type.visitor))
			end
			if cecil_call.is_empty then
				cecil_call.append (cecil_procedure_set_up)
				cecil_call.append (arguments)
			else
				cecil_call.append (cecil_function_call)
			end

		ensure
		end
		
	add_to_cecil_call_arguments (visitor: WIZARD_DATA_TYPE_VISITOR; an_argument_name: STRING) is
			-- Add to CECIL call arguments.
		require
			non_void_visitor: visitor /= Void
			non_void_an_argument_name: an_argument_name /= Void
			valid_an_argument_name: not an_argument_name.is_empty
		do
			if 
				visitor.is_basic_type or 
				visitor.is_enumeration or
				visitor.vt_type = Vt_bool
			then
				arguments.append (", (")
				arguments.append (visitor.cecil_type)
				arguments.append (")tmp_")
				arguments.append (an_argument_name)

			else
				arguments.append (", ((" + Tmp_clause + an_argument_name + 
							" != NULL) ? eif_access (" + Tmp_clause + an_argument_name + ") : NULL)")
			end
		end
		
	add_free_object_code (a_argument_name: STRING)is
			-- Add code for freeing object.
		require
			non_void_an_argument_name: a_argument_name /= Void
			valid_an_argument_name: not a_argument_name.is_empty
		do
			free_object.append ("if (tmp_")
			free_object.append (a_argument_name)
			free_object.append (" != NULL)%N%T%T")
			free_object.append ("eif_wean (tmp_")
			free_object.append (a_argument_name)
			free_object.append (");%N%T")
		end
		
	process_argument (an_argument: WIZARD_PARAM_DESCRIPTOR) is
			-- Process argument.
		require
			non_void_argument: an_argument /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_data_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if is_paramflag_fretval (an_argument.flags) then
				pointed_data_type_descriptor ?= an_argument.type

				if pointed_data_type_descriptor /= Void then
					visitor := pointed_data_type_descriptor.pointed_data_type_descriptor.visitor
				else
					visitor := an_argument.type.visitor
				end
				is_function := True
				return_value.append (return_value_set_up (an_argument.name, an_argument.type))
				return_value.append (New_line_tab)

				cecil_call.append (cecil_function_declaration (visitor))

			else
				visitor := an_argument.type.visitor
				variables.append (variable_set_up (an_argument.name, visitor))
				variables.append (New_line_tab)

				add_to_cecil_call_arguments (visitor, an_argument.name)
				
				if is_paramflag_fout (an_argument.flags) and (visitor.is_pointed or visitor.is_array_type) then					
					return_value.append (out_value_set_up (an_argument.name, visitor, an_argument.type))
					return_value.append (New_line_tab)

				else
					if not visitor.is_basic_type and not visitor.is_enumeration and not (visitor.vt_type = Vt_bool) then
						add_free_object_code (an_argument.name)
					end
				end
			end
		end
		
	variable_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set variable.
		require
			non_void_visitor: visitor /= Void
			non_void_arg_name: arg_name /= Void
			valid_arg_name: not arg_name.is_empty
		do
			create Result.make (1000)
			if visitor.is_basic_type or visitor.is_enumeration then
				Result.append (visitor.cecil_type)
				Result.append (" tmp_")
				Result.append (arg_name)
				Result.append (" = (")
				Result.append (visitor.cecil_type)
				Result.append (")")
				Result.append (arg_name)
				Result.append (";")

			elseif visitor.vt_type = Vt_bool then
				Result.append ("EIF_BOOLEAN tmp_")
				Result.append (arg_name)
				Result.append (" = rt_ce.")
				Result.append (visitor.ce_function_name)
				Result.append (" (")
				Result.append (arg_name)
				Result.append (");")
			else
				Result.append ("EIF_OBJECT tmp_")
				Result.append (arg_name)
				Result.append (" = NULL;%N%T")

				if not visitor.is_structure then 
					Result.append ("if (" + arg_name + " != NULL)%N%T{%N%T%T")
				end
				Result.append ("tmp_")
				Result.append (arg_name)
				Result.append (" = eif_protect (")

				if visitor.need_generate_ce then
					Result.append (visitor.ce_mapper.variable_name)
				else
					Result.append ("rt_ce")
				end

				Result.append (".")
				Result.append (visitor.ce_function_name)
				Result.append (" (")
				if is_void (visitor.vt_type) and visitor.eiffel_type.is_equal ("CELL [POINTER]") then
					Result.append ("(void **)")
				end

				Result.append (arg_name)

				if visitor.writable then
					Result.append (", NULL")
				end
				Result.append ("));")
				if not visitor.is_structure then 
					if visitor.is_interface_pointer or visitor.is_coclass_pointer then
						Result.append ("%N%T%T")
						Result.append (arg_name)
						Result.append ("->AddRef ();")
					elseif visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
						Result.append ("%N%T%Tif (*")
						Result.append (arg_name)
						Result.append (" != NULL)%N%T%T%T(*")
						Result.append (arg_name)
						Result.append (")->AddRef ();")
					end
					Result.append ("%N%T}")
				end
			end
			
		end

	out_value_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR; 
					descriptor: WIZARD_DATA_TYPE_DESCRIPTOR): STRING is
			-- Code to return out value
		require
			non_void_visitor: visitor /= Void
			non_void_name: arg_name /= Void
			valid_arg_name: not arg_name.is_empty
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			pointed_visitor: WIZARD_DATA_TYPE_VISITOR
			l_generate_ec: BOOLEAN
		do
			create Result.make (1000)
				
			if 
				not visitor.is_array_basic_type and 
				not visitor.is_structure_pointer and 
				not visitor.is_interface_pointer and
				not is_void (visitor.vt_type) and
				not (is_byref (visitor.vt_type) and is_void (visitor.vt_type - vt_byref))
			then
				if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
					Result.append ("%N%Tif (*" + arg_name + " != NULL)%N%T%T(*")
					Result.append (arg_name)
					Result.append (")->Release ();%N%T")
			
				elseif visitor.is_pointed then
					pointed_descriptor ?= descriptor
					if pointed_descriptor /= Void then
						pointed_visitor := pointed_descriptor.pointed_data_type_descriptor.visitor
						if pointed_visitor.need_free_memory then
							Result.append ("%N%Tif (*" + arg_name + " != NULL)%N%T%T")
							if pointed_visitor.need_generate_free_memory then
								Result.append (pointed_visitor.ce_mapper.variable_name + ".")
							end
							Result.append (pointed_visitor.free_memory_function_name)
							Result.append (" (*" + arg_name + ");%N%T")
						end
					end
				end
				l_generate_ec := visitor.is_pointed or visitor.is_array_type
				if l_generate_ec then
					if visitor.need_generate_ec then
						Result.append (visitor.ec_mapper.variable_name)
					else
						Result.append ("rt_ec")
					end
					Result.append (".")
					Result.append (visitor.ec_function_name)
					Result.append (" (")
				end
				Result.append ("((tmp_" + arg_name + " != NULL) ? eif_wean (tmp_" + arg_name + ") : NULL)")
				if l_generate_ec then
					Result.append (", ")
					Result.append (arg_name)
					Result.append (")")
				end
				Result.append (";")
			end
		end

	return_value_set_up ( arg_name: STRING; type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR): STRING is
			-- Code to return value
		require
			non_void_name: arg_name /= Void
			valid_arg_name: not arg_name.is_empty
			non_void_descriptor: type_descriptor /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			pointed_type_descriptor ?= type_descriptor
			if pointed_type_descriptor /= Void then
				visitor := pointed_type_descriptor.pointed_data_type_descriptor.visitor
			else
				visitor := type_descriptor.visitor
			end
			
			create Result.make (1000)
			if 
				not visitor.is_basic_type and
				not visitor.is_enumeration and
				visitor.vt_type /= Vt_bool
			then
				Result.append ("if (" + Tmp_variable_name + " != NULL)%N%T{%N%T%T")
				Result.append ("EIF_OBJECT tmp_object = eif_protect (" + Tmp_variable_name + ");%N%T%T")
				if visitor.is_structure_pointer then
					Result.append ("EIF_TYPE_ID retval_type_id = eif_type_id (%"" + 
								visitor.eiffel_type + "%");%N%T%T")
					Result.append ("EIF_PROCEDURE set_shared = eif_procedure (%"set_shared%", retval_type_id);%N%T%T")
					Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE)) set_shared) (eif_access (tmp_object));%N%T%T")
				end
			end
			
			if visitor.is_structure then
				Result.append (visitor.c_type)
				Result.append (" * tmp")
				Result.append (arg_name)
				Result.append (" = (")
				Result.append (visitor.c_type)
				Result.append (" *) eif_field (eif_access(tmp_object), %"item%", EIF_POINTER);%N%T%T")
				
				if is_variant (visitor.vt_type) then
					Result.append ("VariantCopy (" + arg_name + ", tmp" + arg_name + ");%N%T%T")
				else
					Result.append ("memcpy (" + arg_name + ", tmp" + arg_name + ", sizeof (" + visitor.c_type + "));%N%T%T")
				end
			else
				Result.append (Asterisk)
				Result.append (arg_name)
				Result.append (Space_equal_space)

				if visitor.is_basic_type or visitor.is_enumeration then
					Result.append_character ('(')
					Result.append (visitor.c_type)
					Result.append (Close_parenthesis)
					Result.append (Tmp_variable_name)
					Result.append (Semicolon)
				else
					if visitor.need_generate_ec then
						Result.append (visitor.ec_mapper.variable_name)
					else
						Result.append ("rt_ec")
					end
					Result.append_character ('.')
					Result.append (visitor.ec_function_name)
					Result.append (" (")

					if visitor.vt_type /= Vt_bool then
						Result.append ("eif_access (tmp_object)")
					else
						Result.append (Tmp_variable_name)
					end
					if visitor.writable then
						Result.append (Comma_space)
						Result.append (Null)
					end
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
				end
			end
			if 
				not visitor.is_basic_type and
				not visitor.is_enumeration and
				visitor.vt_type /= Vt_bool
			then
				Result.append ("%N%T%Teif_wean (tmp_object);%N%T}")
				if not visitor.is_structure then
					Result.append ("%N%Telse%N%T%T*" + arg_name + " = NULL;")
				end
			end
		end

	cecil_procedure_set_up: STRING is
			-- Cecil procedure call
		do
			-- EIF_PROCEDURE eiffel_procedure = 0;
			create Result.make (1000)
			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (" = 0")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_procedure = eif_procedure ("func_name", tid);
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_equal_space)
			Result.append (Eif_procedure_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			
			Result.append (func_desc.component_eiffel_name (component_desc))

			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- (FUNCTION_CAST (void, (EIF_REFERENCE, ...)) eiffel_procedure)
			Result.append (function_cast_code (Void_c_keyword))
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Close_parenthesis)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	cecil_function_declaration (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up eif_function call
		require
			non_void_visitor: visitor /= Void
		do
			create Result.make (1000)
			if visitor.is_basic_type or visitor.is_enumeration then
				if 
					is_int (visitor.vt_type) or 
					is_integer2 (visitor.vt_type) or 
					is_integer4 (visitor.vt_type) or 
					is_unsigned_int (visitor.vt_type) or 
					is_unsigned_long (visitor.vt_type) or 
					is_unsigned_short (visitor.vt_type) or
					is_long_long (visitor.vt_type) or
					is_unsigned_long_long(visitor.vt_type) 
				then
					Result := cecil_function_declaration_code (Eif_integer_function, Eif_integer_function_name)

				elseif is_character (visitor.vt_type) or is_unsigned_char (visitor.vt_type) then
					Result := cecil_function_declaration_code (Eif_character_function, Eif_character_function_name)	
					
				elseif is_real (visitor.vt_type) then
					Result := cecil_function_declaration_code (Eif_real_function, Eif_real_function_name)
					
				elseif is_double (visitor.vt_type) then
					Result := cecil_function_declaration_code (Eif_double_function, Eif_double_function_name)
					
				elseif is_byref (visitor.vt_type) or is_void (visitor.vt_type) then
					Result := cecil_function_declaration_code (Eif_pointer_function, Eif_pointer_function_name)
				end
			elseif (visitor.vt_type = Vt_bool) then
				Result := cecil_function_declaration_code (Eif_boolean_function, Eif_boolean_function_name)
				
			else
				Result := cecil_function_declaration_code (Eif_reference_function, Eif_reference_function_name)
			end
			
			Result.append (New_line_tab)
			if 
				visitor.is_basic_type or 
				visitor.is_enumeration or 
				visitor.vt_type = Vt_bool
			then
				Result.append (visitor.cecil_type)
				return_type := visitor.cecil_type.twin
			else
				Result.append (Eif_reference)
				return_type := Eif_reference.twin
			end
			Result.append (Space)
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append ("0;")
			Result.append (New_line_tab)
		end

	cecil_function_call: STRING is
			-- CECIL feature call.
		require
			non_void_arguments: arguments /= Void
		do
			create Result.make (1000)
			Result.append ("if (" + Eiffel_function_variable_name + " != NULL)")
			Result.append (New_line_tab_tab)
			
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append (function_cast_code (return_type))
			Result.append (Eiffel_function_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Arguments)
			Result.append (New_line_tab)
			
			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)
			
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append ("eif_field (")
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Double_quote)
			Result.append (func_desc.component_eiffel_name (component_desc))
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (return_type)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		end

	cecil_function_declaration_code (cecil_function_return_type, cecil_function_type: STRING): STRING is
			-- Cecil funcion declaration.
		require
			non_void_type: cecil_function_return_type /= Void
			valid_type: not cecil_function_return_type.is_empty
			non_void_name: cecil_function_type /= Void
			valid_name:  not cecil_function_type.is_empty
		do
			create Result.make (1000)
			Result.append (cecil_function_return_type)
			Result.append (Space)
			Result.append (Eiffel_function_variable_name)
			Result.append (" = 0")
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			Result.append (Eiffel_function_variable_name)
			Result.append (Space_equal_space)
			Result.append (cecil_function_type)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)

			Result.append (func_desc.component_eiffel_name (component_desc))

			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_code: Result /= Void
			valid_code: not Result.is_empty
		end

	empty_argument_procedure_body: STRING is
			-- Eiffel procedure call body
		do
			create Result.make (1000)
			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)


			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_equal_space)
			Result.append (Eif_procedure_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			
			Result.append (func_desc.component_eiffel_name (component_desc))

			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE))")
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	function_cast_code (a_return_type: STRING): STRING is
			-- Function cast code.
		require
			non_void_return_type: a_return_type /= Void
			valid_return_type: not a_return_type.is_empty
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			-- (FUNCTION_CAST (`return_type', (EIF_REFERENCE, ...))
			create Result.make (1000)
			Result.append ("(FUNCTION_CAST (")

			Result.append (a_return_type)
			Result.append (Comma)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_reference)

			from
				func_desc.arguments.start
			until
				func_desc.arguments.off
			loop
				if not is_paramflag_fretval (func_desc.arguments.item.flags) then
					visitor := func_desc.arguments.item.type.visitor
					Result.append (Comma_space)
					if 
						visitor.is_basic_type or 
						visitor.is_enumeration or
						visitor.vt_type = Vt_bool
					then
						Result.append (visitor.cecil_type)
					else
						Result.append (Eif_reference)
					end
				end
				func_desc.arguments.forth
			end

			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
		ensure
			non_void_cast: Result /= Void
			valid_cast: not Result.is_empty
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
end -- class WIZARD_CPP_SERVER_FUNCTION_GENERATOR

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

