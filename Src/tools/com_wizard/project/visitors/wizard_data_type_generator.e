indexing
	description: "Data type names generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DATA_TYPE_GENERATOR

inherit
	ECOM_VAR_TYPE

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
	
feature -- Access

	ce_function_name: STRING
			-- Name of C to Eiffel conversion function.

	ec_function_name: STRING
			-- Name of Eiffel to C conversion function.

	free_memory_function_name: STRING
			-- Name of function to free memory.

	need_generate_ce: BOOLEAN
			-- Do we need to generate body of CE function?

	need_generate_ec: BOOLEAN
			-- Do we need to generate body of EC function?

	need_generate_free_memory: BOOLEAN
			-- Do we need to generate function to free memory?

	need_free_memory: BOOLEAN
			-- Do we need to free memory?

	ce_function_body: STRING
			-- Body of C to Eiffel conversion function.

	ec_function_body: STRING
			-- Body of Eiffel to C conversion function.

	free_memory_function_body: STRING
			-- Body of function to free memory.

	ce_function_signature: STRING
			-- Signature of C to Eiffel conversion function.

	ec_function_signature: STRING
			-- Signature of Eiffel to C conversion function.

	free_memory_function_signature: STRING
			-- Signature of function to free memory.

	ce_function_return_type: STRING
			-- Return type of C to Eiffel conversion function.

	ec_function_return_type: STRING
			-- Return type Eiffel to C conversion function.

	c_type: STRING 
			-- C type name.

	c_post_type: STRING
			-- Only used for C arrays to specify array dimensions
			-- Otherwise is_empty

	eiffel_type: STRING 
			-- Eiffel class name

	inherit_from: STRING
			-- Eiffel class name, from which user of this type should inherit
	
	c_definition_header_file_name: STRING
			-- Filename of C definition header file

	c_declaration_header_file_name: STRING
			-- Filename of C declaration header file
			-- Note: same as `c_definition_header_file_name' for types other than interfaces

	cecil_type: STRING
			-- Name of Standard Eiffel type on C side.
			-- Valid only if `is_basic_type' equals to true.

	is_basic_type: BOOLEAN
			-- Is basic type?

	is_pointed: BOOLEAN
			-- Is pointed type?

	is_basic_type_ref: BOOLEAN
			-- Is type reference to basic type?

	is_array_basic_type: BOOLEAN
			-- Is type array of basic type?

	is_structure_pointer: BOOLEAN
			-- Is type pointer to structure?

	is_structure: BOOLEAN
			-- Is type structure?

	is_interface: BOOLEAN
			-- Is type interface?

	is_interface_pointer: BOOLEAN
			-- Is type interface pointer?

	is_interface_pointer_pointer: BOOLEAN
			-- Is type pointer to interface pointer?

	is_coclass: BOOLEAN
			-- Is type coclass?

	is_coclass_pointer: BOOLEAN
			-- Is type coclass pointer?

	is_coclass_pointer_pointer: BOOLEAN
			-- Is type pointer to coclass pointer?

	is_enumeration: BOOLEAN
			-- Is type enumeration?

	can_free: BOOLEAN
			-- Can we free memory after conversion C to Eiffel?
			-- Needded for pointed type.

	vt_type: INTEGER
			-- See ECOM_VAR_TYPE FOR values

	writable: BOOLEAN
			-- Can it be data type of out parameter?

feature -- Basic operations 

	set_visitor_atributes (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Initialize `a_visitor' attributes.
		require
			valid_visitor: a_visitor /= Void
		do
			if c_definition_header_file_name /= Void and then not c_definition_header_file_name.is_empty then
				a_visitor.set_c_definition_header_file_name (c_definition_header_file_name)
				a_visitor.set_c_declaration_header_file_name (c_definition_header_file_name)
			end
			if c_declaration_header_file_name /= Void and then not c_declaration_header_file_name.is_empty then
				a_visitor.set_c_declaration_header_file_name (c_declaration_header_file_name)
			end
			a_visitor.set_c_post_type (c_post_type)
			a_visitor.set_c_type (c_type)
			if is_basic_type or is_enumeration or (vt_type = Vt_bool) then
				a_visitor.set_cecil_type (cecil_type)
			end

			a_visitor.set_eiffel_type (eiffel_type)
			a_visitor.set_need_generate_ce (need_generate_ce)
			a_visitor.set_need_generate_ec (need_generate_ec)
			a_visitor.set_need_generate_free_memory (need_generate_free_memory)
			a_visitor.set_need_free_memory (need_free_memory)
			
			if need_free_memory then
				a_visitor.set_free_memory_function_name (free_memory_function_name)
			end
			if not is_basic_type and not is_enumeration then
				ce_function_name.to_lower
				a_visitor.set_ce_function_name (ce_function_name)
				ec_function_name.to_lower
				a_visitor.set_ec_function_name (ec_function_name)
			end

			if need_generate_ce then
				a_visitor.set_ce_function_body (ce_function_body)
				a_visitor.set_ce_function_return_type (ce_function_return_type)
				a_visitor.set_ce_function_signature (ce_function_signature)
			end

			if need_generate_ec then
				a_visitor.set_ec_function_body (ec_function_body)
				a_visitor.set_ec_function_return_type (ec_function_return_type)
				a_visitor.set_ec_function_signature (ec_function_signature)
			end

			if need_generate_free_memory then
				a_visitor.set_free_memory_function_body (free_memory_function_body)
				a_visitor.set_free_memory_function_signature (free_memory_function_signature)
			end

			a_visitor.set_array_basic_type (is_array_basic_type)
			a_visitor.set_pointed_type (is_pointed)
			a_visitor.set_basic_type (is_basic_type)
			a_visitor.set_basic_type_ref (is_basic_type_ref)
			a_visitor.set_interface (is_interface)
			a_visitor.set_interface_pointer (is_interface_pointer)
			a_visitor.set_interface_pointer_pointer (is_interface_pointer_pointer)
			a_visitor.set_coclass (is_coclass)
			a_visitor.set_coclass_pointer (is_coclass_pointer)
			a_visitor.set_coclass_pointer_pointer (is_coclass_pointer_pointer)
			a_visitor.set_structure (is_structure)
			a_visitor.set_structure_pointer (is_structure_pointer)
			a_visitor.set_enumeration (is_enumeration)
			a_visitor.set_can_free (can_free)
			a_visitor.set_vt_type (vt_type)
			a_visitor.set_writable (writable)
		end

feature {NONE} -- Implementation

	counter (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR): INTEGER is
			-- Counter
		do
			if a_descriptor.visited then
				Result := a_descriptor.counter_value
			else
				Result := counter_impl.item
				counter_impl.set_item (Result + 1)
				a_descriptor.set_visited (Result)
			end
		end

	counter_impl: INTEGER_REF is
			-- Global counter
		once
			create Result
			Result.set_item (1)
		end
		
invariant

	basic_type: is_basic_type implies (not is_array_basic_type and not is_interface and not is_interface_pointer
							and not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer
							and not is_coclass_pointer_pointer
							and not is_structure and not is_structure_pointer and not is_enumeration)

	array_basic_type: is_array_basic_type implies (not is_basic_type and not is_interface and not is_interface_pointer
							and not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer
							and not is_coclass_pointer_pointer
							and not is_structure and not is_structure_pointer and not is_enumeration)

	structure: is_structure implies (not is_basic_type and not is_array_basic_type and not is_coclass_pointer_pointer and 
							not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer and 
							not is_interface and not is_interface_pointer and not is_structure_pointer and not is_enumeration)

	structure_pointer: is_structure_pointer implies (not is_basic_type and not is_array_basic_type and not is_coclass_pointer_pointer and 
							not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer and 
							not is_interface and not is_interface_pointer and not is_structure and not is_enumeration)

	interface: is_interface implies (not is_basic_type and not is_array_basic_type and not is_coclass_pointer_pointer and 
							not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface_pointer and not is_enumeration)

	interface_pointer: is_interface_pointer implies (not is_basic_type and not is_array_basic_type and not is_coclass_pointer_pointer and 
							not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface and not is_enumeration)

	interface_pointer_pointer: is_interface_pointer_pointer implies (not is_basic_type and not is_array_basic_type and 
							not is_coclass and not is_coclass_pointer and not is_interface_pointer and not is_coclass_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface and not is_enumeration)

	coclass: is_coclass implies (not is_basic_type and not is_array_basic_type and not is_coclass_pointer_pointer and 
							not is_interface and not is_coclass_pointer and not is_interface_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface_pointer and not is_enumeration)

	coclass_pointer: is_coclass_pointer implies (not is_basic_type and not is_array_basic_type and not is_coclass_pointer_pointer and 
							not is_coclass and not is_interface_pointer and not is_interface_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface and not is_enumeration)

	coclass_pointer_pointer: is_coclass_pointer_pointer implies (not is_basic_type and not is_array_basic_type and 
							not is_coclass and not is_coclass_pointer and not is_interface_pointer and not is_interface_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface and not is_enumeration)
						
	enumeration: is_enumeration implies (not is_basic_type and not is_basic_type_ref and not is_array_basic_type and
							not is_coclass and not is_coclass_pointer and not is_interface_pointer_pointer and 
							not is_coclass_pointer_pointer and 
							not is_structure and not is_structure_pointer and not is_interface and not is_interface_pointer)

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
end -- class WIZARD_DATA_TYPE_GENERATOR

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

