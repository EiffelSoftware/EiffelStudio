indexing
	description: "Special optimization on calls where target is a basic type."
	date: "$Date$"
	revision: "$Revision$"
	limitation: "We cannot handle `set_item', `copy', `standard_copy' or `deep_copy'%
			%because when called on attributes whose types are basic types we cannot%
			%store the result back to the attribute."

class SPECIAL_FEATURES

inherit
	BYTE_CONST

	SHARED_INCLUDE

	SHARED_WORKBENCH

	SHARED_IL_CODE_GENERATOR

	IL_CONST

feature -- Access

	has (feature_name_id: INTEGER; compilation_type: BOOLEAN; target_type: BASIC_I): BOOLEAN is
			-- Does Current have `feature_name_id'?
		require
			valid_feature_name_id: feature_name_id > 0
		local
			char: CHAR_I
		do
			if compilation_type then
				Result := c_type_table.has (feature_name_id)
				if Result then
					function_type := c_type_table.found_item
					if function_type = out_type and then target_type.is_char then
						char ?= target_type
						Result := not char.is_wide
					end
				end
			else
				Result := byte_type_table.has (feature_name_id)
				if Result then
					function_type := byte_type_table.found_item
				end
			end
		end

feature -- Access code

	function_type: INTEGER
			-- Is current call based on an operator instead of a function
			-- call?

feature -- Status

	valid_function_type (type: INTEGER): BOOLEAN is
			-- Is `f' a valid function type supported by Current.
		do
			Result := type >= min_type_id and type <= max_type_id
		ensure
			valid: Result implies (type >= min_type_id and type <= max_type_id)
		end

feature -- Byte code special generation

	make_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Generate byte code sequence that will be used with basic types.
		require
			basic_type_not_void: basic_type /= Void
			valid_function_type: valid_function_type (function_type)
		do
			inspect function_type
			when equal_type then
				ba.append (Bc_eq)
			when to_integer_8_type then
				ba.append (Bc_cast_long)
				ba.append_integer (8)
			when to_integer_16_type then
				ba.append (Bc_cast_long)
				ba.append_integer (16)
			when to_integer_32_type then
				ba.append (Bc_cast_long)
				ba.append_integer (32)
			when to_integer_64_type then
				ba.append (Bc_cast_long)
				ba.append_integer (64)
			when max_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_max)
			when min_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_min)
			when generator_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_generator)
			when offset_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_offset)
			when zero_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_zero)
			when one_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_one)
			when default_type then
				make_default_code (ba, type_of (basic_type))
			when bit_and_type..bit_test_type then
				check integer_type: type_of (basic_type) = integer_type end
				make_bit_operation_code (ba, function_type)
			end
		end

feature -- C special code generation

	generate (buffer: GENERATION_BUFFER; basic_type: BASIC_I; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
		require
			valid_output_buffer: buffer /= Void
			valid_target: target /= Void
			valid_function_type: valid_function_type (function_type)
		local
			parameter: REGISTRABLE
		do
			if parameters /= Void then
				parameter := parameters.first
			end
			inspect function_type
			when equal_type then
				generate_equal (buffer, target, parameter)
			when to_integer_8_type then
				buffer.putstring ("(EIF_INTEGER_8) ")
				target.print_register
			when to_integer_16_type then
				buffer.putstring ("(EIF_INTEGER_16) ")
				target.print_register
			when to_integer_32_type then
				buffer.putstring ("(EIF_INTEGER_32) ")
				target.print_register
			when to_integer_64_type then
				buffer.putstring ("(EIF_INTEGER_64) ")
				target.print_register
			when offset_type then
				generate_offset (buffer, type_of (basic_type), target, parameter)
			when out_type then
				generate_out (buffer, type_of (basic_type), target)
			when hash_code_type then
				generate_hashcode (buffer, type_of (basic_type), target)
			when max_type then
				generate_max (buffer, type_of (basic_type), target, parameter)
			when min_type then
				generate_min (buffer, type_of (basic_type), target, parameter)
			when abs_type then
				generate_abs (buffer, type_of (basic_type), target)
			when generator_type then
				generate_generator (buffer, type_of (basic_type))
			when default_type then
				generate_default (buffer, type_of (basic_type))
			when bit_and_type..bit_test_type then
				check
					integer_type: type_of (basic_type) = integer_type
				end
				generate_bit_operation (buffer, function_type, target, parameter)
			when set_bit_with_mask_type then
				check
					integer_type: type_of (basic_type) = integer_type
					parameters_not_void: parameters /= Void
				end
				generate_set_bit_with_mask (buffer, target, parameters)
			when zero_type then
				generate_zero (buffer, type_of (basic_type))
			when one_type then
				generate_one (buffer, type_of (basic_type))
			when memory_move, memory_copy, memory_set, memory_alloc, memory_free then
				check pointer_type: type_of (basic_type) = pointer_type end
				generate_memory_routine (buffer, function_type, target, parameters)
			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls

	c_type_table: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (40)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.is_equal_name_id)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.standard_is_equal_name_id)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.deep_equal_name_id)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.standard_deep_equal_name_id)
			Result.put (out_type, feature {PREDEFINED_NAMES}.out_name_id)
			Result.put (hash_code_type, feature {PREDEFINED_NAMES}.hash_code_name_id)
			Result.put (hash_code_type, feature {PREDEFINED_NAMES}.code_name_id)
			Result.put (max_type, feature {PREDEFINED_NAMES}.max_name_id)
			Result.put (min_type, feature {PREDEFINED_NAMES}.min_name_id)
			Result.put (abs_type, feature {PREDEFINED_NAMES}.abs_name_id)
			Result.put (zero_type, feature {PREDEFINED_NAMES}.zero_name_id)
			Result.put (one_type, feature {PREDEFINED_NAMES}.one_name_id)
			Result.put (generator_type, feature {PREDEFINED_NAMES}.generator_name_id)
			Result.put (generator_type, feature {PREDEFINED_NAMES}.generating_type_name_id)
			Result.put (to_integer_32_type, feature {PREDEFINED_NAMES}.truncated_to_integer_name_id)
			Result.put (to_integer_8_type, feature {PREDEFINED_NAMES}.to_integer_8_name_id)
			Result.put (to_integer_16_type, feature {PREDEFINED_NAMES}.to_integer_16_name_id)
			Result.put (to_integer_32_type, feature {PREDEFINED_NAMES}.to_integer_name_id)
			Result.put (to_integer_32_type, feature {PREDEFINED_NAMES}.to_integer_32_name_id)
			Result.put (to_integer_64_type, feature {PREDEFINED_NAMES}.to_integer_64_name_id)
			Result.put (offset_type, feature {PREDEFINED_NAMES}.infix_plus_name_id)
			Result.put (default_type, feature {PREDEFINED_NAMES}.default_name_id)
			Result.put (bit_and_type, feature {PREDEFINED_NAMES}.bit_and_name_id)
			Result.put (bit_and_type, feature {PREDEFINED_NAMES}.infix_and_name_id)
			Result.put (bit_or_type, feature {PREDEFINED_NAMES}.bit_or_name_id)
			Result.put (bit_or_type, feature {PREDEFINED_NAMES}.infix_or_name_id)
			Result.put (bit_xor_type, feature {PREDEFINED_NAMES}.bit_xor_name_id)
			Result.put (bit_not_type, feature {PREDEFINED_NAMES}.bit_not_name_id)
			Result.put (bit_shift_left_type, feature {PREDEFINED_NAMES}.bit_shift_left_name_id)
			Result.put (bit_shift_left_type, feature {PREDEFINED_NAMES}.infix_shift_left_name_id)
			Result.put (bit_shift_right_type, feature {PREDEFINED_NAMES}.bit_shift_right_name_id)
			Result.put (bit_shift_right_type, feature {PREDEFINED_NAMES}.infix_shift_right_name_id)
			Result.put (bit_test_type, feature {PREDEFINED_NAMES}.bit_test_name_id)
			Result.put (memory_copy, feature {PREDEFINED_NAMES}.memory_copy_name_id)
			Result.put (memory_move, feature {PREDEFINED_NAMES}.memory_move_name_id)
			Result.put (memory_set, feature {PREDEFINED_NAMES}.memory_set_name_id)
			Result.put (memory_alloc, feature {PREDEFINED_NAMES}.memory_alloc_name_id)
			Result.put (memory_free, feature {PREDEFINED_NAMES}.memory_free_name_id)
			Result.put (set_bit_with_mask_type, feature {PREDEFINED_NAMES}.set_bit_with_mask_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.set_item_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.copy_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.deep_copy_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.standard_copy_name_id)
		end

	byte_type_table: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (25)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.is_equal_name_id)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.standard_is_equal_name_id)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.deep_equal_name_id)
			Result.put (equal_type, feature {PREDEFINED_NAMES}.standard_deep_equal_name_id)
			Result.put (max_type, feature {PREDEFINED_NAMES}.max_name_id)
			Result.put (min_type, feature {PREDEFINED_NAMES}.min_name_id)
			Result.put (generator_type, feature {PREDEFINED_NAMES}.generator_name_id)
			Result.put (generator_type, feature {PREDEFINED_NAMES}.generating_type_name_id)
			Result.put (offset_type, feature {PREDEFINED_NAMES}.infix_plus_name_id)
			Result.put (zero_type, feature {PREDEFINED_NAMES}.zero_name_id)
			Result.put (one_type, feature {PREDEFINED_NAMES}.one_name_id)
			Result.put (default_type, feature {PREDEFINED_NAMES}.default_name_id)
			Result.put (bit_and_type, feature {PREDEFINED_NAMES}.bit_and_name_id)
			Result.put (bit_and_type, feature {PREDEFINED_NAMES}.infix_and_name_id)
			Result.put (bit_or_type, feature {PREDEFINED_NAMES}.bit_or_name_id)
			Result.put (bit_or_type, feature {PREDEFINED_NAMES}.infix_or_name_id)
			Result.put (bit_xor_type, feature {PREDEFINED_NAMES}.bit_xor_name_id)
			Result.put (bit_not_type, feature {PREDEFINED_NAMES}.bit_not_name_id)
			Result.put (bit_shift_left_type, feature {PREDEFINED_NAMES}.bit_shift_left_name_id)
			Result.put (bit_shift_left_type, feature {PREDEFINED_NAMES}.infix_shift_left_name_id)
			Result.put (bit_shift_right_type, feature {PREDEFINED_NAMES}.bit_shift_right_name_id)
			Result.put (bit_shift_right_type, feature {PREDEFINED_NAMES}.infix_shift_right_name_id)
			Result.put (bit_test_type, feature {PREDEFINED_NAMES}.bit_test_name_id)
			Result.put (to_integer_32_type, feature {PREDEFINED_NAMES}.truncated_to_integer_name_id)
			Result.put (to_integer_8_type, feature {PREDEFINED_NAMES}.to_integer_8_name_id)
			Result.put (to_integer_16_type, feature {PREDEFINED_NAMES}.to_integer_16_name_id)
			Result.put (to_integer_32_type, feature {PREDEFINED_NAMES}.to_integer_name_id)
			Result.put (to_integer_32_type, feature {PREDEFINED_NAMES}.to_integer_32_name_id)
			Result.put (to_integer_64_type, feature {PREDEFINED_NAMES}.to_integer_64_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.set_item_name_id)
		end

feature {NONE} -- Fast access to feature name

	min_type_id: INTEGER is 1
	equal_type: INTEGER is 1
	set_item_type: INTEGER is 2
	out_type: INTEGER is 3
	hash_code_type: INTEGER is 4
	max_type: INTEGER is 5
	min_type: INTEGER is 6
	abs_type: INTEGER is 7
	generator_type: INTEGER is 8
	to_integer_32_type: INTEGER is 9
	offset_type: INTEGER is 10
	default_type: INTEGER is 11
	bit_and_type: INTEGER is 12
	bit_or_type: INTEGER is 13
	bit_xor_type: INTEGER is 14
	bit_not_type: INTEGER is 15
	bit_shift_left_type: INTEGER is 16
	bit_shift_right_type: INTEGER is 17
	bit_test_type: INTEGER is 18
	zero_type: INTEGER is 19
	one_type: INTEGER is 20
	memory_move: INTEGER is 21
	memory_copy: INTEGER is 22
	memory_set: INTEGER is 23
	to_integer_8_type: INTEGER is 24
	to_integer_16_type: INTEGER is 25
	to_integer_64_type: INTEGER is 26
	set_bit_with_mask_type: INTEGER is 27
	memory_alloc: INTEGER is 28
	memory_free: INTEGER is 29
	max_type_id: INTEGER is 29

feature {NONE} -- Byte code generation

	make_default_code (ba: BYTE_ARRAY; type_of_basic: INTEGER) is
			-- Make byte code for call on `default' where target is a basic type.
		require
			ba_not_void: ba /= Void
		do
			inspect
				type_of_basic
			when boolean_type then
				ba.append (Bc_bool)
				ba.append ('%U')
			when character_type then
				if is_wide then
					ba.append (Bc_wchar)
					ba.append_integer (0)
				else
					ba.append (Bc_char)
					ba.append ('%U')
				end
			when integer_type then
				inspect
					integer_size
				when 8 then
					ba.append (Bc_int8)
					ba.append ('%U')
				when 16 then
					ba.append (Bc_int16)
					ba.append_short_integer (0)
				when 32 then
					ba.append (Bc_int32)
					ba.append_integer (0)
				when 64 then
					ba.append (Bc_int64)
					ba.append_integer (0)
				end
			when pointer_type then
				ba.append (Bc_null_pointer)
			when real_type, double_type then
				ba.append (Bc_double)
				ba.append_real (0.0)
			end
		end

	make_bit_operation_code (ba: BYTE_ARRAY; op: INTEGER) is
			-- Make byte code for call on bit operations from INTEGER.
		require
			ba_not_void: ba /= Void
		do
			ba.append (Bc_int_bit_op)
 			inspect
 				op
 			when bit_and_type then
 				ba.append (Bc_int_bit_and)
 			when bit_or_type then
 				ba.append (Bc_int_bit_or)
 			when bit_xor_type then
 				ba.append (Bc_int_bit_xor)
 			when bit_not_type then
 				ba.append (Bc_int_bit_not)
			when bit_shift_left_type then
 				ba.append (Bc_int_bit_shift_left)
 			when bit_shift_right_type then
 				ba.append (Bc_int_bit_shift_right)
 			when bit_test_type then
 				ba.append (Bc_int_bit_test)
			end
		end

feature {NONE} -- C code generation

	generate_equal (buffer: GENERATION_BUFFER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `equal' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			target.print_register
			buffer.putchar (' ')
			buffer.putchar ('=')
			buffer.putchar ('=')
			buffer.putchar (' ')
			parameter.print_register
		end

	generate_offset (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `+' where target and parameter
			-- are both basic types. Only `POINTER' and `CHARACTER' are handled, the
			-- other basic types have their own handling by the compiler.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when pointer_type then
				buffer.putstring ("RTPOF(")
				target.print_register
				buffer.putchar (',')
				parameter.print_register
				buffer.putchar (')')
			when character_type then
				if is_wide then
					buffer.putstring ("(EIF_WIDE_CHAR) (((EIF_INTEGER_32) ")
				else
					buffer.putstring ("(EIF_CHARACTER) (((EIF_INTEGER_32) ")
				end
				target.print_register
				buffer.putstring (") + ")
				parameter.print_register
				buffer.putchar (')')
			end
		end

	generate_out (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE) is
			-- Generate fast wrapper for call on `out' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			if type_of_basic = boolean_type then
				buffer.putchar ('(');
				target.print_register
				buffer.putstring (" ? makestr (%"True%", 4) : makestr (%"False%", 5))")

					-- Add `eif_plug.h' for C compilation where `makestr' is -- declared
				shared_include_queue.put (feature {PREDEFINED_NAMES}.eif_plug_header_name_id)
			else
				inspect
					type_of_basic
				when character_type then
					check
						not_is_wide: not is_wide
					end
					buffer.putstring ("c_outc(")
				when integer_type then
					inspect
						integer_size
					when 8, 16, 32 then buffer.putstring ("c_outi(")
					when 64 then buffer.putstring ("c_outi64(")
					end
				when pointer_type then
					buffer.putstring ("c_outp(")
				when real_type then
					buffer.putstring ("c_outr(")
				when double_type then
					buffer.putstring ("c_outd(")
				end
				target.print_register
				buffer.putchar (')')

					-- Add `eif_out.h' for C compilation where all output functions are declared.
				shared_include_queue.put (feature {PREDEFINED_NAMES}.eif_out_header_name_id)
			end
		end

	generate_hashcode (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE) is
			-- Generate fast wrapper for call on `hash_code' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
			when boolean_type then
				buffer.putstring ("1L")
			when character_type then
				buffer.putstring ("(EIF_INTEGER_32) (")
				target.print_register
				buffer.putchar(')')
			when integer_type then
				buffer.putstring ("(EIF_INTEGER_32) (")
				target.print_register
				buffer.putstring (" >= 0 ? ")
				target.print_register
				buffer.putstring (" : -(")
				target.print_register
				buffer.putstring (" + 1))")
			when pointer_type then
				buffer.putstring ("((EIF_INTEGER_32) ")
				target.print_register
				buffer.putstring (" >= 0 ? (EIF_INTEGER_32) ")	
				target.print_register
				buffer.putstring (" : -((EIF_INTEGER_32) ")
				target.print_register
				buffer.putchar(')')
				buffer.putchar(')')
			when real_type, double_type then
				buffer.putchar('(')
				target.print_register
				buffer.putstring (" >= 0.0 ? (EIF_INTEGER_32) (")
				target.print_register
				buffer.putstring (" + 1) : (EIF_INTEGER_32) (-")
				target.print_register
				buffer.putstring (" + 1 ))")
			end
		end

	generate_generator (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `generator' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
		do
			inspect
				type_of_basic
			when boolean_type then
				buffer.putstring (" RTMS_EX(%"BOOLEAN%", 7)")
			when character_type then
				if is_wide then
					buffer.putstring (" RTMS_EX(%"WIDE_CHARACTER%", 14)")
				else
					buffer.putstring (" RTMS_EX(%"CHARACTER%", 9)")
				end
			when integer_type then
				buffer.putstring (" RTMS_EX(%"INTEGER")
				inspect
					integer_size
				when 8 then buffer.putstring ("_8%", 9)")
				when 16 then buffer.putstring ("_16%", 10)")
				when 32 then buffer.putstring ("%", 7)")
				when 64 then buffer.putstring ("_64%", 10)")
				end
			when pointer_type then
				buffer.putstring (" RTMS_EX(%"POINTER%", 7)")
			when real_type then
				buffer.putstring (" RTMS_EX(%"REAL%", 4)")
			when double_type then
				buffer.putstring (" RTMS_EX(%"DOUBLE%", 6)")
			end
		end

	generate_max (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `max' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type, integer_type, real_type, double_type then
				buffer.putchar ('(')
				target.print_register
				buffer.putchar ('>')
				parameter.print_register
				buffer.putchar ('?')
				target.print_register
				buffer.putchar (':')
				parameter.print_register
				buffer.putchar (')')
			end
		end

	generate_min (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `min' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type, integer_type, real_type, double_type then
				buffer.putchar ('(')
				target.print_register
				buffer.putchar ('<')
				parameter.print_register
				buffer.putchar ('?')
				target.print_register
				buffer.putchar (':')
				parameter.print_register
				buffer.putchar (')')
			end
		end

	generate_abs (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE) is
			-- Generate fast wrapper for call on `abs' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
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
		end

	generate_memory_routine (buffer: GENERATION_BUFFER; f_type: INTEGER; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
			-- Generate fast wrapper for call on `memory_copy',
			-- `memory_move' and `memory_set' from POINTER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			valid_paramaters: f_type /= memory_free implies parameters /= Void
			valid_function_type:
				f_type = memory_move or f_type = memory_copy or
				f_type = memory_set or f_type = memory_free or
				f_type = memory_alloc
		do
			shared_include_queue.put (feature {PREDEFINED_NAMES}.string_header_name_id)

			inspect
				f_type
			when memory_move then
				buffer.putstring ("memmove((void *)")
			when memory_copy then
				buffer.putstring ("memcpy((void *)")
			when memory_set then
				buffer.putstring ("memset((void *)")
			when memory_alloc then
				buffer.putstring ("malloc((size_t)")
			when memory_free then
				buffer.putstring ("free(")
			end
			
			if f_type /= memory_alloc then
				target.print_register
			end
			
			inspect
				f_type
			when memory_free, memory_alloc then
			when memory_set then
				buffer.putstring (", (int) ")
			else
				buffer.putstring (", (const void *) ")
			end

			inspect
				f_type
			when memory_move, memory_set, memory_copy then
				check
					valid_parameters: parameters.count = 2
				end
				parameters.i_th (1).print_register
				buffer.putstring (", (size_t) ")
				parameters.i_th (2).print_register
			when memory_alloc then
				check
					valid_paramters: parameters.count = 1
				end
				parameters.i_th (1).print_register
			else
			end

			buffer.putstring (")")
		end

	generate_default (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `default' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
		do
			inspect
				type_of_basic
			when boolean_type then
				buffer.putstring ("(EIF_BOOLEAN) 0")
			when character_type then
				if is_wide then
					buffer.putstring ("(EIF_WIDE_CHAR) 0")
				else
					buffer.putstring ("(EIF_CHARACTER) 0")
				end
			when integer_type then
				inspect
					integer_size
				when 8 then buffer.putstring ("(EIF_INTEGER_8) 0")
				when 16 then buffer.putstring ("(EIF_INTEGER_16) 0")
				when 32 then buffer.putstring ("(EIF_INTEGER_32) 0")
				when 64 then buffer.putstring ("(EIF_INTEGER_64) 0")
				end
			when pointer_type then
				buffer.putstring ("(EIF_POINTER) 0")
			when real_type then
				buffer.putstring ("(EIF_REAL) 0")
			when double_type then
				buffer.putstring ("(EIF_DOUBLE) 0")
			end
		end

	generate_bit_operation (buffer: GENERATION_BUFFER; op: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `bit_xxx' where target and parameter
			-- are both basic types of type INTEGER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void:  (op /= bit_not_type) implies parameter /= Void
		do
			if op = bit_not_type then
				buffer.putstring ("eif_bit_not(")
				target.print_register
			else
				inspect
					op
				when bit_and_type then
					buffer.putstring ("eif_bit_and(")
				when bit_or_type then
					buffer.putstring ("eif_bit_or(")
				when bit_xor_type then
					buffer.putstring ("eif_bit_xor(")
				when bit_shift_left_type then
					buffer.putstring ("eif_bit_shift_left(")
				when bit_shift_right_type then
					buffer.putstring ("eif_bit_shift_right(")
				when bit_test_type then
					buffer.putstring ("eif_bit_test(")
				end
				target.print_register
				buffer.putchar (',')
				parameter.print_register
			end
			buffer.putchar (')')

				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue.put (feature {PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_set_bit_with_mask (buffer: GENERATION_BUFFER; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
			-- Generate fast wrapper for call on `bit_xxx' where target and parameter
			-- are both basic types of type INTEGER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameters_not_void: parameters /= Void
			valid_parameters: parameters.count = 2
		do
			buffer.putchar ('(')
			parameters.i_th (1).print_register
			buffer.putchar ('?')
			generate_bit_operation (buffer, bit_or_type, target, parameters.i_th (2))	
			buffer.putchar (':')
			buffer.putstring ("eif_bit_and(")
			target.print_register
			buffer.putstring (", eif_bit_not(")
			parameters.i_th (2).print_register
			buffer.putchar (')')
			buffer.putchar (')')
			buffer.putchar (')')

				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue.put (feature {PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_zero (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `zero' for INTEGER,
			-- REAL and DOUBLE.
		require
			buffer_not_void: buffer /= Void
			valid_type_of_basic: type_of_basic = integer_type or else
								 type_of_basic = real_type or else
								 type_of_basic = double_type
		do
			inspect
				type_of_basic
			when integer_type then
				buffer.putstring ("0")
			when real_type, double_type then
				buffer.putstring ("0.0")
			end
		end

	generate_one (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `one' for INTEGER,
			-- REAL and DOUBLE.
		require
			buffer_not_void: buffer /= Void
			valid_type_of_basic: type_of_basic = integer_type or else
								 type_of_basic = real_type or else
								 type_of_basic = double_type
		do
			inspect
				type_of_basic
			when integer_type then
				buffer.putstring ("1")
			when real_type, double_type then
				buffer.putstring ("1.0")
			end
		end

feature {NONE} -- Type information

	boolean_type: INTEGER is 1
	character_type: INTEGER is 2
	integer_type: INTEGER is 3
	pointer_type: INTEGER is 4
	real_type: INTEGER is 5
	double_type: INTEGER is 6
			-- Constant defining type

	integer_size: INTEGER
			-- Size of integer when `type_of' returns `integer_type'.

	is_wide: BOOLEAN
			-- Is `character_type' returned by `type_of' a WIDE_CHARACTER?

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
		do
			bool ?= b
			if bool /= Void then
				Result := boolean_type
			else
				char ?= b
				if char /= Void then
					Result := character_type
					is_wide := char.is_wide
				else
					long ?= b
					if long /= Void then
						Result := integer_type
						integer_size := long.size
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
