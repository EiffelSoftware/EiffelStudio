class BIN_POWER_B

inherit
	NUM_BINARY_B
		rename
			il_power as il_operator_constant
		redefine
			print_register,
			generate_standard_il
		end

	SHARED_INCLUDE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_power_b (Current)
		end

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		local
			l_power_nb: REAL_CONST_B
			l_power_value: DOUBLE
		do
				-- Generate value to be elevated to a given power.
			left.generate_il
			il_generator.convert_to_real_64

			l_power_nb ?= right
			if l_power_nb /= Void then
				l_power_value := l_power_nb.value.to_double

				if l_power_value = 0.0 then
						-- Removed value, since not needed.
					il_generator.pop
					il_generator.put_real_64_constant (1.0)
				elseif l_power_value = 1.0 then
						-- Nothing to be done
				elseif l_power_value = 2.0 then
					il_generator.duplicate_top
					il_generator.generate_binary_operator (il_star)
				elseif l_power_value = 3.0 then
					il_generator.duplicate_top
					il_generator.duplicate_top
					il_generator.generate_binary_operator (il_star)
					il_generator.generate_binary_operator (il_star)
				else
					right.generate_il
					il_generator.convert_to_real_64
					il_generator.generate_binary_operator (il_operator_constant)
				end
			else
				right.generate_il
				il_generator.convert_to_real_64
				il_generator.generate_binary_operator (il_operator_constant)
			end
		end

feature -- C code generation

	print_register is
			-- Print expression value
		local
			buf: GENERATION_BUFFER
			power_nb: REAL_CONST_B
			power_value: DOUBLE
			done: BOOLEAN
			l_type: TYPE_I
		do
			buf := buffer
			power_nb ?= right
			if power_nb /= Void then
				power_value := power_nb.value.to_double
				if power_value = 0.0 then
					done := True
					buf.put_string ("(EIF_REAL_64) 1")
				elseif power_value = 1.0 then
					done := True
					l_type := context.real_type (left.type)
					l_type.c_type.generate_conversion_to_real_64 (buf)
					left.print_register
					buf.put_character (')')
				elseif power_value = 2.0 or power_value = 3.0 then
					done := True
					buf.put_string ("(EIF_REAL_64) (")
					l_type := context.real_type (left.type)
					l_type.c_type.generate_conversion_to_real_64 (buf)
					left.print_register
					buf.put_string (") * ")
					l_type.c_type.generate_conversion_to_real_64 (buf)
					left.print_register
					if power_value = 3.0 then
						buf.put_string (") * ")
						l_type.c_type.generate_conversion_to_real_64 (buf)
						left.print_register
						buf.put_character (')')
					else
						buf.put_character (')')
					end
					buf.put_character (')')
				end
			end

			if not done then
					-- No optimization could have been done, so we generate the
					-- call to `pow'.
				shared_include_queue.put (Names_heap.math_header_name_id)
				buf.put_string ("(EIF_REAL_64) pow (")
				l_type := context.real_type (left.type)
				l_type.c_type.generate_conversion_to_real_64 (buf)
				left.print_register;
				buf.put_string ("), ");
				l_type := context.real_type (right.type)
				l_type.c_type.generate_conversion_to_real_64 (buf)
				right.print_register;
				buf.put_character (')');
				buf.put_character (')');
			end
		end;

end
