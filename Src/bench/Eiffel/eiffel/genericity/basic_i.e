deferred class BASIC_I

inherit
	CL_TYPE_I
		rename
			is_void as cl_type_is_void
		undefine
			type_a
		redefine
			is_basic, is_reference, c_type, base_class, is_valid,
			cecil_value
		end

	TYPE_C
		undefine
			is_bit
		end

	SHARED_C_LEVEL

	BYTE_CONST

feature

	c_type: TYPE_C is
			-- C type
		do
			Result := Current
		end

	is_reference: BOOLEAN is False
			-- Type is not a reference.

	is_basic: BOOLEAN is True
			-- Type is a basic type.

	is_valid: BOOLEAN is True
			-- A Basic type is always in the system

	generate_byte_code_cast (ba: BYTE_ARRAY) is
			-- Code for the interpreter cast
		do
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		deferred
		end

	associated_dtype: INTEGER is
			-- Dynamic type of associated reference class
		do
			Result := associated_reference.type_id - 1
		end

	base_class: CLASS_C is
			-- Associated class
		do
			if System.il_generation then
				Result := type_a.associated_class
			else
				Result := associated_reference.associated_class
			end
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
			buffer.putstring (" = ")
				-- Even though we pass Current (which does not correspond
				-- to the associated reference class) to CREATE_TYPE, it works
				-- because `base_class' is redefined so that it always return
				-- the associated reference class and `base_class' is called
				-- by `associated_class_type' which is called by CREATE_TYPE.
			(create {CREATE_TYPE}.make (Current)).generate
			buffer.putstring (", *")
			generate_access_cast (buffer)
			reg.print_register
			buffer.putstring (" = ")
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
--			buffer.putstring (" = ")
--			buffer.putchar ('*')
--			generate_access_cast (buffer)
--			reg.print_register
		end

	cecil_value: INTEGER is
		do
			Result := sk_value
		end

feature

	generate_basic_creation (buffer : GENERATION_BUFFER) is
			-- Creation of entities of basic type
		require
			valid_buffer: buffer /= Void
		do
			buffer.putchar ('(')
			generate_cast (buffer)
			buffer.putstring ("0)")
		end
	
	make_basic_creation_byte_code (ba : BYTE_ARRAY) is
			-- Creation of entities of basic type
		require
			valid_array: ba /= Void
		deferred
		end 
end
