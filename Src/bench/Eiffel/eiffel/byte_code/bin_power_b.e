class BIN_POWER_B 

inherit
	NUM_BINARY_B
		rename
			Bc_power as operator_constant,
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

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		local
			l_power_nb: REAL_CONST_B
			l_power_value: DOUBLE
		do
				-- Generate value to be elevated to a given power.
			left.generate_il
			il_generator.convert_to_double

			l_power_nb ?= right
			if l_power_nb /= Void then
				l_power_value := l_power_nb.value.to_double
				
				if l_power_value = 0.0 then
						-- Removed value, since not needed.
					il_generator.pop
					il_generator.put_double_constant (1.0)
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
					il_generator.convert_to_double
					il_generator.generate_binary_operator (il_operator_constant)
				end
			else
				right.generate_il
				il_generator.convert_to_double
				il_generator.generate_binary_operator (il_operator_constant)
			end
		end

feature -- C code generation

	print_register is
			-- Print expression value
		local
			buf			: GENERATION_BUFFER
			power_nb	: REAL_CONST_B
			power_value	: DOUBLE
			done		: BOOLEAN
		do
			buf := buffer
			power_nb ?= right
			if power_nb /= Void then
				power_value := power_nb.value.to_double
				if power_value = 0.0 then
					done := True
					buf.putstring ("(EIF_DOUBLE) 1")
				elseif power_value = 1.0 then
					done := True
					buf.putstring ("(EIF_DOUBLE) (")
					left.print_register
					buf.putchar (')')
				elseif power_value = 2.0 or power_value = 3.0 then
					done := True
					buf.putstring ("(EIF_DOUBLE) ((EIF_DOUBLE)")
					left.print_register
					buf.putstring (" * (EIF_DOUBLE) ")
					left.print_register
					if power_value = 3.0 then
						buf.putstring (" * (EIF_DOUBLE) ")
						left.print_register
					end
					buf.putchar (')')
				end
			end

			if not done then
					-- No optimization could have been done, so we generate the
					-- call to `pow'.
				shared_include_queue.put (Names_heap.math_header_name_id)
				buf.putstring ("(EIF_DOUBLE) pow ((EIF_DOUBLE)");
				left.print_register;
				buf.putstring (",(EIF_DOUBLE)");
				right.print_register;
				buf.putchar (')');
			end
		end;

end
