indexing
	description: "Data type names generator"
	status: "See notice at end of class"
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

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

feature -- Access

	ce_function_name: STRING
			-- Name of C to Eiffel conversion function.

	ec_function_name: STRING
			-- Name of Eiffel to C conversion function.

	need_generate_ce: BOOLEAN
			-- Do we need to generate body of CE function?

	need_generate_ec: BOOLEAN
			-- Do we need to generate body of EC function?

	ce_function_body: STRING
			-- Body of C to Eiffel conversion function.

	ec_function_body: STRING
			-- Body of Eiffel to C conversion function.

	ce_function_signature: STRING
			-- Signature of C to Eiffel conversion function.

	ec_function_signature: STRING
			-- Signature of Eiffel to C conversion function.

	ce_function_return_type: STRING
			-- Return type of C to Eiffel conversion function.

	ec_function_return_type: STRING
			-- Return type Eiffel to C conversion function.

	c_type: STRING 
			-- C type name.

	c_post_type: STRING
			-- Only used for C arrays to specify array dimensions
			-- Otherwise empty

	eiffel_type: STRING 
			-- Eiffel class name.

	inherit_from: STRING
			-- Eiffel class name, from which user of this type should inherit.
	
	c_header_file: STRING
			-- Name of C header file.

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
			if c_header_file /= Void and then not c_header_file.empty then
				a_visitor.set_c_header_file (c_header_file)
			end
			a_visitor.set_c_post_type (c_post_type)
			a_visitor.set_c_type (c_type)
			if is_basic_type or is_enumeration or (vt_type = Vt_bool) then
				a_visitor.set_cecil_type (cecil_type)
			end

			a_visitor.set_eiffel_type (eiffel_type)
			a_visitor.set_need_generate_ce (need_generate_ce)
			a_visitor.set_need_generate_ec (need_generate_ec)

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

end -- class WIZARD_DATA_TYPE_GENERATOR

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

