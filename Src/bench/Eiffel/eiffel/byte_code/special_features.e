indexing
	description: "Special optimization on calls on basic types"
	date: "$Date$"
	revision: "$Revision$"

class SPECIAL_FEATURES

inherit
	BYTE_CONST

feature -- Access

	has (feature_name: STRING; compilation_type: BOOLEAN): BOOLEAN is
			-- Does Current have `feature_name'?
		require
			feature_name_not_void: feature_name /= Void
			feature_name_exists: feature_name.count > 0
		do
			if compilation_type then
				Result := c_eiffel_table.has (feature_name)
				if Result then
					c_operation := c_eiffel_table.found_item
					function_type := function_type_table.item (feature_name)
				else
					c_operation := Void
				end
			else
				Result := byte_eiffel_table.has (feature_name)
				if Result then
					bc_code := byte_eiffel_table.found_item
					function_type := function_type_table.item (feature_name)
				else
					bc_code := '%U'
				end
			end
		end

feature -- Access code

	bc_code: CHARACTER
			-- Byte code constant associated to current special
			-- feature from find.

	c_operation: STRING
			-- C code constant associated to current special
			-- feature from find.

	function_type: INTEGER
			-- Is current call based on an operator instead of a function
			-- call?

feature -- Byte code special generation

	make_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
		do
			inspect function_type
			when equal_type, max_type, min_type ,generator_type, generating_type_type then
				ba.append (bc_code)
			end
		end

feature -- C special code generation

	generate (buffer: GENERATION_BUFFER; basic_type: BASIC_I; target, parameter: REGISTRABLE) is
		require
			valid_output_buffer: buffer /= Void
			valid_target: target /= Void
		do
			inspect function_type
			when equal_type then
				target.print_register
				buffer.putchar (' ')
				buffer.putstring (c_operation)
				buffer.putchar (' ')
				parameter.print_register
			when out_type then
				inspect type_of (basic_type)
				when boolean_type then
					buffer.putstring ("c_outb(")
				when character_type then
					buffer.putstring ("c_outc(")
				when integer_type then
					buffer.putstring ("c_outi(")
				when pointer_type then
					buffer.putstring ("c_outp(")
				when real_type then
					buffer.putstring ("c_outr(")
				when double_type then
					buffer.putstring ("c_outd(")
				end
				target.print_register
				buffer.putchar (')')
			when hash_code_type then
				inspect type_of (basic_type)
				when boolean_type then
					buffer.putstring ("1L")
				when character_type then
					buffer.putstring ("(EIF_INTEGER) (")
					target.print_register
					buffer.putchar(')')
				when integer_type then
					buffer.putchar('(')
					target.print_register
					buffer.putstring (" > 0 ? ")
					target.print_register
					buffer.putstring (" : (-")
					target.print_register
					buffer.putstring (" <= 0 ? 1L : -")
					target.print_register
					buffer.putchar(')')
					buffer.putchar(')')
				when pointer_type then
					buffer.putstring ("((EIF_INTEGER) ")
					target.print_register
					buffer.putstring (" >= 0 ? (EIF_INTEGER) ")	
					target.print_register
					buffer.putstring (" : -((EIF_INTEGER) ")
					target.print_register
					buffer.putchar(')')
					buffer.putchar(')')
				when real_type, double_type then
					buffer.putchar('(')
					target.print_register
					buffer.putstring (" >= 0.0 ? (EIF_INTEGER) (")
					target.print_register
					buffer.putstring (" + 1) : (EIF_INTEGER) (-")
					target.print_register
					buffer.putstring (" + 1 ))")
				end
			when max_type then
				inspect type_of (basic_type)
				when character_type, integer_type, real_type, double_type then
					buffer.putchar ('(')
					target.print_register
					buffer.putchar ('>')
					parameter.print_register
					buffer.putstring (" ? ")
					target.print_register
					buffer.putchar (':')
					parameter.print_register
					buffer.putchar (')')
				end
			when min_type then
				inspect type_of (basic_type)
				when character_type, integer_type, real_type, double_type then
					buffer.putchar ('(')
					target.print_register
					buffer.putchar ('<')
					parameter.print_register
					buffer.putstring (" ? ")
					target.print_register
					buffer.putchar (':')
					parameter.print_register
					buffer.putchar (')')
				end
			when abs_type then
				inspect type_of (basic_type)
				when integer_type, real_type, double_type then
					buffer.putchar ('(')
					target.print_register
					buffer.putstring (" > 0 ? ")
					target.print_register
					buffer.putchar (':')
					buffer.putchar ('-')
					target.print_register
					buffer.putchar (')')					
				end
			when generator_type, generating_type_type then
				inspect type_of (basic_type)
				when boolean_type then
					buffer.putstring (" RTMS_EX(%"BOOLEAN%", 7)")
				when character_type then
					buffer.putstring (" RTMS_EX(%"CHARACTER%", 9)")
				when integer_type then
					buffer.putstring (" RTMS_EX(%"INTEGER%", 7)")
				when pointer_type then
					buffer.putstring (" RTMS_EX(%"POINTER%", 7)")
				when real_type then
					buffer.putstring (" RTMS_EX(%"REAL%", 4)")
				when double_type then
					buffer.putstring (" RTMS_EX(%"DOUBLE%", 6)")
				end
			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls

	c_eiffel_table: HASH_TABLE [STRING, STRING] is
		once
			create Result.make (10)
			Result.put ("==", "is_equal")
			Result.put ("==", "standard_is_equal")
			Result.put ("==", "deep_equal")
			Result.put ("==", "standard_deep_equal")
--			Result.put ("=", "set_item")
			Result.put (Void, "out")
			Result.put (Void, "hash_code")
			Result.put (Void, "max")
			Result.put (Void, "min")
			Result.put (Void, "abs")
			Result.put (Void, "generator")
			Result.put (Void, "generating_type")
		end

	function_type_table: HASH_TABLE [INTEGER, STRING] is
		once
			create Result.make (10)
			Result.put (equal_type, "is_equal")
			Result.put (equal_type, "standard_is_equal")
			Result.put (equal_type, "deep_equal")
			Result.put (equal_type, "standard_deep_equal")
--			Result.put (set_item_type, "set_item")
			Result.put (out_type, "out")
			Result.put (hash_code_type, "hash_code")
			Result.put (max_type, "max")
			Result.put (min_type, "min")
			Result.put (abs_type, "abs")
			Result.put (generator_type, "generator")
			Result.put (generating_type_type, "generating_type")
		end

	byte_eiffel_table: HASH_TABLE [CHARACTER, STRING] is
		once
			create Result.make (10)
			Result.put (Bc_eq, "is_equal")
			Result.put (Bc_eq, "standard_is_equal")
			Result.put (Bc_eq, "deep_equal")
			Result.put (Bc_eq, "standard_deep_equal")
			Result.put (Bc_max, "max")
			Result.put (Bc_min, "min")
			Result.put (Bc_generator, "generator")
			Result.put (Bc_generator, "generating_type")
--			Result.put (Bc_set_item, "set_item")
		end


feature {NONE} -- Fast access to feature name

	equal_type: INTEGER is 1
	set_item_type: INTEGER is 2
	out_type: INTEGER is 3
	hash_code_type: INTEGER is 4
	max_type: INTEGER is 5
	min_type: INTEGER is 6
	abs_type: INTEGER is 7
	generator_type: INTEGER is 8
	generating_type_type: INTEGER is 9

feature {NONE} -- Type information

	boolean_type: INTEGER is 1
	character_type: INTEGER is 2
	integer_type: INTEGER is 3
	pointer_type: INTEGER is 4
	real_type: INTEGER is 5
	double_type: INTEGER is 6

	type_of (b: BASIC_I): INTEGER is
			-- Returns corresponding type constants to `b'.
		require
			b_not_void: b /= Void
			b_not_bit: not b.is_bit
		local
			bool: BOOLEAN_I
			char: CHAR_I
			long: LONG_I
			ptr: POINTER_I
			real: FLOAT_I
			d: DOUBLE_I
		do
			bool ?= b
			if bool /= Void then
				Result := boolean_type
			else
				char ?= b
				if char /= Void then
					Result := character_type
				else
					long ?= b
					if long /= Void then
						Result := integer_type
					else
						ptr ?= b
						if ptr /= Void then
							Result := pointer_type
						else
							real ?= b
							if real /= Void then
								Result := real_type
							else
								Result := double_type	
							end
						end
					end
				end
			end
		ensure
			valid_type: Result = boolean_type or else Result = character_type or else
						Result = integer_type or else Result = pointer_type or else
						Result = real_type or else Result = double_type
		end

end
