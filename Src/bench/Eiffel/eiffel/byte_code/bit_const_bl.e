-- Enlarged byte code for Eiffel bit constant (allocated each time).

class
	BIT_CONST_BL 

inherit
	BIT_CONST_B
		redefine
			register, set_register,
			analyze, generate,
			propagate, print_register,
			is_simple_expr, unanalyze,
			allocates_memory
		end

feature 

	register: REGISTRABLE
			-- Where string is kept to ensure it is GC safe

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r
		end

	propagate (r: REGISTRABLE) is
			-- Propagate `r'
		do
			if not context.propagated then
				if r = No_register or else r.c_type.same_class_type (c_type) then
					register := r
					context.set_propagated
				end
			end
		end

	unanalyze is
			-- Undo analysis work.
		do
			register := Void
		end

	analyze is
			-- Analyze the bit value
		do
			get_register
		end

	generate is
			-- Generate the string
		do
			if register /= No_register then
				register.print_register
				generated_file.putstring (" = ")
				generate_bit
				generated_file.putchar (';')
				generated_file.new_line
			end
		end

	print_register is
			-- Print the string (or the register in which it is held)
		do
			if register = No_register then
				generate_bit
			else
				register.print_register
			end
		end

	generate_bit is
			-- Generate the bit constant (created Eiffel object)
		do
				-- RTMB is the macro used to create Eiffel strings from C ones
			generated_file.putstring ("RTMB(")
			generated_file.putchar('"')
			generated_file.escape_string (value)
			generated_file.putchar ('"')
			generated_file.putstring(", ")
			generated_file.put_integer (value.count)
			generated_file.putchar(')')
		end

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is True

end
