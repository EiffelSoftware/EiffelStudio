indexing
	description: "Ancestor for basic types."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class BASIC_I

inherit
	CL_TYPE_I
		undefine
			type_a
		redefine
			is_basic, is_reference, c_type, is_valid,
			generate_cecil_value
		end

	TYPE_C
		undefine
			is_bit, is_void
		end

	SHARED_C_LEVEL

	BYTE_CONST

feature -- Access

	c_type: TYPE_C is
			-- C type
		do
			Result := Current
		end
		
	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		deferred
		ensure
			reference_type_not_void: Result /= Void
		end

	associated_reference_class_type: CLASS_TYPE is
			-- Reference class type of Current
		do
			Result := reference_type.associated_class_type
		ensure
			associated_reference_class_type_not_void: Result /= Void
		end

feature -- Status report

	is_reference: BOOLEAN is False
			-- Type is not a reference.

	is_basic: BOOLEAN is True
			-- Type is a basic type.

	is_valid: BOOLEAN is True
			-- A Basic type is always in the system

feature -- Byte code generation

	generate_byte_code_cast (ba: BYTE_ARRAY) is
			-- Code for the interpreter cast
		do
		end

	metamorphose
		(reg, value: REGISTRABLE; buffer: GENERATION_BUFFER; workbench_mode: BOOLEAN) is
			-- Generate the metamorphism from simple type to reference and
			-- put result in register `reg'. The value of the basic type is
			-- held in `value'.
		require
			valid_reg: reg /= Void
			valid_value: value /= Void
			valid_file: buffer /= Void
		do
			reg.print_register
			buffer.put_string (" = ")
				-- Create associated reference type of Current.
			(create {CREATE_TYPE}.make (reference_type)).generate
			buffer.put_string (", *")
			generate_access_cast (buffer)
			reg.print_register
			buffer.put_string (" = ")
			value.print_register
		end

	end_of_metamorphose (reg, value: REGISTRABLE; buffer: GENERATION_BUFFER) is
			-- After the metamorphosis, we need to put back the new value computed
			-- in `reg' into `value' otherwise the metamorphosis has no effect.
		require
			valid_reg: reg /= Void
			valid_value: value /= Void
			valid_file: buffer /= Void
		do
--			value.print_register
--			buffer.put_string (" = ")
--			buffer.put_character ('*')
--			generate_access_cast (buffer)
--			reg.print_register
		end

feature -- C code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil value
		do
			generate_sk_value (buffer)
		end	

	generate_default_value (buffer : GENERATION_BUFFER) is
			-- Generate default value associated to current basic type.
		require
			valid_buffer: buffer /= Void
		do
			buffer.put_character ('(')
			generate_cast (buffer)
			buffer.put_string ("0)")
		end
	
	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		require
			valid_array: ba /= Void
		deferred
		end 
		
invariant
	is_basic: is_basic
	is_expanded: is_expanded

end
