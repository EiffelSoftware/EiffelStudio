indexing
	description: "Wizard Data Type visitor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DATA_TYPE_VISITOR

inherit
	WIZARD_DATA_VISITOR
		redefine
			visit
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

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

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end

feature -- Basic Operations

	visit (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- visit `a_descriptor'
		local
			visited: BOOLEAN
		do
			visited := a_descriptor.visited
			Precursor {WIZARD_DATA_VISITOR} (a_descriptor)
			if not is_interface and not is_coclass then
				if need_generate_ce and not visited then
					if ce_mapper = Void then
						ce_mapper := current_ce_mapper
					end
					ce_mapper.add_function (ce_function_writer, Public)
					if c_definition_header_file_name /= Void and then not c_definition_header_file_name.is_empty then
						ce_mapper.add_import (c_definition_header_file_name)
					end
					if ce_mapper.functions_count >= Max_mapper_functions then
						create_ce_mapper
					end
				end
				if need_generate_ec and not visited then
					ec_mapper := current_ec_mapper
					ec_mapper.add_function (ec_function_writer, Public)
					if c_definition_header_file_name /= Void and then not c_definition_header_file_name.is_empty then
						ec_mapper.add_import (c_definition_header_file_name)
					end
					if ec_mapper.functions_count >= Max_mapper_functions then
						create_ec_mapper
					end
				end
				if need_generate_free_memory and not visited then
					if ce_mapper = Void then
						ce_mapper := current_ce_mapper
					end
					ce_mapper.add_function (free_memory_function_writer, Public)
					if ce_mapper.functions_count >= Max_mapper_functions then
						create_ce_mapper
					end
				end
			end
		end

feature -- Access

	ec_mapper: WIZARD_WRITER_MAPPER_CLASS
			-- Writer for generated Eiffel to C mappers class.

	ce_mapper: WIZARD_WRITER_MAPPER_CLASS
			-- Writer for generated Eiffel to C mappers class.

	free_memory_function_writer: WIZARD_WRITER_C_FUNCTION is
			-- Writer for generated function to free memory.
		require
			need_generate_free_memory: need_generate_free_memory
		local
			comment: STRING
		do
			create Result.make
			Result.set_body (free_memory_function_body)

			create comment.make (100)
			comment.append ("Free memory of ")
			comment.append (c_type)
			comment.append (c_post_type)
			comment.append (".")
			Result.set_comment (comment)
			Result.set_name (free_memory_function_name)
			Result.set_result_type ("void")
			Result.set_signature (free_memory_function_signature)
		ensure
			non_void_ce_function_writer: Result /= Void
		end
		
	ce_function_writer: WIZARD_WRITER_C_FUNCTION is
			-- Writer for generated C to Eiffel conversion function.
		require
			need_generate_ce: need_generate_ce
		local
			comment: STRING
		do
			create Result.make
			Result.set_body (ce_function_body)

			create comment.make (100)
			comment.append ("Convert ")
			comment.append (c_type)
			comment.append (c_post_type)
			comment.append (" to ")
			comment.append (eiffel_type)
			comment.append (".")
			Result.set_comment (comment)

			Result.set_name (ce_function_name)
			Result.set_result_type (ce_function_return_type)
			Result.set_signature (ce_function_signature)
		ensure
			non_void_ce_function_writer: Result /= Void
		end

	ec_function_writer: WIZARD_WRITER_C_FUNCTION is
			-- Writer for generated Eiffel to C conversion function
		require
			need_generate_ec: need_generate_ec
		local
			comment: STRING
		do
			create Result.make
			Result.set_body (ec_function_body)

			create comment.make (100)
			comment.append ("Convert ")
			comment.append (eiffel_type)
			comment.append (" to ")
			comment.append (c_type)
			comment.append (c_post_type)
			comment.append (".")
			Result.set_comment (comment)

			Result.set_name (ec_function_name)
			Result.set_result_type (ec_function_return_type)
			Result.set_signature (ec_function_signature)
		ensure
			non_void_ec_function_writer: Result /= Void
		end

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
			-- Eiffel class name.
	
	c_definition_header_file_name: STRING
			-- Name of C header file, in which data type is defined
	
	c_declaration_header_file_name: STRING
			-- Name of C header file in which data type is declared if any
			-- Note: this is only initialized for interfaces.

	cecil_type: STRING
			-- Name of Standard Eiffel type on C side.
			-- Valid only if `is_basic_type' equals to true.

	is_basic_type: BOOLEAN
			-- Is type structure?

	is_pointed: BOOLEAN
			-- Is pointed type?

	is_array_basic_type: BOOLEAN
			-- Is type array of basic type?

	is_array_type: BOOLEAN
			-- Is type C array?

	is_basic_type_ref: BOOLEAN
			-- Is type reference to basic type?

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

	is_enumeration: BOOLEAN
			-- Is type enumeration?

	is_coclass: BOOLEAN
			-- Is type coclass?

	is_coclass_pointer: BOOLEAN
			-- Is type coclass pointer?

	is_coclass_pointer_pointer: BOOLEAN
			-- Is type pointer to coclass pointer?

	can_free: BOOLEAN
			-- Can we free memory after conversion C to Eiffel?
			-- Needded for pointed type.

	vt_type: INTEGER
			-- See ECOM_VAR_TYPE FOR values

	writable: BOOLEAN
			-- Can it be data type of out parameter?

feature -- Element change

	set_c_declaration_header_file_name (a_name: STRING) is
			-- Set `c_declaration_header_file_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			c_declaration_header_file_name := a_name
		ensure
			c_declaration_header_file_name_set: c_declaration_header_file_name = a_name
		end

	set_c_definition_header_file_name (a_name: STRING) is
			-- Set `c_definition_header_file_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			c_definition_header_file_name := a_name
		ensure
			c_definition_header_file_name_set: c_definition_header_file_name = a_name
		end

	set_c_post_type (a_name: STRING) is
			-- Set `c_post_type' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			c_post_type := a_name.twin
		ensure
			valid_c_post_type: c_post_type /= Void and
					not a_name.is_empty implies c_post_type.is_equal (a_name)
		end

	set_c_type (a_name: STRING) is
			-- Set `c_type' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			c_type := a_name.twin
		ensure
			valid_c_type: c_type /= Void and
					not a_name.is_empty implies c_type.is_equal (a_name)
		end

	set_cecil_type (a_name: STRING) is
			-- Set `cecil_type' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			cecil_type := a_name.twin
		ensure
			valid_cecil_type: cecil_type /= Void and
					not a_name.is_empty implies cecil_type.is_equal (a_name)
		end

	set_eiffel_type (a_name: STRING) is
			-- Set `eiffel_type' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			eiffel_type := a_name.twin
		ensure
			valid_eiffel_type: eiffel_type /= Void and
					not a_name.is_empty implies eiffel_type.is_equal (a_name)
		end

	set_ce_function_body (a_name: STRING) is
			-- Set `ce_function_body' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ce_function_body := a_name.twin
		ensure
			valid_ce_function_body: ce_function_body /= Void and
					not a_name.is_empty implies ce_function_body.is_equal (a_name)
		end

	set_ce_function_name (a_name: STRING) is
			-- Set `ce_function_name' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ce_function_name := a_name.twin
		ensure
			valid_ce_function_name: ce_function_name /= Void and
					not a_name.is_empty implies ce_function_name.is_equal (a_name)
		end

	set_ce_function_return_type (a_name: STRING) is
			-- Set `ce_function_return_type' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ce_function_return_type := a_name.twin
		ensure
			valid_ce_function_return_type: ce_function_return_type /= Void and
					not a_name.is_empty implies ce_function_return_type.is_equal (a_name)
		end

	set_ce_function_signature (a_name: STRING) is
			-- Set `ce_function_signature' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ce_function_signature := a_name.twin
		ensure
			valid_ce_function_signature: ce_function_signature /= Void and
					not a_name.is_empty implies ce_function_signature.is_equal (a_name)
		end

	set_ec_function_body (a_name: STRING) is
			-- Set `ec_function_body' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ec_function_body := a_name.twin
		ensure
			valid_ec_function_body: ec_function_body /= Void and
					not a_name.is_empty implies ec_function_body.is_equal (a_name)
		end

	set_ec_function_name (a_name: STRING) is
			-- Set `ec_function_name' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ec_function_name := a_name.twin
		ensure
			valid_ce_function_name: ec_function_name /= Void and
					not a_name.is_empty implies ec_function_name.is_equal (a_name)
		end

	set_ec_function_return_type (a_name: STRING) is
			-- Set `ec_function_return_type' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ec_function_return_type := a_name.twin
		ensure
			valid_ec_function_return_type: ec_function_return_type /= Void and
					not a_name.is_empty implies ec_function_return_type.is_equal (a_name)
		end

	set_ec_function_signature (a_name: STRING) is
			-- Set `ec_function_signature' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			ec_function_signature := a_name.twin
		ensure
			valid_ce_function_signature: ec_function_signature /= Void and
					not a_name.is_empty implies ec_function_signature.is_equal (a_name)
		end

	set_free_memory_function_body (a_name: STRING) is
			-- Set `free_memory_function_body' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			free_memory_function_body := a_name.twin
		ensure
			valid_free_memory_function_body: free_memory_function_body /= Void and
					not a_name.is_empty implies free_memory_function_body.is_equal (a_name)
		end

	set_free_memory_function_name (a_name: STRING) is
			-- Set `free_memory_function_name' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			free_memory_function_name := a_name.twin
		ensure
			valid_free_memory_function_name: free_memory_function_name /= Void and
					not a_name.is_empty implies free_memory_function_name.is_equal (a_name)
		end

	set_free_memory_function_signature (a_name: STRING) is
			-- Set `free_memory_function_signature' with `a_name'.
		require
			valid_name: a_name /= Void
		do
			free_memory_function_signature := a_name.twin
		ensure
			valid_free_memory_function_signature: free_memory_function_signature /= Void and
					not a_name.is_empty implies free_memory_function_signature.is_equal (a_name)
		end

	set_array_basic_type (a_boolean: BOOLEAN) is
			-- Set `is_array_basic_type' with `a_boolean'.
		do
			is_array_basic_type := a_boolean
		ensure
			valid_result: is_array_basic_type = a_boolean
		end

	set_basic_type (a_boolean: BOOLEAN) is
			-- Set `is_basic_type' with `a_boolean'.
		do
			is_basic_type := a_boolean
		ensure
			valid_result: is_basic_type = a_boolean
		end

	set_pointed_type (a_boolean: BOOLEAN) is
			-- Set `is_pointed' with `a_boolean'.
		do
			is_pointed := a_boolean
		ensure
			valid_result: is_pointed = a_boolean
		end

	set_basic_type_ref (a_boolean: BOOLEAN) is
			-- Set `is_basic_type_ref' with `a_boolean'.
		do
			is_basic_type_ref := a_boolean
		ensure
			valid_result: is_basic_type_ref = a_boolean
		end

	set_interface (a_boolean: BOOLEAN) is
			-- Set `is_interface' with `a_boolean'.
		do
			is_interface := a_boolean
		ensure
			valid_result: is_interface = a_boolean
		end

	set_interface_pointer (a_boolean: BOOLEAN) is
			-- Set `is_interface_pointer' with `a_boolean'.
		do
			is_interface_pointer := a_boolean
		ensure
			valid_result: is_interface_pointer = a_boolean
		end

	set_interface_pointer_pointer (a_boolean: BOOLEAN) is
			-- Set `is_interface_pointer_pointer' with `a_boolean'.
		do
			is_interface_pointer_pointer := a_boolean
		ensure
			valid_result: is_interface_pointer_pointer = a_boolean
		end

	set_coclass (a_boolean: BOOLEAN) is
			-- Set `is_coclass with `a_boolean'.
		do
			is_coclass := a_boolean
		ensure
			valid_result: is_coclass = a_boolean
		end

	set_coclass_pointer (a_boolean: BOOLEAN) is
			-- Set `is_coclass_pointer' with `a_boolean'.
		do
			is_coclass_pointer := a_boolean
		ensure
			valid_result: is_coclass_pointer = a_boolean
		end

	set_coclass_pointer_pointer (a_boolean: BOOLEAN) is
			-- Set `is_coclass_pointer_pointer' with `a_boolean'.
		do
			is_coclass_pointer_pointer := a_boolean
		ensure
			valid_result: is_coclass_pointer_pointer = a_boolean
		end

	set_structure (a_boolean: BOOLEAN) is
			-- Set `is_structure' with `a_boolean'.
		do
			is_structure := a_boolean
		ensure
			valid_result: is_structure = a_boolean
		end

	set_structure_pointer (a_boolean: BOOLEAN) is
			-- Set `is_structure_pointer' with `a_boolean'.
		do
			is_structure_pointer := a_boolean
		ensure
			valid_result: is_structure_pointer = a_boolean
		end

	set_enumeration (a_boolean: BOOLEAN) is
			-- Set `is_enumeration' with `a_boolean'.
		do
			is_enumeration := a_boolean
		ensure
			valid_result: is_enumeration = a_boolean
		end

	set_need_generate_ce (a_boolean: BOOLEAN) is
			-- Set `need_generate_ce' with `a_boolean'.
		do
			need_generate_ce := a_boolean
		ensure
			valid_result: need_generate_ce = a_boolean
		end

	set_need_generate_ec (a_boolean: BOOLEAN) is
			-- Set `need_generate_ec' with `a_boolean'.
		do
			need_generate_ec := a_boolean
		ensure
			valid_result: need_generate_ec = a_boolean
		end

	set_need_generate_free_memory (a_boolean: BOOLEAN) is
			-- Set `need_generate_free_memory' with `a_boolean'.
		do
			need_generate_free_memory := a_boolean
		ensure
			valid_result: need_generate_free_memory = a_boolean
		end

	set_need_free_memory (a_boolean: BOOLEAN) is
			-- Set `need_free_memory' with `a_boolean'.
		do
			need_free_memory := a_boolean
		ensure
			valid_result: need_free_memory = a_boolean
		end

	set_can_free (a_boolean: BOOLEAN) is
			-- Set `can_free' with `a_boolean'.
		do
			can_free := a_boolean
		ensure
			valid_result: can_free = a_boolean
		end

	set_vt_type (a_type: INTEGER) is
			-- Set `vt_type' with `a_type'
		do
			vt_type := a_type
		ensure
			valid_vt_type: vt_type = a_type
		end

	set_writable (a_boolean: BOOLEAN) is
			-- Set `writable' with `a_boolean'.
		do
			writable := a_boolean
		ensure
			valid_result: writable = a_boolean
		end

feature -- Processing

	process_safearray_data_type (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Process SAFEARRAY
		local
			a_generator: WIZARD_SAFEARRAY_DATA_TYPE_GENERATOR
		do
			create a_generator
			a_generator.process (a_safearray_descriptor, Current)
		end

	process_automation_data_type (an_automation_descriptor: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR) is
			-- Process Automation Data Type
		local
			a_generator: WIZARD_AUTOMATION_DATA_TYPE_GENERATOR
		do
			create a_generator
			a_generator.process (an_automation_descriptor, Current)
		end
		
	process_array_data_type (an_array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Process Array
		local
			a_generator: WIZARD_ARRAY_DATA_TYPE_GENERATOR
		do
			create a_generator
			a_generator.process (an_array_descriptor, Current)
			is_array_type := True
		end

	process_user_defined_data_type (a_user_defined_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR) is
			-- Process User Defined Data Type
		local
			a_generator: WIZARD_USER_DEFINED_DATA_TYPE_GENERATOR
		do
			create a_generator
			a_generator.process (a_user_defined_descriptor, Current)
		end

	process_pointed_data_type (a_pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR) is
			-- Process pointed Data Type
		local
			a_generator: WIZARD_POINTED_DATA_TYPE_GENERATOR
		do
			create a_generator
			a_generator.process (a_pointed_descriptor, Current)
		end

feature -- Implementation

	current_ec_mapper: like ec_mapper is
			-- Current shared ec mapper type name
			-- New one is created each `Max_mapper_functions' functions are added to it.
			-- All instances are stored in `Generated_ec_mappers'.
		do
			Result := Current_ec_mapper_cell.item
		ensure
			non_void_mapper: Result /= Void
		end

	current_ce_mapper: like ce_mapper is
			-- Current shared ce mapper type name
			-- New one is created each `Max_mapper_functions' functions are added to it.
			-- All instances are stored in `Generated_ec_mappers'.
		do
			Result := Current_ce_mapper_cell.item
		ensure
			non_void_mapper: Result /= Void
		end

	Current_ec_mapper_cell: CELL [WIZARD_WRITER_MAPPER_CLASS] is
			-- Cell for `current_ec_mapper'
		once
			create Result.put (new_ec_mapper)
		end
		
	Current_ce_mapper_cell: CELL [WIZARD_WRITER_MAPPER_CLASS] is
			-- Cell for `current_ce_mapper'
		once
			create Result.put (new_ce_mapper)
		end
		
	new_ec_mapper: WIZARD_WRITER_MAPPER_CLASS is
			-- Instantiate new `current_ec_mapper'.
		do
			create Result.make_ec
			Generated_ec_mappers.extend (Result)
		ensure
			non_void_mapper: Result /= Void
			valid_mapper: Result.is_ec
		end
	
	new_ce_mapper: WIZARD_WRITER_MAPPER_CLASS is
			-- Instantiate new `current_ce_mapper'.
		do
			create Result.make_ce
			Generated_ce_mappers.extend (Result)
		ensure
			non_void_mapper: Result /= Void
			valid_mapper: not Result.is_ec
		end
	
	create_ec_mapper is
			-- Instantiate new `current_ec_mapper'.
		do
			Current_ec_mapper_cell.replace (new_ec_mapper)
		end
	
	create_ce_mapper is
			-- Instantiate new `current_ec_mapper'.
		do
			Current_ce_mapper_cell.replace (new_ce_mapper)
		end
	
	Max_mapper_functions: INTEGER is 100
			-- Maximum number of functions in mapper classes

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

	valid_ec_mapper: ec_mapper /= Void implies ec_mapper.is_ec

	valid_ce_mapper: ce_mapper /= Void implies not ec_mapper.is_ec

end -- class WIZARD_DATA_TYPE_VISITOR

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

